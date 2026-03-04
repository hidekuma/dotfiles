#!/bin/bash
# tmux client-focus-in handler: switch to saved window target on notification click
TARGET_FILE=/tmp/claude-tmux-jump
if [ -f "$TARGET_FILE" ]; then
  tmux select-window -t "$(cat "$TARGET_FILE")"
  rm -f "$TARGET_FILE"
fi
