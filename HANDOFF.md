# Handoff

## Goal

Maintain and improve a personal dotfiles repository that manages development environment configuration (Zsh, Neovim, tmux, Claude Code, OpenCode, Karabiner) across macOS and Linux.

## Previous Sessions (1-8)

| Session | Key Accomplishments |
|---------|-------------------|
| 1 | `/harness` 명령어, eval harness docs, 기술 부채 수정 |
| 2 | Packer→lazy.nvim 마이그레이션, dead code 정리(-320줄), 쉘 시작 최적화(1.9s→0.5s), CI 추가 |
| 3 | Telescope ft_to_lang 수정, pyenv lazy loading, shellcheck 정리, Rg 키바인딩 수정 |
| 4 | CI lint 수정 (shellcheck→bash only, zsh-syntax 분리) |
| 5 | Claude Code Notification 훅 추가 (응답 완료 알림) |
| 6 | Hooks format 수정 (`"hooks": {}` 키 아래로 이동) |
| 7 | `/rhandoff` 스킬 생성, 알림 정리 (Stop 훅만 유지) |
| 8 | Notification 훅 복원 (`afplay` 사운드), 알림에 프로젝트명 표시 |

## Completed (Session 9)

1. **알림 클릭 → tmux 세션 점프** (`c02e73e`)
   - `terminal-notifier` + `-activate com.googlecode.iterm2` 조합
   - `$TMUX_PANE`으로 Claude Code 실제 윈도우 캡처 (선택된 윈도우가 아닌 실행 중인 윈도우)
   - `/tmp/claude-tmux-jump` 파일 기반 + tmux `client-focus-in` 훅으로 deferred switch
   - `notify-jump.sh` 스크립트 + `switch-client -t` (크로스 세션 지원)
2. **기술 부채 수정** — tmux.conf, notify-jump.sh 하드코딩 경로 제거
3. **`/rhandoff` 개선** — 실행 시 HANDOFF.md 자동 정리 (오래된 세션 압축, 해결된 이슈 제거)

## Completed (Session 10)

1. **OMC usage API rate limit loop 수정 PR** ([#1347](https://github.com/Yeachan-Heo/oh-my-claudecode/pull/1347))
   - Closed — upstream dev에서 exponential backoff로 이미 해결됨

## What Worked

- Lazy loading pattern for shell tools — function wrapper + `unset -f` on first call
- `zprof`로 쉘 시작 병목 진단 (nvm 55%, virtualenvwrapper 15%, compinit 25%)
- Claude Code hooks는 `"hooks": {}` 키 안에 넣어야 정상 동작
- **settings.json 훅 변경은 세션 재시작 필요** (캐싱됨, 핫리로드 안 됨)
- `terminal-notifier -activate`는 훅에서 동작 (macOS가 직접 처리)
- `$TMUX_PANE`으로 Claude Code 실제 윈도우 캡처 (`display-message -p`는 현재 선택된 윈도우 반환)
- tmux `run-shell -b` (백그라운드) 사용해야 `select-window`/`switch-client`가 클라이언트에 반영
- tmux `focus-events on` 필요 (`client-focus-in` 훅 전제조건)

## What Didn't Work

- `terminal-notifier -execute` — 훅 서브프로세스에서 동작 안 함 (프로세스 종료 후 콜백 불가)
- tmux `select-window` in `run-shell` (non-background) during `client-focus-in` — exit=0이지만 클라이언트에 미반영

## Next Steps

- 미해결 이슈 없음

## Key Files

| File | Purpose |
|------|---------|
| `install.sh` | Unified bootstrap (symlinks, zsh, nvim, tmux, claude, tools) |
| `claude/setup.sh` | Claude Code installer (plugins, LSP, symlinks) |
| `claude/settings.json` | Permissions, hooks, plugins |
| `claude/notify-jump.sh` | tmux focus-in handler (알림 클릭 → 윈도우 전환) |
| `claude/commands/` | Slash commands (rhandoff 등) |
| `tmux.conf` | tmux 설정 (focus-events, client-focus-in hook 포함) |
| `nvim/init.lua` | Neovim module loader (27 modules) |
| `nvim/lua/user/plugins.lua` | lazy.nvim plugin specs (~50 plugins) |
| `zshrc` | Oh-My-Zsh bootstrap |
| `zsh_profile.m1` | Apple Silicon profile (lazy-loaded nvm/virtualenvwrapper/pyenv) |
| `.github/workflows/shellcheck.yml` | Shell lint CI (shellcheck + zsh -n) |
