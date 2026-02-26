# Handoff

## Goal

Maintain and improve a personal dotfiles repository that manages development environment configuration (Zsh, Neovim, tmux, Claude Code, OpenCode, Karabiner) across macOS and Linux.

## Current Progress

### Completed (Previous Session)

1. **`/harness` slash command created** (`claude/commands/harness.md`)
2. **Eval harness docs generated** (`ARCHITECTURE.md`, `EXECPLAN.md`)
3. **Technical debt fixes** — hardcoded paths, dead tabnine.lua
4. **Committed and pushed** — `5c043fc` on `main`

### Completed (This Session)

1. **Packer → lazy.nvim migration** (`e5b1b65`)
   - `plugins.lua` rewritten to lazy.nvim spec format
   - Bootstrap code replaced, `requires` → `dependencies`, `run` → `build`
   - Removed commented-out plugin blocks (ChatGPT, Copilot, Tabnine, DAP, null-ls)

2. **Dead Neovim code cleanup** (`e5b1b65`, -320 lines)
   - Deleted: `dap/` (7 files), `shade.lua`, `vim-rooter.lua`, `vim-multiple-cursor.lua`, `impatient.lua`, `neodev.lua`
   - Cleaned `init.lua`: removed all dead requires and comments

3. **Shell startup profiling & optimization** (`7d719dd`)
   - 1.9s → 0.5s (74% improvement)
   - Lazy load nvm (~1084ms saved), virtualenvwrapper (~286ms saved)
   - Removed duplicate `compinit` call (~500ms saved)

4. **CI for shell scripts** (`74f15fc`)
   - Added `.github/workflows/shellcheck.yml`
   - Runs on push/PR when `.sh` or `zsh_profile*` files change

5. **Unified bootstrap** (`2a3e653`)
   - `install.sh` at repo root — single entry point
   - Components: symlinks, zsh, nvim, tmux, claude, tools
   - Selective install: `./install.sh symlinks nvim`

6. **Global CLAUDE.md** (`e5b1b65`)
   - `claude/CLAUDE.md` — disables Co-Authored-By in commits

## What Worked

- Lazy loading pattern for shell tools — simple function wrapper + `unset -f` on first call
- lazy.nvim migration was smooth — existing `pcall(require, ...)` config pattern is compatible
- `zprof` quickly identified the exact bottlenecks

## What Didn't Work

- Nothing blocked this session

## Next Steps

- **Dependabot alert** — 1 moderate vulnerability on GitHub (needs `gh auth login` to investigate)
- **Neovim plugin audit** — `stabilize.nvim` superseded by Neovim 0.9+ `splitkeep`, `vim-polyglot` may conflict with treesitter
- **pyenv lazy loading** — not yet lazy loaded (relatively fast, but could save ~50ms more)
- **shellcheck fixes** — CI may flag existing scripts; fix as needed

## Key Files

| File | Purpose |
|------|---------|
| `install.sh` | Unified bootstrap (symlinks, zsh, nvim, tmux, claude, tools) |
| `claude/setup.sh` | Claude Code installer (plugins, LSP, symlinks) |
| `claude/CLAUDE.md` | Global Claude rules (no Co-Authored-By) |
| `claude/settings.json` | Permissions, hooks, plugins |
| `claude/commands/` | Slash commands (7 files) |
| `nvim/init.lua` | Neovim module loader |
| `nvim/lua/user/plugins.lua` | lazy.nvim plugin specs (~50 plugins) |
| `zshrc` | Oh-My-Zsh bootstrap |
| `zsh_profile.m1` | Apple Silicon profile (lazy-loaded nvm/virtualenvwrapper) |
| `.github/workflows/shellcheck.yml` | Shell script CI |
