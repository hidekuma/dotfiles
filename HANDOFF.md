# Handoff

## Goal

Maintain and improve a personal dotfiles repository that manages development environment configuration (Zsh, Neovim, tmux, Claude Code, OpenCode, Karabiner) across macOS and Linux.

## Current Progress

### Completed This Session

1. **`/harness` slash command created** (`claude/commands/harness.md`)
   - Auto-detects Mode 1 (analysis, 3+ source files) vs Mode 2 (scaffold)
   - Generates `ARCHITECTURE.md` (11 sections) and `EXECPLAN.md` (12 sections)
   - Supports `$ARGUMENTS` for focused analysis (e.g., `/harness backend`)

2. **Eval harness docs generated** for this repo
   - `ARCHITECTURE.md` — Full 11-section architecture document
   - `EXECPLAN.md` — Full 12-section execution plan

3. **Technical debt fixes**
   - `zshrc:111-112` — SDKMAN path changed from `/Users/hidekuma/` to `$HOME/`
   - `zsh_profile:61-63` — GCP path changed from `/Users/hidekuma/` to `$HOME/`
   - `nvim/lua/user/tabnine.lua` — Deleted (plugin disabled in `init.lua`)

4. **README updated** — `claude/README.md` directory structure now includes `harness.md`

5. **Committed and pushed** — `5c043fc` on `main`

## What Worked

- Frontmatter pattern (`name`, `description`) + English instructions for commands — consistent with existing `plan.md`, `techdebt.md`
- Mode auto-detection (file count threshold) keeps the command simple for both new and existing projects
- Grepping for `hidekuma` quickly revealed all hardcoded legacy paths

## What Didn't Work

- Nothing blocked this session

## Next Steps (from techdebt scan + EXECPLAN Phase 5)

1. **Packer → lazy.nvim migration** (High priority) — Packer is unmaintained. Affects `nvim/lua/user/plugins.lua` and all `nvim/lua/user/*.lua` modules
2. **More dead Neovim code cleanup** — `nvim/lua/user/dap/` (disabled in `init.lua:17`), `shade.lua` if it exists, commented plugin blocks in `plugins.lua:128-142`
3. **Platform profile deduplication** — `zsh_profile` vs `zsh_profile.m1` share ~70% code. Extract common parts to `zsh_profile.common`
4. **Shell startup profiling** — Add `zprof` benchmarking; nvm/pyenv can add 200-500ms
5. **CI for shell scripts** — Add shellcheck GitHub Action for `bin/*.sh`
6. **Unified bootstrap** — Single `install.sh` at repo root that orchestrates all setup (shell, nvim, tmux, claude)

## Key Files

| File | Purpose |
|------|---------|
| `claude/setup.sh` | Claude Code automated installer (533 lines, well-structured) |
| `claude/settings.json` | Permissions, hooks, plugins |
| `claude/commands/` | Slash commands (7 files including new `harness.md`) |
| `nvim/init.lua` | Neovim module loader |
| `nvim/lua/user/plugins.lua` | Packer plugin declarations (~60 plugins) |
| `zshrc` | Oh-My-Zsh bootstrap |
| `zsh_profile.m1` | Active Apple Silicon profile |
| `ARCHITECTURE.md` | Generated architecture doc |
| `EXECPLAN.md` | Generated execution plan |
