#!/bin/bash
# Claude Code Notification hook script
# Called by Notification hook - can be modified without session restart

terminal-notifier \
    -title "Claude Code [$(basename "$PWD")]" \
    -message "입력 대기 중" \
    -sound Glass \
    -activate com.googlecode.iterm2

[ -n "$TMUX_PANE" ] && tmux select-window -t "$TMUX_PANE" 2>/dev/null

~/dotfiles/claude/scripts/claude-tts.sh &
