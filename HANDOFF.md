# Handoff

## Goal

Maintain and improve a personal dotfiles repository that manages development environment configuration (Zsh, Neovim, tmux, Claude Code, OpenCode, Karabiner) across macOS and Linux.

## Current Progress

### Completed (Session 1)

1. `/harness` slash command created (`claude/commands/harness.md`)
2. Eval harness docs generated (`ARCHITECTURE.md`, `EXECPLAN.md`)
3. Technical debt fixes — hardcoded paths, dead tabnine.lua
4. Committed and pushed — `5c043fc`

### Completed (Session 2)

1. **Packer → lazy.nvim migration** (`e5b1b65`)
   - `plugins.lua` rewritten to lazy.nvim spec format
   - Bootstrap code replaced, `requires` → `dependencies`, `run` → `build`
   - Removed commented-out plugin blocks (ChatGPT, Copilot, Tabnine, DAP, null-ls)

2. **Dead Neovim code cleanup** (`e5b1b65`, -320 lines)
   - Deleted: `dap/` (7 files), `shade.lua`, `vim-rooter.lua`, `vim-multiple-cursor.lua`, `impatient.lua`, `neodev.lua`
   - Cleaned `init.lua`: removed all dead requires and comments

3. **Shell startup optimization** (`7d719dd`)
   - 1.9s → 0.5s (74% improvement)
   - Lazy load nvm (~1084ms saved), virtualenvwrapper (~286ms saved)
   - Removed duplicate `compinit` call (~500ms saved)

4. **CI for shell scripts** (`74f15fc`)
   - `.github/workflows/shellcheck.yml` — runs on `.sh`/`zsh_profile*` changes

5. **Unified bootstrap** (`2a3e653`)
   - `install.sh` at repo root — selective install: `./install.sh symlinks nvim`

6. **Misc cleanup** (`b936647`..`5ea3287`)
   - `claude/CLAUDE.md` — global rules (no Co-Authored-By)
   - `lazy-lock.json` added to `.gitignore`
   - WhichKey: Packer commands → Lazy commands
   - `nvim/README.md`: removed stale Comrade/packer references

## What Worked

- Lazy loading pattern for shell tools — function wrapper + `unset -f` on first call
- lazy.nvim migration was smooth — existing `pcall(require, ...)` config pattern is fully compatible
- `zprof` quickly identified exact bottlenecks (nvm 55%, virtualenvwrapper 15%, compinit 25%)

## What Didn't Work

- `gh` CLI not authenticated — couldn't investigate Dependabot alert programmatically
- Otherwise nothing blocked either session

## Next Steps

- **Dependabot alert** — 1 moderate vulnerability on GitHub (needs `gh auth login` first)
- **Neovim plugin audit** — `stabilize.nvim` superseded by Neovim 0.9+ `splitkeep`, `vim-polyglot` may conflict with treesitter
- **pyenv lazy loading** — not yet lazy loaded (relatively fast, but could save ~50ms more)
- **shellcheck fixes** — CI may flag existing scripts on next push; fix as needed
- **First nvim launch** — user needs to run `rm -rf ~/.local/share/nvim/site/pack/packer` then open nvim for lazy.nvim bootstrap

## Key Files

| File | Purpose |
|------|---------|
| `install.sh` | Unified bootstrap (symlinks, zsh, nvim, tmux, claude, tools) |
| `claude/setup.sh` | Claude Code installer (plugins, LSP, symlinks) |
| `claude/CLAUDE.md` | Global Claude rules (no Co-Authored-By) |
| `claude/settings.json` | Permissions, hooks, plugins |
| `claude/commands/` | Slash commands (7 files) |
| `nvim/init.lua` | Neovim module loader (27 modules) |
| `nvim/lua/user/plugins.lua` | lazy.nvim plugin specs (~50 plugins) |
| `nvim/lua/user/whichkey.lua` | Keybindings (Lazy commands on `<leader>p`) |
| `zshrc` | Oh-My-Zsh bootstrap |
| `zsh_profile.m1` | Apple Silicon profile (lazy-loaded nvm/virtualenvwrapper) |
| `.github/workflows/shellcheck.yml` | Shell script CI |
