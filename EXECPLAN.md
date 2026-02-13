# Execution Plan

## 1. Objective

Maintain a portable, reproducible development environment that can be deployed on any macOS or Linux workstation with a single setup command.

**Success criteria:**
- Fresh machine → fully configured dev environment in under 10 minutes
- All configuration changes are version-controlled and auditable
- AI assistant configs (Claude Code, OpenCode) are first-class citizens alongside traditional dotfiles
- Zero manual post-setup steps beyond `git clone` + `setup.sh`

## 2. Scope

**In-scope:**
- Shell configuration (Zsh, Oh-My-Zsh, profiles)
- Editor configuration (Neovim Lua, legacy Vim)
- Terminal multiplexer (tmux + TPM)
- AI coding assistants (Claude Code, OpenCode)
- Keyboard customization (Karabiner)
- Tool installer scripts (`bin/`)
- IDE Vim emulation (IdeaVim)

**Out-of-scope:**
- Application-level settings (browser, Slack, etc.)
- System-level configuration (firewall, network)
- Secret/credential management (SSH keys, API tokens)
- Language-specific project configs (per-repo settings)
- Docker/container environment setup

## 3. Prerequisites

| Tool | Required | Purpose |
|------|----------|---------|
| Git | Yes | Clone and version control |
| Zsh | Yes | Primary shell |
| Homebrew (macOS) or apt/dnf (Linux) | Yes | Package installation |
| Node.js + npm | Recommended | LSP servers, Claude Code hooks |
| Neovim ≥ 0.8 | Recommended | Lua config support |
| tmux ≥ 3.0 | Recommended | Terminal multiplexer |
| Claude Code CLI | Optional | AI assistant |
| Karabiner-Elements (macOS) | Optional | Keyboard mods |

## 4. Architecture Decisions

### ADR-001: Symlink-based deployment
- **Decision**: Use symlinks from dotfiles repo to `~` rather than copying files
- **Rationale**: Changes in the repo are immediately reflected; no sync step needed
- **Trade-off**: Requires the repo to stay in place; broken if moved

### ADR-002: Neovim Lua over Vimscript
- **Decision**: Migrated Neovim config from Vimscript to Lua modules
- **Rationale**: First-class Lua support since Neovim 0.5; better modularity and performance
- **Trade-off**: Legacy `vimrc` kept for fallback/vanilla Vim

### ADR-003: Claude Code as a managed component
- **Decision**: Claude Code config (`claude/`) has its own `setup.sh` with symlink management, plugin installation, and verification
- **Rationale**: AI tooling config is complex enough to warrant automated setup (11 plugins, hooks, permissions, agents, commands, rules)
- **Trade-off**: Separate setup script from main dotfiles installation

### ADR-004: Platform-specific profile files
- **Decision**: Separate `zsh_profile` (Intel), `zsh_profile.m1` (Apple Silicon), `zsh_profile.window` (WSL)
- **Rationale**: PATH, Homebrew location, and available tools differ across platforms
- **Trade-off**: Some duplication across profile files

### ADR-005: Packer for Neovim plugin management
- **Decision**: Use Packer (not lazy.nvim or other alternatives)
- **Rationale**: Established and stable at time of adoption
- **Trade-off**: Packer is now unmaintained; migration to lazy.nvim is a future consideration

## 5. Implementation Phases

### Phase 1: Core Shell Environment
- [x] Zsh configuration with Oh-My-Zsh
- [x] Platform-specific profiles (Intel Mac, M1, WSL)
- [x] Shell plugins (syntax-highlighting, autosuggestions, fzf)
- [x] Custom aliases and functions

### Phase 2: Editor Configuration
- [x] Neovim Lua migration from vimrc
- [x] Packer plugin management (~60 plugins)
- [x] LSP setup via Mason (pyright, lua_ls, jsonls, kotlin)
- [x] DAP debugging (Python, Kotlin)
- [x] Treesitter syntax highlighting
- [x] Legacy vimrc maintenance

### Phase 3: Terminal & Keyboard
- [x] tmux configuration with TPM
- [x] Vim-tmux navigator integration
- [x] Karabiner keyboard modifications
- [x] iTerm2 color themes (AlienBlood, Oceanic-Next, Snazzy)

### Phase 4: AI Assistants
- [x] Claude Code automated setup (`claude/setup.sh`)
- [x] Plugin ecosystem (oh-my-claudecode, everything-claude-code, etc.)
- [x] Custom commands (plan, review, explain, fix-ci, techdebt, harness)
- [x] Custom agents (code-reviewer, debugger, planner)
- [x] Coding rules (8 rule files)
- [x] Hook system (console.log detection, agent notifications)
- [x] OpenCode parallel config

### Phase 5: Ongoing Maintenance
- [ ] Migrate Packer → lazy.nvim
- [ ] Unify setup scripts into single entry point
- [ ] Add shell startup time benchmarking
- [ ] Audit and prune unused Neovim plugins
- [ ] Add automated testing for setup scripts

## 6. Task Breakdown

| Phase | Task | Files | Complexity |
|-------|------|-------|------------|
| 5 | Migrate Packer to lazy.nvim | `nvim/lua/user/plugins.lua`, all `nvim/lua/user/*.lua` | L |
| 5 | Create unified bootstrap script | New `install.sh` at repo root | M |
| 5 | Add shell startup profiling | `zsh_profile*` (zprof integration) | S |
| 5 | Audit Neovim plugins | `nvim/lua/user/plugins.lua` | S |
| 5 | Add shellcheck CI for `bin/` scripts | New `.github/workflows/lint.yml` | M |
| 5 | Deduplicate platform profiles | `zsh_profile`, `zsh_profile.m1`, `zsh_profile.window` | M |
| 5 | Document manual symlink steps | `README.md` | S |

## 7. Testing Strategy

| Type | Approach | Coverage Target |
|------|----------|-----------------|
| **Setup script** | `setup.sh --dry-run` validates all operations without side effects | All code paths |
| **Symlink integrity** | `verify_installation()` in setup.sh checks link targets | 5 critical symlinks |
| **Circular link detection** | Setup script checks for `agents/agents`, `commands/commands` | Regression guard |
| **Neovim health** | `:checkhealth` validates LSP, Treesitter, plugin status | Manual |
| **Shell syntax** | `shellcheck bin/**/*.sh` (not yet automated) | All install scripts |
| **Claude hooks** | PostToolUse hooks validate inline (console.log, notification) | On every tool use |

<!-- REVIEW: No automated test suite exists. Consider adding a CI workflow with shellcheck + dry-run validation -->

## 8. Data & State Management

| State | Location | Strategy |
|-------|----------|----------|
| Neovim plugins | `~/.local/share/nvim/site/pack/` | Managed by Packer; `:PackerSync` to update |
| tmux plugins | `~/.tmux/plugins/` | Managed by TPM; `prefix + I` to install |
| Claude plugins | Managed by Claude CLI | `claude plugin install` via setup.sh |
| Packer compiled | `nvim/plugin/packer_compiled.lua` | Auto-generated; committed to repo |
| Session state | `.omc/` | Ephemeral; git-ignored |
| Backups | `~/.claude.backup.<timestamp>/` | Created by `setup.sh --force` |

## 9. Integration Points

| Service | Integration | Error Handling |
|---------|-------------|----------------|
| GitHub | Plugin repos (Packer, TPM, Claude) | `2>/dev/null \|\| true` — silent failure, continue |
| npm registry | LSP server global installs | Silent failure with `\|\| true` |
| Homebrew | Package detection in setup.sh | Falls back to `PACKAGE_MANAGER="none"` |
| Claude CLI | Plugin marketplace + install | Checks `command -v claude` before attempting |
| MCP servers | context7, serena, oh-my-claudecode | Configured in `settings.json`; individually toggleable |
| macOS notifications | Agent completion via `osascript` | PostToolUse hook; no-op on Linux |

## 10. Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Packer deprecation breaks plugin management | High | High | Plan migration to lazy.nvim (Phase 5) |
| Shell startup becomes slow (nvm/pyenv) | Medium | Medium | Lazy-load version managers; add profiling |
| Claude plugin API breaking changes | Medium | Medium | Pin plugin versions; `setup.sh` uses `\|\| true` for resilience |
| Symlink repo accidentally moved/deleted | Low | High | Document expected repo location; consider `$DOTFILES` env var |
| Platform-specific config drift | Medium | Low | Periodic audit of profile variants; consider shared base |
| Secrets accidentally committed | Low | Critical | `.gitignore` blocks `claude.json`, `*.local.json`; pre-commit hook recommended |

## 11. Rollback Plan

| Component | Rollback Strategy |
|-----------|-------------------|
| Claude Code setup | `setup.sh --uninstall` removes all symlinks; backups at `~/.claude.backup.*` |
| Neovim config | `git checkout` to previous working state; Packer will resync |
| Shell profile | `git stash` or `git checkout -- zshrc zsh_profile*`; re-source shell |
| tmux config | `tmux source ~/.tmux.conf` after reverting; TPM plugins persist |
| Full rollback | `git log` → `git checkout <sha>` → re-run setup scripts |
| Nuclear option | `setup.sh --uninstall` + `rm -rf ~/.config/nvim` + restore from backup |

## 12. Definition of Done

- [ ] `git clone` + `claude/setup.sh` produces a fully working Claude Code environment
- [ ] All 5 symlinks verified by `verify_installation()`
- [ ] No circular symlinks detected
- [ ] Neovim starts without errors (`:checkhealth` clean)
- [ ] tmux starts with plugins loaded (`prefix + I` if first time)
- [ ] Shell sources profile without errors
- [ ] All `bin/*.sh` scripts pass `shellcheck` (future goal)
- [ ] No secrets in version control (`.gitignore` enforced)
- [ ] `setup.sh --dry-run` completes without errors on a clean system
- [ ] Cross-platform: works on macOS (Intel + M1) and Linux (Ubuntu)
