#!/bin/bash
# Delegate a task to Codex CLI in a tmux split pane.
# Usage: codex-delegate.sh [--safe] <prompt> [workdir]
# Output is saved to ~/.codex-sessions/<session-id>.log

SANDBOX_MODE="--full-auto"
if [ "$1" = "--safe" ]; then
  SANDBOX_MODE="--sandbox read-only"
  shift
fi

PROMPT="$1"
WORKDIR="${2:-$PWD}"
PROJECT=$(basename "$WORKDIR")

if [ -z "$PROMPT" ]; then
  echo "Usage: codex-delegate.sh [--safe] <prompt> [workdir]"
  exit 1
fi

SESSION_ID=$(date +%Y%m%d-%H%M%S)-$$
SESSION_DIR="$HOME/.codex-sessions"
mkdir -p "$SESSION_DIR"
LOG="$SESSION_DIR/$SESSION_ID.log"

# Write metadata header
cat > "$LOG" <<EOF
# Codex Session: $SESSION_ID
# Prompt: $PROMPT
# Workdir: $WORKDIR
# Mode: $SANDBOX_MODE
# Started: $(date -Iseconds)
---
EOF

# Echo session ID so Claude Code can capture it
echo "$SESSION_ID"

tmux split-window -v -l 30% \
  "cd '$WORKDIR' && codex exec $SANDBOX_MODE '$PROMPT' 2>&1 | tee -a '$LOG'; \
   echo '---' >> '$LOG'; echo 'Exit: '\$? >> '$LOG'; echo 'Finished: '$(date -Iseconds) >> '$LOG'; \
   terminal-notifier -title 'Codex [$PROJECT]' -message '완료: $SESSION_ID' -sound Glass -activate com.googlecode.iterm2; \
   echo '--- Codex 완료 [$SESSION_ID]. Enter로 닫기 ---'; read"
