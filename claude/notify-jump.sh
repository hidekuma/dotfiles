#!/bin/bash
# tmux client-focus-in handler: switch to saved window target on notification click
TARGET_FILE=/tmp/claude-tmux-jump
if [ -f "$TARGET_FILE" ]; then
  TARGET=$(cat "$TARGET_FILE")
  tmux switch-client -t "$TARGET"
  rm -f "$TARGET_FILE"
fi
