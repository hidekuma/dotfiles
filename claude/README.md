# Claude Code Configuration

dotfiles 레포에서 관리되는 Claude Code 설정입니다. 심볼릭 링크를 통해 어떤 환경에서도 동일한 설정을 구성할 수 있습니다.

## 빠른 시작

```bash
# 1. dotfiles 클론
git clone https://github.com/your-username/dotfiles.git ~/dotfiles

# 2. 설정 적용
cd ~/dotfiles/claude
./setup.sh --force
```

## 설치 옵션

```bash
./setup.sh              # 기본 설치
./setup.sh --force      # 기존 설정 백업 후 덮어쓰기
./setup.sh --dry-run    # 실제 변경 없이 미리보기
./setup.sh --uninstall  # 심볼릭 링크 제거
./setup.sh --minimal    # 심볼릭 링크만 생성 (플러그인 제외)
./setup.sh --verbose    # 상세 로그 출력
./setup.sh --help       # 도움말
```

## 디렉토리 구조

```
dotfiles/claude/
├── setup.sh            # 설치 스크립트
├── settings.json       # 권한, 훅, 플러그인 설정
├── CLAUDE.md           # 글로벌 지침 (한국어)
├── agents/             # 커스텀 에이전트
│   ├── code-reviewer.md
│   ├── debugger.md
│   └── planner.md
├── commands/           # 워크플로우 명령어
│   ├── explain.md
│   ├── fix-ci.md
│   ├── harness.md
│   ├── plan.md
│   ├── review.md
│   └── techdebt.md
└── rules/              # 코딩 규칙 (한국어)
    ├── coding-style.md # 코딩 스타일
    ├── git-workflow.md # Git 워크플로우
    ├── testing.md      # 테스팅 가이드
    ├── performance.md  # 성능 최적화
    ├── security.md     # 보안 가이드
    ├── patterns.md     # 공통 패턴
    ├── hooks.md        # Hooks 시스템
    └── agents.md       # Agent 위임 가이드
```

## 심볼릭 링크 매핑

| Source (dotfiles) | Target |
|-------------------|--------|
| `settings.json` | `~/.claude/settings.json` |
| `CLAUDE.md` | `~/.claude/CLAUDE.md` |
| `agents/` | `~/.claude/agents/` |
| `commands/` | `~/.claude/commands/` |
| `rules/` | `~/.claude/rules/` |

> **Note**: `claude.json`은 심볼릭 링크되지 않습니다 (OAuth, userID 등 민감 정보 포함).

## 포함된 플러그인

### Core
- **oh-my-claudecode** - 멀티 에이전트 오케스트레이션
- **everything-claude-code** - 확장 기능 모음
- **typescript-lsp** - TypeScript 언어 서버

### 워크플로우
- **code-review** - 코드 리뷰
- **commit-commands** - Git 커밋 자동화
- **feature-dev** - 기능 개발 가이드

### 스타일
- **explanatory-output-style** - 설명적 출력
- **security-guidance** - 보안 가이드

### MCP
- **context7** - 최신 문서 조회
- **serena** - 심볼릭 코드 분석

## 설정 커스터마이징

### settings.json

권한 설정 예시:

```json
{
  "permissions": {
    "allow": [
      "Bash(git:*)",
      "Bash(npm:*)",
      "Read",
      "Write",
      "Edit"
    ],
    "deny": [
      "Bash(rm -rf /)",
      "Bash(sudo:*)"
    ]
  }
}
```

### 새 규칙 추가

`rules/` 디렉토리에 마크다운 파일을 추가하면 자동으로 적용됩니다:

```bash
# 예: React 규칙 추가
touch rules/react.md
```

### 새 커맨드 추가

`commands/` 디렉토리에 마크다운 파일을 추가:

```bash
# 예: 커스텀 명령어 추가
touch commands/my-command.md
```

## OS 지원

- ✅ macOS (Homebrew)
- ✅ Linux (apt, dnf, yum)

## 문제 해결

### 기존 설정이 있어서 설치 실패

```bash
./setup.sh --force  # 백업 후 덮어쓰기
```

### 심볼릭 링크 확인

```bash
ls -la ~/.claude/
```

### 순환 링크 확인

```bash
# 아래 파일들이 없어야 정상
ls agents/agents commands/commands
```

### 설정 초기화

```bash
./setup.sh --uninstall  # 심볼릭 링크 제거
rm -rf ~/.claude        # 완전 초기화 (주의!)
./setup.sh              # 재설치
```

## 버전 관리 제외 항목

`.gitignore`에 다음 항목이 포함되어 있습니다:

- `claude.json` - 민감 정보 (OAuth, userID)
- `.omc/` - 런타임 상태
- `*.local.json` - 로컬 오버라이드

## 라이선스

MIT
