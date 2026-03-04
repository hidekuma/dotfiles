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

### Completed (Session 3)

1. **Telescope ft_to_lang fix** (`78bb8d1`)
   - Updated telescope.nvim to `5255aa2` (Neovim 0.11 compatible)
   - Removed stale `vim-bad-whitespace` entry from `lazy-lock.json`

2. **pyenv lazy loading** (`78bb8d1`)
   - Added `$PYENV_ROOT/shims` directly to PATH (instant python/pip access)
   - Deferred `pyenv init -` to first `pyenv` command invocation
   - ~285ms saved per shell startup

3. **shellcheck fixes** (`2c21297`, -53 lines)
   - Removed dead `detect_os`, `detect_package_manager` functions
   - Removed unused `OS_TYPE`, `PACKAGE_MANAGER` variables
   - Fixed SC2155: separated `local` declaration from assignment
   - Both `install.sh` and `claude/setup.sh` pass shellcheck clean

4. **Rg keybinding fix** (`4d46373`)
   - `<S-F>` was overridden by flash.nvim (uppercase `F` = backward char find)
   - Remapped `:Rg` from `<S-F>` to `<C-f>` in normal mode

### Completed (Session 4)

1. **CI lint fix** (`d5f1000`)
   - shellcheck was failing on every push — zsh files can't be parsed by shellcheck (bash/sh only)
   - Renamed workflow `shellcheck` → `lint-shell`, split into two parallel jobs:
     - `shellcheck` job: `.sh` files only (`ignore_names` excludes zsh files)
     - `zsh-syntax` job: `zsh -n` parse check for `zshrc` and `zsh_profile*`
   - All 4 zsh files pass `zsh -n` locally

### Completed (Session 5)

1. **Claude Code notification fix**
   - `Stop` 훅만 있어서 세션 종료 시에만 알림이 울렸음
   - `Notification` 훅 추가 — Claude 응답 완료 후 사용자 입력 대기 시 macOS 알림 + Glass 사운드
   - `Stop` 훅은 세션 종료 전용 메시지로 변경

### Completed (Session 6)

1. **Hooks format fix** (`5b6e9f1`)
   - 훅 이벤트(`PreToolUse`, `Notification`, `Stop`, `PostToolUse`)가 settings.json root level에 있어서 `Notification` 훅이 동작하지 않았음
   - 모든 훅을 `"hooks": {}` 최상위 키 아래로 이동 — Claude Code 공식 포맷 준수
   - `Notification` 훅 정상 동작 확인 (응답 완료 시 macOS 알림 + Glass 사운드)

### Completed (Session 7)

1. **`/rhandoff` 스킬 생성** (`claude/commands/rhandoff.md`)
   - HANDOFF.md를 읽고 세션 컨텍스트를 요약하는 슬래시 명령어
   - 세션 번호, 완료 내역, 미해결 이슈를 자동 정리

2. **알림 정리 — Stop hook만 유지**
   - `Notification` 훅(응답 완료) 제거, `PostToolUse Task` 훅(Agent 완료) 제거
   - `Stop` 훅(세션 종료)만 남김 — 사용자 요청
   - `terminal-notifier` 시도했으나 macOS 알림 권한 미부여로 동작 안 함 → `osascript`로 유지
   - macOS 시스템 설정에서 Script Editor 알림 스타일을 "임시(배너)"로, 알림 센터 체크 해제 → 자동 사라짐 확인

### Completed (Session 8)

1. **Notification 훅 복원 + 안정화** (`9a1bee7`)
   - 사용자 입력 대기 시(권한 승인, 질문, 응답 완료) macOS 알림이 안 오는 문제
   - `osascript` 알림 사운드가 macOS 권한에 의존 → `afplay`로 직접 Glass.aiff 재생 (권한 무관)
   - `osascript`는 배너 표시 전용으로 병행

2. **알림에 프로젝트명 표시** (`4d2ff38`)
   - 알림 타이틀을 `"Claude Code"` → `"Claude Code [프로젝트명]"`으로 변경
   - `$(basename $PWD)`로 현재 프로젝트 디렉토리명 동적 삽입
   - 복수 세션 운영 시 어떤 세션에서 알림이 왔는지 구분 가능

## What Worked

- Lazy loading pattern for shell tools — function wrapper + `unset -f` on first call
- lazy.nvim migration was smooth — existing `pcall(require, ...)` config pattern is fully compatible
- `zprof` quickly identified exact bottlenecks (nvm 55%, virtualenvwrapper 15%, compinit 25%)
- Direct shims PATH insertion for pyenv — avoids `eval` cost while keeping python/pip immediately available
- Checking `map <key>` in headless nvim to diagnose keybinding conflicts (flash.nvim overriding `<S-F>`)
- `ignore_names` in `ludeeus/action-shellcheck` to exclude non-bash files from shellcheck scanning
- Claude Code `Notification` 훅 vs `Stop` 훅 — `Stop`은 세션 종료 시만, `Notification`이 응답 완료 알림에 적합
- Claude Code hooks는 settings.json root level이 아닌 `"hooks": {}` 키 안에 넣어야 정상 동작
- macOS 알림 설정에서 "알림 센터" 체크 해제 → 배너만 뜨고 알림 센터에 안 쌓임
- `afplay`로 사운드 직접 재생 — macOS 알림 권한과 무관하게 확실히 소리남
- `$(basename $PWD)`로 알림 타이틀에 프로젝트명 동적 삽입 — 복수 세션 구분

## What Didn't Work

- `gh` CLI not authenticated — couldn't investigate Dependabot alert (sessions 2 & 3; resolved in session 4)
- `<S-F>` keybinding — Neovim treats `<S-F>` as uppercase `F`, which conflicts with flash.nvim char motion
- shellcheck on zsh files — zsh one-liner functions `f() { cmd; }` are unparseable by shellcheck
- `terminal-notifier` — 설치돼 있어도 macOS 알림 권한이 없으면 무음으로 실패 (exit 0이지만 알림 안 뜸)

## Next Steps

- 미해결 이슈 없음

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
| `nvim/lua/user/fzf.lua` | fzf keybindings (`<C-P>` files, `<C-f>` Rg, `<leader>p` git files) |
| `nvim/lua/user/whichkey.lua` | Keybindings (Lazy commands on `<leader>p`) |
| `zshrc` | Oh-My-Zsh bootstrap |
| `zsh_profile.m1` | Apple Silicon profile (lazy-loaded nvm/virtualenvwrapper/pyenv) |
| `.github/workflows/shellcheck.yml` | Shell lint CI (shellcheck + zsh -n) |
