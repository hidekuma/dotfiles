#!/bin/bash
# Claude Code Notification hook script
# Called by Notification hook - can be modified without session restart

# macOS notification + focus iTerm2
terminal-notifier \
    -title "Claude Code [$(basename "$PWD")]" \
    -message "입력 대기 중" \
    -sound Glass \
    -activate com.googlecode.iterm2

# Jump to the tmux window containing Claude Code
if [ -n "$TMUX_PANE" ] && [ -n "$TMUX" ]; then
    sleep 0.3
    tmux select-window -t "$TMUX_PANE" 2>/dev/null
fi

# TTS if enabled
~/dotfiles/claude/scripts/claude-tts.sh &
