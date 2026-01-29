# OpenCode & Claude 설정 관리 스크립트

이 디렉토리에는 AI 설정을 자동으로 설치/관리하는 스크립트가 포함되어 있습니다.

## 📜 setup-links.sh

OpenCode와 Claude의 심볼릭 링크를 자동으로 설정하는 스크립트입니다.

### 기능

- ✅ OpenCode 설정 자동 링크 생성
- ✅ Claude 설정 자동 링크 생성 (옵션)
- ✅ 기존 파일/디렉토리 백업
- ✅ 중복 링크 감지 및 처리
- ✅ 설치 후 자동 검증
- ✅ 컬러풀한 진행 상황 표시

### 사용법

#### 대화형 모드 (추천)

```bash
cd ~/dotfiles/opencode
./setup-links.sh
```

스크립트가 자동으로 선택 메뉴를 표시합니다:

```
어떤 AI를 설정하시겠습니까?

  1) OpenCode만
  2) Claude만
  3) 둘 다
  4) 취소

선택 (1-4):
```

#### 명령줄 옵션 모드

```bash
# OpenCode만 설치
./setup-links.sh --opencode

# Claude만 설치
./setup-links.sh --claude

# 둘 다 설치
./setup-links.sh --both

# 도움말 보기
./setup-links.sh --help
```

### 실행 예시

#### 대화형 모드

```
╔════════════════════════════════════════╗
║  AI 설정 심볼릭 링크 설치 스크립트    ║
╚════════════════════════════════════════╝

어떤 AI를 설정하시겠습니까?

  1) OpenCode만
  2) Claude만
  3) 둘 다
  4) 취소

선택 (1-4): 1

==> OpenCode 심볼릭 링크 설정
  → rules/ 디렉토리 링크 생성 중...
  ✓ 링크 생성: ~/.config/opencode/rules -> ~/dotfiles/opencode/rules
  
  → commands/ 디렉토리 링크 생성 중...
  ✓ 링크 생성: ~/.config/opencode/commands -> ~/dotfiles/opencode/commands
  
  → memory/ 디렉토리 생성 중... (로컬 전용)
  ✓ memory/ 디렉토리 생성됨

==> 심볼릭 링크 검증
  ✓ OpenCode rules: /Users/joseph/dotfiles/opencode/rules
  ✓ OpenCode commands: /Users/joseph/dotfiles/opencode/commands
  ✓ OpenCode memory: 디렉토리 존재

  ✓ 모든 심볼릭 링크가 정상적으로 생성되었습니다! ✨

==> 설치 완료!

  → 다음 명령어로 링크를 확인할 수 있습니다:
    ls -la ~/.config/opencode/
```

#### 명령줄 모드

```bash
./setup-links.sh --opencode
# 또는
./setup-links.sh --claude
# 또는
./setup-links.sh --both
```

### 안전 기능

1. **백업 자동 생성**: 기존 파일/디렉토리가 있으면 `.backup.YYYYMMDD-HHMMSS` 형식으로 백업
2. **중복 감지**: 이미 같은 링크가 존재하면 건너뜀
3. **사용자 확인**: 덮어쓰기 전 항상 사용자에게 확인
4. **자동 검증**: 설치 후 모든 링크가 올바르게 작동하는지 검증

### 에러 처리

- `dotfiles` 디렉토리가 없으면 즉시 종료
- 심볼릭 링크 생성 실패 시 에러 메시지 출력
- 검증 실패 시 exit code 1 반환

## 🔧 문제 해결

### 스크립트 실행 권한 없음

```bash
chmod +x ~/dotfiles/opencode/setup-links.sh
```

### 링크가 깨진 경우

```bash
# 기존 링크 제거
rm ~/.config/opencode/rules
rm ~/.config/opencode/commands

# 스크립트 재실행
./setup-links.sh
```

### dotfiles 경로가 다른 경우

스크립트를 열어서 `DOTFILES_DIR` 변수를 수정하세요:

```bash
# 기본값
DOTFILES_DIR="$HOME/dotfiles"

# 다른 경로로 변경
DOTFILES_DIR="$HOME/my-dotfiles"
```

## 📦 새 머신 설정 전체 과정

```bash
# 1. dotfiles 저장소 클론
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# 2. 스크립트로 자동 설치
cd ~/dotfiles/opencode
./setup-links.sh --claude  # Claude도 사용하는 경우

# 3. 완료! 이제 AI 설정이 모두 연결됨
```

## 🎯 장점

- **자동화**: 수동 명령어 입력 불필요
- **안전성**: 백업 및 검증 기능 내장
- **재사용**: 새 머신마다 반복 실행 가능
- **확장성**: Claude 외 다른 AI 추가도 쉬움
