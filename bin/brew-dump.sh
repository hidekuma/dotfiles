#!/usr/bin/env bash
#
# brew-dump.sh — 현재 맥에 설치된 brew 패키지를 Brewfile.dump 로 덤프
#
# Brewfile 은 손으로 큐레이션한 파일이므로 자동 덮어쓰지 않습니다.
# 덤프를 diff 로 비교해서 필요한 것만 Brewfile 에 옮겨 넣으세요.

set -euo pipefail
DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"

brew bundle dump --describe --force --file="$DOTFILES/Brewfile.dump"
echo "덤프: $DOTFILES/Brewfile.dump"
echo
echo "── Brewfile 에 없는 항목 ──"
grep -E '^(brew|cask|tap) ' "$DOTFILES/Brewfile.dump" | while read -r line; do
  key="$(echo "$line" | awk '{print $1" "$2}')"
  grep -qF "$key" "$DOTFILES/Brewfile" || echo "  + $line"
done
