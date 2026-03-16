#!/bin/bash
# Claude Code Notification hook script
# Called by Notification hook - can be modified without session restart

LOG="/tmp/claude-notify-debug.log"
echo "$(date): TMUX_PANE=$TMUX_PANE TMUX=$TMUX" >> "$LOG"

# macOS notification + focus iTerm2 FIRST
terminal-notifier \
    -title "Claude Code [$(basename "$PWD")]" \
    -message "입력 대기 중" \
    -sound Glass \
    -activate com.googlecode.iterm2

# THEN jump to the tmux window (after iTerm2 is focused)
if [ -n "$TMUX_PANE" ] && [ -n "$TMUX" ]; then
    sleep 0.3
    BEFORE=$(tmux display-message -p '#{window_index}:#{window_name}' 2>&1)
    tmux select-window -t "$TMUX_PANE" 2>>"$LOG"
    AFTER=$(tmux display-message -p '#{window_index}:#{window_name}' 2>&1)
    echo "$(date): BEFORE=$BEFORE AFTER=$AFTER exit=$?" >> "$LOG"
fi

# TTS if enabled
~/dotfiles/claude/scripts/claude-tts.sh &
