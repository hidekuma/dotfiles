You are delegating a task to Codex CLI running in a tmux split pane.

## Instructions

1. Parse the user's input: $ARGUMENTS
2. Determine the prompt:
   - **If `$ARGUMENTS` is non-empty**: use it as the prompt (check if it starts with `--safe` flag)
   - **If `$ARGUMENTS` is empty**: summarize the current conversation's last user request/task in 1-2 concise English sentences. This summary becomes the prompt.
3. Run the delegate script via Bash (do NOT use run_in_background — the script itself runs in a tmux pane):

```
bash ~/dotfiles/claude/codex-delegate.sh [--safe] "<prompt>" "$PWD"
```

4. The script outputs a session ID (e.g. `20260306-143021-12345`). Capture it.
5. Confirm delegation: "codex에 위임했습니다. 세션: `<session-id>`. 완료 후 '결과 확인해줘'라고 하시면 로그를 읽어드립니다."
6. Continue the current session normally — do not wait for codex to finish.

## Checking results

When the user asks to check codex results (e.g. "결과 확인해줘", "codex 결과"), read the log file:

```
cat ~/.codex-sessions/<session-id>.log
```

If no specific session ID is given, list available sessions with `ls -t ~/.codex-sessions/` and read the most recent one.
