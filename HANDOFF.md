# Handoff

## Goal

Maintain and improve a personal dotfiles repository that manages development environment configuration (Zsh, Neovim, tmux, Claude Code, OpenCode, Karabiner) across macOS and Linux.

## Previous Sessions (1-10)

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
| 9 | 알림 클릭→tmux 점프, notify-jump.sh, 기술 부채 수정, `/rhandoff` 자동 정리 |
| 10 | OMC rate limit PR #1347 (upstream에서 이미 해결, closed) |
| 11 | tmux 점프 수정: client-focus-in → eager select-window, notify-jump.sh 삭제 |

## What Worked

- Lazy loading pattern for shell tools — function wrapper + `unset -f` on first call
- `zprof`로 쉘 시작 병목 진단 (nvm 55%, virtualenvwrapper 15%, compinit 25%)
- Claude Code hooks는 `"hooks": {}` 키 안에 넣어야 정상 동작
- **settings.json 훅 변경은 세션 재시작 필요** (캐싱됨, 핫리로드 안 됨)
- `terminal-notifier -activate`는 훅에서 동작 (macOS가 직접 처리)
- `$TMUX_PANE`으로 Claude Code 실제 윈도우 캡처 (`display-message -p`는 현재 선택된 윈도우 반환)
- Eager `select-window -t $TMUX_PANE` — 알림 발생 시 즉시 윈도우 전환 (deferred보다 안정적)

## What Didn't Work

- `terminal-notifier -execute` — 훅 서브프로세스에서 동작 안 함 (프로세스 종료 후 콜백 불가)
- tmux `client-focus-in` — tmux 3.5a + iTerm2에서 미발동 (focus escape sequence 전달 안 됨)
- `switch-client` in notification hook — 다른 세션 작업 중 강제 전환됨 (제거함)

## Next Steps

- 미해결 이슈 없음

## Key Files

| File | Purpose |
|------|---------|
| `install.sh` | Unified bootstrap (symlinks, zsh, nvim, tmux, claude, tools) |
| `claude/setup.sh` | Claude Code installer (plugins, LSP, symlinks) |
| `claude/settings.json` | Permissions, hooks, plugins |
| `claude/commands/` | Slash commands (rhandoff 등) |
| `tmux.conf` | tmux 설정 |
| `nvim/init.lua` | Neovim module loader (27 modules) |
| `nvim/lua/user/plugins.lua` | lazy.nvim plugin specs (~50 plugins) |
| `zshrc` | Oh-My-Zsh bootstrap |
| `zsh_profile.m1` | Apple Silicon profile (lazy-loaded nvm/virtualenvwrapper/pyenv) |
| `.github/workflows/shellcheck.yml` | Shell lint CI (shellcheck + zsh -n) |
