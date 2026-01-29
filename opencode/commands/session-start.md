# Session Start - 세션 시작

새 OpenCode 세션 시작 시 이전 컨텍스트를 로드합니다.

## 목적

- **컨텍스트 복원**: 이전 세션의 작업 내용 로드
- **프로젝트 구조 파악**: 전에 탐색한 구조 재사용
- **학습된 패턴 적용**: 이전에 추출한 패턴 활용
- **빠른 시작**: 프로젝트 재탐색 시간 절약

## 로드할 정보

### 1. 세션 상태 📊

`~/.config/opencode/memory/session-state.json`:

```json
{
  "lastSession": {
    "date": "2026-01-29T14:30:00Z",
    "project": "/path/to/project",
    "currentTask": "사용자 인증 API 구현 중",
    "completedTasks": [
      "로그인 엔드포인트 추가",
      "JWT 토큰 생성 로직"
    ],
    "nextSteps": [
      "리프레시 토큰 구현",
      "테스트 작성"
    ]
  }
}
```

### 2. 프로젝트 컨텍스트 🏗️

`~/.config/opencode/memory/project-context.json`:

```json
{
  "projectStructure": {
    "type": "monorepo",
    "framework": "Next.js 14",
    "packages": ["web", "api", "shared"],
    "techStack": ["TypeScript", "React", "Prisma", "tRPC"]
  },
  "keyFiles": {
    "config": ["tsconfig.json", "next.config.js"],
    "auth": ["src/auth/index.ts", "src/middleware/auth.ts"],
    "database": ["prisma/schema.prisma"]
  },
  "conventions": {
    "codingStyle": "불변성 원칙, 함수형",
    "fileStructure": "feature-based",
    "testLocation": "alongside source files"
  }
}
```

### 3. 학습된 패턴 💡

`~/.config/opencode/memory/learned-patterns.json`:

```json
{
  "patterns": [
    {
      "name": "Error Handling Pattern",
      "description": "이 프로젝트에서 사용하는 에러 처리 방식",
      "example": "try-catch + Result<T, Error> 타입 사용",
      "confidence": 0.9
    },
    {
      "name": "API Response Format",
      "description": "일관된 API 응답 구조",
      "example": "{ success: boolean, data?: T, error?: string }",
      "confidence": 0.95
    }
  ]
}
```

## 세션 시작 워크플로우

```
1. 세션 시작
   ↓
2. Memory 파일 확인
   ├─ 있음 → 로드
   └─ 없음 → 새 세션으로 시작
   ↓
3. 사용자에게 요약 제공
   "지난번에는 {currentTask}를 작업 중이셨습니다."
   "완료: {completedTasks}"
   "다음: {nextSteps}"
   ↓
4. 사용자 응답 대기
   ├─ "계속해줘" → 이전 작업 재개
   ├─ "새 작업" → 새 작업 시작
   └─ 무응답 → 대기
```

## 사용 예시

### 시나리오 1: 이전 작업 계속

```
[세션 시작]

AI: 안녕하세요! 👋

지난 세션 (2시간 전):
✅ 완료: 로그인 엔드포인트 추가, JWT 생성 로직
🔄 진행 중: 사용자 인증 API 구현
📋 다음: 리프레시 토큰 구현, 테스트 작성

이어서 작업하시겠습니까?

사용자: 응, 리프레시 토큰부터 시작하자

AI: [이전 컨텍스트를 바탕으로 즉시 작업 시작]
```

### 시나리오 2: 새 작업 시작

```
[세션 시작]

AI: 지난번엔 인증 API를 작업하셨네요.
새로운 작업을 시작하시겠습니까?

사용자: 응, 이제 결제 시스템 만들어야 해

AI: 알겠습니다. 기존 패턴을 따라 결제 시스템을 구현하겠습니다.
[학습된 패턴 적용]
```

## 구현

`scripts/session-start.sh`:

```bash
#!/bin/bash

MEMORY_DIR="$HOME/.config/opencode/memory"
SESSION_STATE="$MEMORY_DIR/session-state.json"
PROJECT_CONTEXT="$MEMORY_DIR/project-context.json"

echo "🚀 OpenCode 세션 시작..."

# Memory 파일 확인
if [ -f "$SESSION_STATE" ]; then
    echo ""
    echo "📊 이전 세션 정보:"
    
    # JSON 파싱 (jq 사용)
    if command -v jq &> /dev/null; then
        LAST_DATE=$(jq -r '.lastSession.date' "$SESSION_STATE")
        CURRENT_TASK=$(jq -r '.lastSession.currentTask' "$SESSION_STATE")
        
        echo "  ⏰ 마지막 작업: $LAST_DATE"
        echo "  🔄 진행 중: $CURRENT_TASK"
        echo ""
        echo "  ✅ 완료:"
        jq -r '.lastSession.completedTasks[]' "$SESSION_STATE" | sed 's/^/     - /'
        echo ""
        echo "  📋 다음 단계:"
        jq -r '.lastSession.nextSteps[]' "$SESSION_STATE" | sed 's/^/     - /'
    else
        cat "$SESSION_STATE"
    fi
    
    echo ""
    echo "이어서 작업하시겠습니까? (y/n)"
else
    echo "새 프로젝트입니다. 프로젝트 구조를 파악하겠습니다..."
fi
```

## 자동화

OpenCode가 시작될 때 자동 실행되도록 설정:

1. **OpenCode 설정**에 session-start hook 추가
2. 또는 첫 메시지로 자동 실행

## 이점

### 토큰 절약 ⚡
- 프로젝트 구조 재탐색 불필요 → **~5분 절약**
- 컨벤션 재학습 불필요 → **일관성 향상**

### 생산성 향상 📈
- 즉시 작업 재개 가능
- 컨텍스트 스위칭 비용 감소
- 이전 작업 맥락 유지

### 일관성 유지 🎯
- 동일한 패턴 지속 적용
- 프로젝트 규칙 준수
- 코드 스타일 통일

## 주의사항

- **보안**: 민감 정보는 저장하지 않음
- **용량**: 필요한 정보만 저장 (최대 50KB)
- **동기화**: 여러 세션 간 충돌 방지

## 체크리스트

세션 시작 시:
- [ ] Memory 파일 로드됨
- [ ] 이전 작업 요약 제공됨
- [ ] 사용자 의도 확인됨
- [ ] 프로젝트 컨텍스트 적용됨
- [ ] 학습된 패턴 준비됨
