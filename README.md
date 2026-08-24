# dotfiles

🌈 Hidekuma's dotfiles. It's personal.

## 새 맥 세팅 (원큐)

```bash
curl -fsSL https://raw.githubusercontent.com/hidekuma/dotfiles/main/bootstrap.sh | bash
```

Xcode CLT → Homebrew → Brewfile → 심볼릭 링크 → zsh/tmux/neovim → 런타임 → 점검까지 한 번에.
수동으로 남는 것(SSH 키·시크릿·사내앱·레포 clone)은 **[SETUP.md](SETUP.md)** 참조.

## 구성

| 파일 | 역할 |
|---|---|
| `bootstrap.sh` | 새 맥 원큐 진입점 |
| `install.sh` | 컴포넌트별 설치 (`./install.sh --help`) |
| `Brewfile` | CLI·GUI 앱·폰트 목록 |
| `macos.sh` | macOS 시스템 기본값 (키 리피트, Finder, Dock…) |
| `bin/doctor.sh` | 세팅 상태 점검 |
| `bin/clone-repos.sh` | 워크스페이스 레포 일괄 clone |
| `bin/brew-dump.sh` | 현재 설치 목록 ↔ Brewfile 차이 확인 |
| `SETUP.md` | 수동 작업 체크리스트 |

`*.local*` 파일은 gitignored — 이 레포는 public 이므로 사내 정보·시크릿은 넣지 않는다.

## 개별 실행

```bash
./install.sh brew        # Brewfile 만
./install.sh nvim        # neovim + 플러그인
./install.sh macos       # 시스템 기본값
./install.sh repos       # 레포 clone
./install.sh doctor      # 점검
```

## 메모

- git pager: `git config --global core.pager delta`
- 터미널 폰트: `CaskaydiaCove Nerd Font`
