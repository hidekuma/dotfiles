# Hooks 시스템

## Hook 유형

- **PreToolUse**: 도구 실행 전 (검증, 파라미터 수정)
- **PostToolUse**: 도구 실행 후 (자동 포맷팅, 검사)
- **Stop**: 세션 종료 시 (최종 검증)

## 현재 활성 Hooks (~/.claude/settings.json)

### PreToolUse

| Hook | Matcher | 기능 |
|------|---------|------|
| tmux reminder | Bash | `npm run dev`, `pnpm dev`, `yarn dev` 실행 시 tmux 세션이 아니면 경고 |

### PostToolUse

| Hook | Matcher | 기능 |
|------|---------|------|
| console.log warning | Edit | .ts/.tsx 파일 수정 후 console.log 발견 시 경고 |
| Task notification | Task | Agent 작업 완료 시 macOS 알림 |

### Stop

(현재 활성화된 Stop hook 없음)

## 추가 권장 Hooks

| Hook | Type | 기능 | 추가 방법 |
|------|------|------|----------|
| git push review | PreToolUse:Bash | push 전 diff 리뷰 | git push 패턴 감지 |
| doc blocker | PreToolUse:Write | 불필요한 .md 생성 차단 | Write matcher |
| TypeScript check | PostToolUse:Edit | TS 파일 수정 후 tsc 실행 | Edit matcher + .ts 조건 |
| Prettier format | PostToolUse:Edit | JS/TS 수정 후 자동 포맷 | Edit matcher |

## 자동 승인 권한

### 사용 지침

```markdown
✅ 사용 권장:
- 신뢰할 수 있고 잘 정의된 계획
- 반복적인 작업

❌ 사용 금지:
- 탐색적 작업
- dangerously-skip-permissions 플래그 사용
- 검증되지 않은 작업

💡 대안:
- ~/.claude.json의 `allowedTools` 설정 사용
```

## TodoWrite 모범 사례

### 사용 목적

TodoWrite 도구는 다음을 위해 사용:
- 다단계 작업 진행 추적
- 지시 이해 검증
- 실시간 조정 가능
- 세분화된 구현 단계 표시

### Todo 목록으로 파악 가능한 것

| 문제 유형 | 설명 |
|----------|------|
| 순서 오류 | 단계가 잘못된 순서로 진행 |
| 누락 항목 | 필요한 단계가 빠짐 |
| 불필요 항목 | 과도한 단계 추가 |
| 잘못된 세분화 | 너무 상세하거나 너무 추상적 |
| 요구사항 오해 | 지시를 잘못 이해 |

## Hook 작성 가이드

### PreToolUse Hook 예시

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "command": "echo '장시간 실행될 수 있습니다. tmux 사용을 권장합니다.'",
        "condition": "command.includes('npm') || command.includes('pnpm')"
      }
    ]
  }
}
```

### PostToolUse Hook 예시

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit",
        "command": "prettier --write \"$FILE_PATH\"",
        "condition": "filePath.endsWith('.ts') || filePath.endsWith('.tsx')"
      }
    ]
  }
}
```

## 체크리스트

Hook 설정 시:
- [ ] 적절한 Hook 유형 선택 (Pre/Post/Stop)
- [ ] matcher 패턴 정확히 설정
- [ ] condition 조건 명확히 정의
- [ ] 명령어 오류 처리 고려
- [ ] 성능 영향 최소화
