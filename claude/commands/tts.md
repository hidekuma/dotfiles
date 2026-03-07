Toggle TTS (text-to-speech) for Claude Code responses.

## Steps

1. First, kill any running `say` process: `pkill -x say`
2. Check if `~/.claude-tts` exists
3. If it exists, delete it and report "TTS OFF"
4. If it doesn't exist, create it and report "TTS ON"

Use the Bash tool to run all commands. Report the result in one line.
