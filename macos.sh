#!/usr/bin/env bash
#
# macos.sh — macOS 시스템 기본값
#
#   ~/dotfiles/macos.sh          # 적용
#   ~/dotfiles/macos.sh --dry    # 뭐가 바뀌는지만 출력
#
# 적용 후 로그아웃/재시작해야 반영되는 항목이 있습니다.

set -euo pipefail

DRY=false
[ "${1:-}" = "--dry" ] && DRY=true

run() {
  if $DRY; then echo "  $*"; else eval "$@"; fi
}

echo "▸ 키보드 (vim/neovim 커서 이동 속도 — 이게 제일 중요)"
run 'defaults write NSGlobalDomain KeyRepeat -int 2'              # 최속에 가깝게
run 'defaults write NSGlobalDomain InitialKeyRepeat -int 15'
run 'defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false'  # 길게 눌러 반복(악센트 팝업 끄기)
run 'defaults write NSGlobalDomain AppleKeyboardUIMode -int 3'    # 전체 키보드 접근

echo "▸ 입력 보정 끄기 (코드 작성 시 방해)"
run 'defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false'
run 'defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false'
run 'defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false'
run 'defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false'
run 'defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false'

echo "▸ 트랙패드 / 마우스"
run 'defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5'
run 'defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true'
run 'defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1'

echo "▸ Finder"
run 'defaults write NSGlobalDomain AppleShowAllExtensions -bool true'
run 'defaults write com.apple.finder AppleShowAllFiles -bool true'
run 'defaults write com.apple.finder ShowPathbar -bool true'
run 'defaults write com.apple.finder ShowStatusBar -bool true'
run 'defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"'   # 리스트 뷰
run 'defaults write com.apple.finder _FXSortFoldersFirst -bool true'
run 'defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"'   # 현재 폴더 검색
run 'defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true'  # 네트워크 .DS_Store 금지
run 'defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true'

echo "▸ Dock"
run 'defaults write com.apple.dock autohide -bool true'
run 'defaults write com.apple.dock autohide-delay -float 0'
run 'defaults write com.apple.dock autohide-time-modifier -float 0.15'
run 'defaults write com.apple.dock show-recents -bool false'
run 'defaults write com.apple.dock mru-spaces -bool false'   # 스페이스 자동 재정렬 끔

echo "▸ 스크린샷"
run 'mkdir -p "$HOME/Screenshots"'
run 'defaults write com.apple.screencapture location -string "$HOME/Screenshots"'
run 'defaults write com.apple.screencapture disable-shadow -bool true'
run 'defaults write com.apple.screencapture type -string "png"'

echo "▸ 기타"
run 'defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false'
run 'defaults write com.apple.LaunchServices LSQuarantine -bool false'   # "인터넷에서 다운로드" 경고 끔
run 'defaults write com.apple.CrashReporter DialogType -string "none"'

if ! $DRY; then
  for app in Finder Dock SystemUIServer; do
    killall "$app" &>/dev/null || true
  done
  echo
  echo "완료. 키보드/트랙패드 설정은 로그아웃 후 확실히 반영됩니다."
fi
