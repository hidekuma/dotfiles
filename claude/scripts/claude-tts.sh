#!/bin/bash
# Claude Code TTS - reads last response aloud
# Toggle: tts (alias) or touch/rm ~/.claude-tts

[ -f "$HOME/.claude-tts" ] || exit 0

# Kill any running TTS
pkill -x say 2>/dev/null

# Capture recent tmux pane content
text=$(tmux capture-pane -t "$TMUX_PANE" -p -S -200 2>/dev/null | \
  sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' | \
  grep -v '^\s*$' | \
  grep -v '^\s*[0-9]*→' | \
  grep -v '^[─━═╭╮╰╯┌┐└┘├┤┬┴┼│┃]')

[ -n "$text" ] && echo "$text" | say -v Yuna &
exit 0
