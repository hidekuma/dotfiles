#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
PLATFORM="$(uname -s)"
ARCH="$(uname -m)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${BLUE}[INFO]${NC} $*"; }
ok()    { echo -e "${GREEN}[OK]${NC} $*"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*"; }

symlink() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    warn "Backing up $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  ok "$dst → $src"
}

# ─── Homebrew Bundle ────────────────────────────
setup_brew() {
  info "Installing Homebrew packages (Brewfile)..."

  if [ "$PLATFORM" != "Darwin" ]; then
    warn "Brewfile is macOS-only, skipping"
    return
  fi

  if ! command -v brew &>/dev/null; then
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  fi

  brew bundle --file="$DOTFILES/Brewfile" || warn "일부 패키지 설치 실패 — 로그 확인 후 재실행"

  if [ -f "$DOTFILES/Brewfile.local" ]; then
    info "Brewfile.local 적용"
    brew bundle --file="$DOTFILES/Brewfile.local" || warn "Brewfile.local 일부 실패"
  else
    warn "Brewfile.local 없음 (사내/개인 앱은 수동 설치 — SETUP.md 참조)"
  fi

  ok "Homebrew bundle done"
}

# ─── Dotfile Symlinks ───────────────────────────
setup_symlinks() {
  info "Setting up symlinks..."

  # zsh
  symlink "$DOTFILES/zshrc" "$HOME/.zshrc"
  if [ "$ARCH" = "arm64" ]; then
    symlink "$DOTFILES/zsh_profile.m1" "$HOME/.zsh_profile"
  else
    symlink "$DOTFILES/zsh_profile" "$HOME/.zsh_profile"
  fi

  # tmux
  symlink "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"

  # neovim
  mkdir -p "$HOME/.config"
  symlink "$DOTFILES/nvim" "$HOME/.config/nvim"

  ok "Symlinks done"
}

# ─── Zsh + Oh-My-Zsh ───────────────────────────
setup_zsh() {
  info "Setting up Zsh..."

  if ! command -v zsh &>/dev/null; then
    if [ "$PLATFORM" = "Darwin" ]; then
      brew install zsh
    else
      sudo apt-get install -y zsh
    fi
  fi

  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    ok "oh-my-zsh already installed"
  fi

  # plugins
  local custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  [ -d "$custom/plugins/zsh-syntax-highlighting" ] || \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom/plugins/zsh-syntax-highlighting"
  [ -d "$custom/plugins/zsh-autosuggestions" ] || \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$custom/plugins/zsh-autosuggestions"

  ok "Zsh done"
}

# ─── Neovim ─────────────────────────────────────
setup_nvim() {
  info "Setting up Neovim..."

  if ! command -v nvim &>/dev/null; then
    if [ "$PLATFORM" = "Darwin" ]; then
      brew install neovim
    else
      bash "$DOTFILES/bin/install-nvim.sh"
    fi
  else
    ok "neovim already installed ($(nvim --version | head -1))"
  fi

  # python provider — nvim/lua/user/lsp/configs.lua 가
  # ~/.virtualenvs/neovim3.12/bin/python 를 python3_host_prog 로 지정함
  local venv="$HOME/.virtualenvs/neovim3.12"
  if [ ! -x "$venv/bin/python" ]; then
    info "Creating neovim python venv → $venv"
    mkdir -p "$HOME/.virtualenvs"
    local py
    py="$(command -v python3.12 || command -v python3)"
    "$py" -m venv "$venv"
    "$venv/bin/pip" install --upgrade pip -q
  fi
  "$venv/bin/pip" install -q pynvim || warn "pynvim 설치 실패"
  if [ -f "$DOTFILES/requirements.neovim.txt" ]; then
    "$venv/bin/pip" install -q -r "$DOTFILES/requirements.neovim.txt" \
      || warn "requirements.neovim.txt 일부 실패 (핀 버전이 오래됨 — pynvim 만 있으면 동작)"
  fi
  ok "python provider: $venv/bin/python"

  # 플러그인 headless 설치 (lazy.nvim)
  info "Syncing lazy.nvim plugins (headless)..."
  nvim --headless "+Lazy! sync" +qa 2>&1 | tail -3 || warn "Lazy sync 경고 — nvim 을 한 번 직접 열어 확인"

  # mason LSP/treesitter 는 최초 기동 시 ensure_installed 로 설치됨
  info "Warming up Mason / treesitter (최대 90초)..."
  nvim --headless "+TSUpdateSync" +qa 2>&1 | tail -3 || true

  ok "Neovim done — 첫 nvim 실행 시 Mason 이 LSP 서버를 마저 내려받습니다 (:Mason 으로 확인)"
}

# ─── tmux + TPM ─────────────────────────────────
setup_tmux() {
  info "Setting up tmux..."

  if ! command -v tmux &>/dev/null; then
    if [ "$PLATFORM" = "Darwin" ]; then
      brew install tmux
    else
      sudo apt-get install -y tmux
    fi
  fi

  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  else
    ok "TPM already installed"
  fi

  ok "tmux done — press prefix + I inside tmux to install plugins"
}

# ─── Claude Code ────────────────────────────────
setup_claude() {
  info "Setting up Claude Code..."

  if [ -f "$DOTFILES/claude/setup.sh" ]; then
    bash "$DOTFILES/claude/setup.sh" --minimal
  else
    warn "claude/setup.sh not found, skipping"
  fi

  ok "Claude Code done"
}

# ─── Runtimes (node / python / java) ────────────
setup_runtime() {
  info "Setting up runtimes..."

  # nvm + node LTS
  export NVM_DIR="$HOME/.nvm"
  mkdir -p "$NVM_DIR"
  if [ -s "$(brew --prefix nvm 2>/dev/null)/nvm.sh" ]; then
    # shellcheck source=/dev/null
    . "$(brew --prefix nvm)/nvm.sh"
    if ! nvm ls --no-colors 2>/dev/null | grep -q 'lts'; then
      nvm install --lts
    fi
    nvm alias default 'lts/*' >/dev/null 2>&1 || true
    ok "node $(node -v 2>/dev/null || echo '?')"

    # nvim 이 쓰는 전역 npm 도구
    npm install -g neovim prettier @fsouza/prettierd eslint_d >/dev/null 2>&1 \
      || warn "npm 전역 패키지 일부 실패"
  else
    warn "nvm 미설치 — Brewfile 적용 후 다시 실행하세요"
  fi

  # virtualenvwrapper (zsh_profile.m1 이 참조)
  if [ ! -x "$HOME/.local/venvwrapper/bin/python" ]; then
    bash "$DOTFILES/bin/install-virtualenv.sh" || warn "virtualenvwrapper 설치 실패"
  else
    ok "virtualenvwrapper already installed"
  fi

  # SDKMAN (zshrc 마지막에서 source 함)
  if [ ! -d "$HOME/.sdkman" ]; then
    curl -s "https://get.sdkman.io" | bash || warn "SDKMAN 설치 실패"
  else
    ok "SDKMAN already installed"
  fi

  ok "Runtimes done"
}

# ─── macOS 시스템 설정 ──────────────────────────
setup_macos() {
  bash "$DOTFILES/macos.sh"
}

# ─── 워크스페이스 레포 clone ────────────────────
setup_repos() {
  bash "$DOTFILES/bin/clone-repos.sh"
}

# ─── 점검 ───────────────────────────────────────
setup_doctor() {
  bash "$DOTFILES/bin/doctor.sh"
}

# ─── CLI tools (macOS) ──────────────────────────
setup_tools() {
  info "Setting up CLI tools..."

  if [ "$PLATFORM" != "Darwin" ]; then
    warn "Tool install only supported on macOS, skipping"
    return
  fi

  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  local tools=(fzf ripgrep bat lsd lazygit)
  for tool in "${tools[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
      brew install "$tool"
    fi
  done

  ok "CLI tools done"
}

# ─── Main ───────────────────────────────────────
usage() {
  cat <<EOF
Usage: $0 [OPTIONS] [COMPONENTS...]

Components (default: brew symlinks zsh nvim tmux claude runtime):
  brew        Homebrew + Brewfile (+ Brewfile.local)
  symlinks    Dotfile symlinks (zsh, tmux, nvim)
  zsh         Zsh + Oh-My-Zsh + plugins
  nvim        Neovim + python provider + lazy.nvim 플러그인
  tmux        tmux + TPM
  claude      Claude Code (--minimal)
  runtime     node(nvm) / virtualenvwrapper / SDKMAN / npm 전역툴
  tools       CLI tools (fzf, rg, bat, lsd, lazygit)

Opt-in (기본 실행 안 함):
  macos       macOS 시스템 기본값 (키 리피트, Finder, Dock 등)
  repos       워크스페이스 레포 clone (repos.local.txt 필요)
  doctor      설치 상태 점검

Options:
  -h, --help  Show this help
EOF
}

main() {
  echo -e "${BLUE}"
  echo '╦ ╦╦╔╦╗╔═╗╦╔═╦ ╦╔╦╗╔═╗  ╔╦╗╔═╗╔╦╗╔═╗╦╦  ╔═╗╔═╗'
  echo '╠═╣║ ║║║╣ ╠╩╗║ ║║║║╠═╣   ║║║ ║ ║ ╠╣ ║║  ║╣ ╚═╗'
  echo '╩ ╩╩═╩╝╚═╝╩ ╩╚═╝╩ ╩╩ ╩  ═╩╝╚═╝ ╩ ╚  ╩╩═╝╚═╝╚═╝'
  echo -e "${NC}"
  info "Platform: $PLATFORM ($ARCH)"
  info "Dotfiles: $DOTFILES"
  echo

  local components=("$@")

  if [ ${#components[@]} -eq 0 ]; then
    components=(brew symlinks zsh nvim tmux claude runtime)
  fi

  for component in "${components[@]}"; do
    case "$component" in
      brew)     setup_brew ;;
      symlinks) setup_symlinks ;;
      zsh)      setup_zsh ;;
      nvim)     setup_nvim ;;
      tmux)     setup_tmux ;;
      claude)   setup_claude ;;
      runtime)  setup_runtime ;;
      tools)    setup_tools ;;
      macos)    setup_macos ;;
      repos)    setup_repos ;;
      doctor)   setup_doctor ;;
      -h|--help) usage; exit 0 ;;
      *) error "Unknown component: $component"; usage; exit 1 ;;
    esac
    echo
  done

  ok "All done!"
}

main "$@"
