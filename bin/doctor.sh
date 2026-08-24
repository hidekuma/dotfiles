#!/usr/bin/env bash
#
# doctor.sh — 새 맥 세팅이 제대로 됐는지 점검
#
#   ~/dotfiles/bin/doctor.sh
#   ~/dotfiles/bin/doctor.sh --no-secrets   # 시크릿 경로 확인 생략

set -uo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
CHECK_SECRETS=true
[ "${1:-}" = "--no-secrets" ] && CHECK_SECRETS=false

GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'; BLUE='\033[0;34m'; NC='\033[0m'
PASS=0; FAIL=0; WARN=0

pass() { echo -e "  ${GREEN}✔${NC} $*"; PASS=$((PASS+1)); }
fail() { echo -e "  ${RED}✘${NC} $*"; FAIL=$((FAIL+1)); }
warn() { echo -e "  ${YELLOW}!${NC} $*"; WARN=$((WARN+1)); }
head_() { echo -e "\n${BLUE}▸ $*${NC}"; }

have() { command -v "$1" &>/dev/null; }

check_cmd() {
  if have "$1"; then pass "$1 ($(command -v "$1"))"; else fail "$1 없음"; fi
}

check_link() {
  local link="$1" want="$2"
  if [ -L "$link" ] && [ "$(readlink "$link")" = "$want" ]; then
    pass "$link → $want"
  elif [ -e "$link" ]; then
    warn "$link 존재하지만 심볼릭 링크가 아님/대상 다름"
  else
    fail "$link 없음"
  fi
}

head_ "필수 CLI"
for c in brew git nvim tmux zsh fzf rg fd bat lsd jq gh lazygit; do check_cmd "$c"; done

head_ "인프라 CLI"
for c in aws kubectl helm ansible terraform docker; do
  have "$c" && pass "$c" || warn "$c 없음 (tfenv/docker desktop 은 별도 설치 필요)"
done

head_ "런타임"
for c in node npm python3 pyenv go java; do
  have "$c" && pass "$c $("$c" --version 2>&1 | head -1 | cut -c1-40)" || warn "$c 없음"
done

head_ "심볼릭 링크"
check_link "$HOME/.zshrc"        "$DOTFILES/zshrc"
check_link "$HOME/.tmux.conf"    "$DOTFILES/tmux.conf"
check_link "$HOME/.config/nvim"  "$DOTFILES/nvim"
if [ "$(uname -m)" = "arm64" ]; then
  check_link "$HOME/.zsh_profile" "$DOTFILES/zsh_profile.m1"
else
  check_link "$HOME/.zsh_profile" "$DOTFILES/zsh_profile"
fi

head_ "Neovim"
if have nvim; then
  pass "$(nvim --version | head -1)"
  [ -d "$HOME/.local/share/nvim/lazy" ] && pass "lazy.nvim 플러그인 설치됨" || fail "플러그인 미설치 — nvim --headless '+Lazy! sync' +qa"
  [ -d "$HOME/.local/share/nvim/mason" ] && pass "mason 설치됨" || warn "mason 미설치 — nvim 을 한 번 열면 자동 설치"
  [ -x "$HOME/.virtualenvs/neovim3.12/bin/python" ] && pass "python provider" || fail "python provider 없음 (~/.virtualenvs/neovim3.12)"
  for t in stylua shfmt ruff prettierd eslint_d; do
    have "$t" && pass "formatter/linter: $t" || warn "formatter/linter 없음: $t"
  done
else
  fail "nvim 없음"
fi

head_ "zsh 환경"
[ -d "$HOME/.oh-my-zsh" ] && pass "oh-my-zsh" || fail "oh-my-zsh 없음"
for p in zsh-syntax-highlighting zsh-autosuggestions; do
  [ -d "$HOME/.oh-my-zsh/custom/plugins/$p" ] && pass "plugin: $p" || fail "plugin 없음: $p"
done
[ -d "$HOME/.tmux/plugins/tpm" ] && pass "tmux TPM" || fail "TPM 없음"
[ -d "$HOME/.sdkman" ] && pass "SDKMAN" || warn "SDKMAN 없음"

head_ "GUI 설정"
check_link "$HOME/.config/karabiner" "$DOTFILES/karabiner"
if [ "$(defaults read com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null)" = "$DOTFILES/iterm2" ]; then
  pass "iTerm2 prefs → dotfiles/iterm2"
else
  warn "iTerm2 설정 폴더 미지정 — install.sh gui 실행"
fi

head_ "Claude Code"
have claude && pass "claude CLI" || warn "claude CLI 없음 (npm i -g @anthropic-ai/claude-code)"
[ -e "$HOME/.claude/settings.json" ] && pass "~/.claude/settings.json" || warn "claude 설정 링크 없음 — claude/setup.sh 실행"

if $CHECK_SECRETS; then
  head_ "시크릿 (수동 이전 대상 — 존재 여부만 확인, 내용은 안 봄)"
  [ -d "$HOME/.ssh" ] && [ -n "$(ls -A "$HOME/.ssh" 2>/dev/null)" ] && pass "~/.ssh 있음" || fail "~/.ssh 비어있음 — SSH 키 생성/이전 필요"
  [ -f "$HOME/.aws/credentials" ] || [ -f "$HOME/.aws/config" ] && pass "~/.aws 있음" || warn "~/.aws 없음"
  [ -e "$HOME/.claude.json" ] && pass "~/.claude.json 있음" || warn "~/.claude.json 없음"
  ssh -T git@github.com -o StrictHostKeyChecking=no -o ConnectTimeout=5 2>&1 | grep -q "successfully authenticated" \
    && pass "github.com SSH 인증 OK" || warn "github.com SSH 인증 안 됨 (키 등록 필요)"
fi

head_ "결과"
echo -e "  ${GREEN}통과 $PASS${NC} / ${YELLOW}경고 $WARN${NC} / ${RED}실패 $FAIL${NC}"
[ "$FAIL" -eq 0 ]
