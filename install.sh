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

  ok "Neovim done — run 'nvim' to trigger lazy.nvim plugin install"
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

Components (default: all):
  symlinks    Dotfile symlinks (zsh, tmux, nvim)
  zsh         Zsh + Oh-My-Zsh + plugins
  nvim        Neovim
  tmux        tmux + TPM
  claude      Claude Code (--minimal)
  tools       CLI tools (fzf, rg, bat, lsd, lazygit)

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
    components=(symlinks zsh nvim tmux claude tools)
  fi

  for component in "${components[@]}"; do
    case "$component" in
      symlinks) setup_symlinks ;;
      zsh)      setup_zsh ;;
      nvim)     setup_nvim ;;
      tmux)     setup_tmux ;;
      claude)   setup_claude ;;
      tools)    setup_tools ;;
      -h|--help) usage; exit 0 ;;
      *) error "Unknown component: $component"; usage; exit 1 ;;
    esac
    echo
  done

  ok "All done!"
}

main "$@"
