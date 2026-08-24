#!/usr/bin/env bash
#
# clone-repos.sh — 워크스페이스 레포 일괄 clone
#
#   ~/dotfiles/bin/clone-repos.sh
#
# 목록 파일: ~/dotfiles/repos.local.txt   (gitignored — 사내 URL 이 들어가므로 커밋 금지)
#   형식: <디렉토리명><공백><git URL>
#   생성: ~/dotfiles/bin/clone-repos.sh --dump
#
# SSH 키가 새 맥에 등록돼 있어야 사내 레포가 받아집니다. 실패한 건 마지막에 모아 보여줍니다.

set -uo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
LIST="${REPOS_FILE:-$DOTFILES/repos.local.txt}"
WORKSPACE="${WORKSPACE:-$HOME/Documents/workspace}"

GREEN='\033[0;32m'; RED='\033[0;31m'; YELLOW='\033[0;33m'; BLUE='\033[0;34m'; NC='\033[0m'

# --dump: 현재 맥의 워크스페이스를 목록 파일로 덤프
if [ "${1:-}" = "--dump" ]; then
  : > "$LIST"
  for d in "$WORKSPACE"/*/; do
    [ -d "$d/.git" ] || continue
    url="$(git -C "$d" remote get-url origin 2>/dev/null)" || continue
    [ -n "$url" ] || continue
    printf '%s %s\n' "$(basename "$d")" "$url" >> "$LIST"
  done
  echo -e "${GREEN}덤프 완료:${NC} $LIST ($(wc -l < "$LIST" | tr -d ' ')개)"
  exit 0
fi

if [ ! -f "$LIST" ]; then
  echo -e "${RED}목록 파일이 없습니다:${NC} $LIST"
  echo "기존 맥에서 '$0 --dump' 로 만든 뒤 AirDrop 등으로 옮겨오세요."
  exit 1
fi

mkdir -p "$WORKSPACE"
failed=()

while read -r name url; do
  [ -z "${name:-}" ] && continue
  case "$name" in \#*) continue ;; esac
  target="$WORKSPACE/$name"
  if [ -d "$target/.git" ]; then
    echo -e "${YELLOW}skip${NC}  $name (이미 있음)"
    continue
  fi
  echo -e "${BLUE}clone${NC} $name"
  if git clone "$url" "$target" >/dev/null 2>&1; then
    echo -e "${GREEN}  ✔${NC} $name"
  else
    echo -e "${RED}  ✘${NC} $name — $url"
    failed+=("$name  $url")
  fi
done < "$LIST"

echo
if [ ${#failed[@]} -gt 0 ]; then
  echo -e "${RED}실패 ${#failed[@]}건${NC} (SSH 키 등록/VPN 확인 후 재실행):"
  printf '  %s\n' "${failed[@]}"
  exit 1
fi
echo -e "${GREEN}전부 완료${NC}"
