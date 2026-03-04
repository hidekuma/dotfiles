#!/bin/bash
# Click notification → activate iTerm2 + switch to tmux window
# Usage: notify-jump.sh <tmux-target>  (e.g. "private:3")
/usr/bin/osascript -e 'tell application "iTerm2" to activate'
/opt/homebrew/bin/tmux select-window -t "$1"
