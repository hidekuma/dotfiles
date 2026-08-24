# 새 맥 세팅 가이드

공장초기화 상태 → 평소 작업 환경까지. 자동으로 되는 건 `bootstrap.sh` 가 다 하고,
사람 손이 필요한 건 아래 체크리스트에 모아뒀다.

## 0. 한 줄로 시작

```bash
curl -fsSL https://raw.githubusercontent.com/hidekuma/dotfiles/main/bootstrap.sh | bash
```

이게 하는 일:

| 단계 | 내용 |
|---|---|
| 1 | Xcode Command Line Tools |
| 2 | Homebrew |
| 3 | `~/dotfiles` clone |
| 4 | `Brewfile` 전체 설치 (CLI + GUI 앱 + 폰트) |
| 5 | 심볼릭 링크 (zshrc / zsh_profile / tmux.conf / nvim) |
| 6 | oh-my-zsh + 플러그인, tmux TPM |
| 7 | Neovim: python provider venv + lazy.nvim 플러그인 headless 설치 |
| 8 | node(nvm LTS) + npm 전역툴(prettierd, eslint_d, neovim), virtualenvwrapper, SDKMAN |
| 9 | Claude Code 설정 링크 |
| 10 | `doctor.sh` 로 결과 점검 |

소요 시간 약 30~60분(대부분 brew 다운로드). 중간에 sudo 암호 1회, Xcode CLT 설치 창 1회.

부분 실행도 된다:

```bash
~/dotfiles/install.sh brew          # 패키지만
~/dotfiles/install.sh nvim          # neovim 만
~/dotfiles/install.sh --help
```

## 1. 사람이 직접 해야 하는 것

부트스트랩이 끝나면 아래를 순서대로.

### 1-1. SSH 키

```bash
ssh-keygen -t ed25519 -C "메일주소"
pbcopy < ~/.ssh/id_ed25519.pub
```

- GitHub → Settings → SSH keys 에 등록
- 사내 GitHub 에도 동일하게 등록
- 확인: `ssh -T git@github.com`

기존 맥의 키를 그대로 옮기려면 AirDrop 으로 `~/.ssh` 통째 전송 후
`chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_*`.

### 1-2. 시크릿 이전 (git 에 절대 안 들어가는 것들)

AirDrop / USB / 1Password 로 직접 옮긴다.

| 대상 | 경로 |
|---|---|
| SSH 키 | `~/.ssh/` |
| AWS 자격증명·프로필 | `~/.aws/` |
| kube config | `~/.kube/` |
| Claude Code 계정/MCP 상태 | `~/.claude.json` |
| 프로젝트별 MCP 설정 | 각 레포의 `.mcp.json` |
| 사내 VPN / 인증서 | 사내 포털에서 재발급 |

> `.claude.json` 은 `~/dotfiles/claude/claude.json` 으로 심볼릭 링크되지만
> 파일 자체는 gitignore 대상이라 따로 옮겨야 한다.

### 1-3. 사내 앱

Homebrew 로 안 깔리는 것들(보안 에이전트, VPN, 사내 배포 앱)은 사내 포털에서 설치.
목록은 `SETUP.local.md`(gitignored) 참조.

App Store 앱은 로그인 후:

```bash
mas list        # 기존 맥에서 목록 확인
mas install <id>
```

### 1-4. 워크스페이스 레포

기존 맥에서 목록을 뽑아 옮긴 뒤:

```bash
# 기존 맥
~/dotfiles/bin/clone-repos.sh --dump      # → repos.local.txt

# 새 맥 (repos.local.txt 를 ~/dotfiles/ 에 놓고)
~/dotfiles/bin/clone-repos.sh
```

`repos.local.txt` 는 **gitignored**. 사내 레포 URL 이 들어가므로 이 공개 레포에 커밋 금지.

### 1-5. macOS 시스템 설정

```bash
~/dotfiles/macos.sh --dry     # 뭐가 바뀌는지 먼저 확인
~/dotfiles/macos.sh
```

키 리피트 속도, press-and-hold 끄기, Finder/Dock, 스크린샷 위치 등.
적용 후 로그아웃 권장.

### 1-6. GUI 앱 개별 설정

- **iTerm2 / Karabiner**: 자동 — `install.sh gui` 가 Karabiner 를 `~/dotfiles/karabiner` 로 심볼릭 링크하고
  iTerm2 설정 폴더를 `~/dotfiles/iterm2` 로 지정한다. 앱 재시작 후 반영.
  (양쪽 맥 모두 이 방식이라 설정 바꾸면 dotfiles 커밋으로 동기화됨)
- **JetBrains**: Toolbox 로그인 후 Settings Sync, ideavimrc 는 심볼릭 링크됨
- **폰트**: Brewfile 에서 Nerd Font 설치됨 → 터미널 폰트를 `CaskaydiaCove Nerd Font` 로 지정

## 2. 점검

```bash
~/dotfiles/bin/doctor.sh
```

통과/경고/실패로 정리해준다. 실패 항목만 다시 손보면 된다.

## 3. 유지보수 (기존 맥 ↔ 비상용 맥 동기화)

비상용 맥은 방치하면 낡는다. 분기 1회 정도:

```bash
# 기존 맥에서: 새로 깐 패키지 반영
~/dotfiles/bin/brew-dump.sh          # Brewfile 에 없는 항목만 알려줌 → 필요한 것만 Brewfile 에 추가
~/dotfiles/bin/clone-repos.sh --dump # 레포 목록 갱신
git -C ~/dotfiles commit -am "chore: brewfile 갱신" && git -C ~/dotfiles push

# 비상용 맥에서
cd ~/dotfiles && git pull && ./install.sh
```

## 4. 참고

- 이 레포는 **PUBLIC** 이다. 사내 정보·시크릿은 `*.local*` 파일로만 두고 커밋하지 않는다.
- 부트스트랩 로그: `~/.bootstrap.log`
