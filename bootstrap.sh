#!/usr/bin/env bash
#
# bootstrap.sh — 새 맥(비상용 포함) 원큐 세팅
#
# 공장초기화 상태에서 아래 한 줄이면 끝:
#
#   curl -fsSL https://raw.githubusercontent.com/hidekuma/dotfiles/main/bootstrap.sh | bash
#
# 또는 이미 dotfiles를 받았다면:
#
#   ~/dotfiles/bootstrap.sh
#
# 하는 일 (전부 idempotent — 몇 번 돌려도 안전):
#   1. Xcode Command Line Tools
#   2. Homebrew
#   3. dotfiles clone (없을 때만)
#   4. install.sh 전체 실행 (brew / symlinks / zsh / nvim / tmux / claude / runtime)
#   5. doctor 로 결과 점검
#
# 수동으로 남는 것(시크릿·사내앱)은 SETUP.md 참조.

set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
REPO_URL="https://github.com/hidekuma/dotfiles.git"
LOG="$HOME/.bootstrap.log"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; BLUE='\033[0;34m'; NC='\033[0m'
info()  { echo -e "${BLUE}[INFO]${NC} $*"  | tee -a "$LOG"; }
ok()    { echo -e "${GREEN}[OK]${NC} $*"   | tee -a "$LOG"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $*"| tee -a "$LOG"; }
error() { echo -e "${RED}[ERROR]${NC} $*"  | tee -a "$LOG"; }

banner() {
  echo -e "${BLUE}"
  echo '╦ ╦╦╔╦╗╔═╗╦╔═╦ ╦╔╦╗╔═╗  ╔╗ ╔═╗╔═╗╔╦╗╔═╗╔╦╗╦═╗╔═╗╔═╗'
  echo '╠═╣║ ║║║╣ ╠╩╗║ ║║║║╠═╣  ╠╩╗║ ║║ ║ ║ ╚═╗ ║ ╠╦╝╠═╣╠═╝'
  echo '╩ ╩╩═╩╝╚═╝╩ ╩╚═╝╩ ╩╩ ╩  ╚═╝╚═╝╚═╝ ╩ ╚═╝ ╩ ╩╚═╩ ╩╩  '
  echo -e "${NC}"
}

# ─── 0. preflight ────────────────────────────────────────
preflight() {
  [ "$(uname -s)" = "Darwin" ] || { error "macOS 전용 스크립트입니다."; exit 1; }
  info "macOS $(sw_vers -productVersion) / $(uname -m)"
  info "로그: $LOG"
}

# ─── 1. Xcode Command Line Tools ─────────────────────────
setup_xcode() {
  if xcode-select -p &>/dev/null; then
    ok "Xcode CLT 이미 설치됨"
    return
  fi
  info "Xcode Command Line Tools 설치 중… (GUI 창이 뜨면 '설치' 클릭)"
  xcode-select --install &>/dev/null || true
  until xcode-select -p &>/dev/null; do
    printf '.'
    sleep 10
  done
  echo
  ok "Xcode CLT 설치 완료"
}

# ─── 2. Homebrew ─────────────────────────────────────────
setup_homebrew() {
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    info "Homebrew 설치 중… (sudo 암호를 물어봅니다)"
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [ -x /opt/homebrew/bin/brew ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  fi
  ok "Homebrew $(brew --version | head -1)"
}

# ─── 3. dotfiles clone ───────────────────────────────────
setup_dotfiles() {
  if [ -d "$DOTFILES/.git" ]; then
    ok "dotfiles 이미 존재: $DOTFILES"
  else
    info "dotfiles clone → $DOTFILES"
    git clone "$REPO_URL" "$DOTFILES"
    ok "clone 완료"
  fi
}

# ─── 4. install.sh ───────────────────────────────────────
run_install() {
  info "install.sh 실행 (brew symlinks zsh nvim tmux claude runtime)"
  bash "$DOTFILES/install.sh" brew symlinks zsh nvim tmux claude runtime
}

# ─── 5. doctor ───────────────────────────────────────────
run_doctor() {
  bash "$DOTFILES/bin/doctor.sh" || true
}

main() {
  : > "$LOG"
  banner
  preflight
  setup_xcode
  setup_homebrew
  setup_dotfiles
  run_install
  echo
  run_doctor
  echo
  ok "부트스트랩 완료. 새 터미널을 열어 zsh 를 다시 시작하세요."
  cat <<'NEXT'

━━━ 남은 수동 작업 (SETUP.md 참조) ━━━
  1. SSH 키 생성 + GitHub / 사내 GitHub 등록
     ssh-keygen -t ed25519 -C "you@example.com" && pbcopy < ~/.ssh/id_ed25519.pub
  2. 시크릿 이전 (AirDrop 또는 1Password):
     ~/.aws/  ~/.ssh/  ~/.claude.json  각 프로젝트 .mcp.json
  3. 사내 앱 설치 (VPN/보안/에이전트) — Brewfile.local + SETUP.local.md
  4. 워크스페이스 레포 clone:
     ~/dotfiles/bin/clone-repos.sh
  5. macOS 시스템 설정:
     ~/dotfiles/macos.sh
NEXT
}

main "$@"
