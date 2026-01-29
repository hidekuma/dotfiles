# OpenCode 설정 파일

이 디렉토리는 OpenCode AI 에이전트의 설정 파일들을 포함합니다.

## 📁 디렉토리 구조

```
dotfiles/opencode/
├── rules/                      # 코딩 규칙 (6개 파일)
│   ├── security.md             # 보안 가이드라인
│   ├── coding-style.md         # 코딩 스타일 규칙
│   ├── testing.md              # 테스트 전략
│   ├── git-workflow.md         # Git 워크플로우
│   ├── performance.md          # 성능 최적화
│   └── agents.md               # 에이전트 위임 가이드
│
├── commands/                   # 워크플로우 명령어 (4개 파일)
│   ├── pre-commit.md           # 커밋 전 체크리스트
│   ├── post-edit.md            # 파일 수정 후 자동화
│   ├── session-start.md        # 세션 시작 워크플로우
│   └── session-end.md          # 세션 종료 워크플로우
│
└── OPENCODE.md.backup          # 원본 OPENCODE.md 백업
```

## 🔗 심볼릭 링크

이 파일들은 `~/.config/opencode/`에 심볼릭 링크로 연결됩니다:

```bash
~/.config/opencode/rules -> ~/dotfiles/opencode/rules
~/.config/opencode/commands -> ~/dotfiles/opencode/commands
```

## 🚫 Git 추적 제외

다음 항목들은 개인정보를 포함하므로 Git에 추적되지 않습니다:
- `~/.config/opencode/memory/` - 세션 상태 및 프로젝트 컨텍스트

## 📝 사용 방법

### 새로운 머신에 설정하기

#### 방법 1: 자동 설치 스크립트 (추천)

```bash
# dotfiles 클론
git clone <your-dotfiles-repo> ~/dotfiles

# 대화형 모드로 설치 (선택 메뉴 표시)
cd ~/dotfiles/opencode
./setup-links.sh

# 또는 명령줄 옵션으로 직접 지정
./setup-links.sh --opencode        # OpenCode만
./setup-links.sh --claude          # Claude만
./setup-links.sh --both            # 둘 다
```

#### 방법 2: 수동 설치

```bash
# dotfiles 클론
git clone <your-dotfiles-repo> ~/dotfiles

# 심볼릭 링크 생성
ln -s ~/dotfiles/opencode/rules ~/.config/opencode/rules
ln -s ~/dotfiles/opencode/commands ~/.config/opencode/commands

# memory 디렉토리 생성 (로컬에만 존재)
mkdir -p ~/.config/opencode/memory
```

### 규칙 수정하기

```bash
# dotfiles 디렉토리에서 직접 수정
vim ~/dotfiles/opencode/rules/coding-style.md

# 또는 심볼릭 링크를 통해 수정 (같은 파일)
vim ~/.config/opencode/rules/coding-style.md

# Git으로 커밋
cd ~/dotfiles
git add opencode/
git commit -m "Update coding style rules"
git push
```

## 🎯 장점

1. **버전 관리**: 모든 OpenCode 설정을 Git으로 관리
2. **동기화**: 여러 머신 간 설정 동기화 가능
3. **백업**: 클라우드에 안전하게 백업
4. **이력 추적**: 설정 변경 이력 확인 가능
5. **개인정보 보호**: memory/ 디렉토리는 로컬에만 유지

## ⚠️ 주의사항

- `memory/` 디렉토리는 절대 Git에 커밋하지 마세요 (개인 정보 포함)
- `.gitignore`에 `memory/`가 추가되어 있는지 확인하세요
- 심볼릭 링크가 끊어지면 위의 명령어로 재생성하세요
