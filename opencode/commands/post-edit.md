# Post-edit 자동화

파일 수정 후 자동으로 실행할 작업들입니다.

## 사용법

```bash
# 파일 수정 후 실행
파일 수정 후 post-edit 작업 실행해줘
```

## 자동 작업 목록

### 1. Prettier 자동 포맷팅 🎨

**대상 파일**: `.ts`, `.tsx`, `.js`, `.jsx`, `.json`, `.css`, `.md`

```bash
# 수정한 파일 포맷팅
npx prettier --write <수정한_파일>

# 예시
npx prettier --write src/auth/login.ts
```

**효과**:
- 일관된 코드 스타일
- 들여쓰기, 세미콜론, 따옴표 자동 정리
- 줄바꿈 최적화

### 2. TypeScript 타입 체크 (TS/TSX만)

**대상 파일**: `.ts`, `.tsx`

```bash
# 수정한 파일만 타입 체크
npx tsc --noEmit

# 또는 LSP 사용 (빠름)
# (에디터가 자동으로 수행)
```

**결과 처리**:
- ✅ 에러 없음 → 작업 완료
- ❌ 에러 있음 → 사용자에게 알림

### 3. ESLint 자동 수정

**대상 파일**: `.ts`, `.tsx`, `.js`, `.jsx`

```bash
# 자동 수정 가능한 문제 해결
npx eslint <수정한_파일> --fix

# 예시
npx eslint src/auth/login.ts --fix
```

**자동 수정 항목**:
- 사용하지 않는 import 제거
- 세미콜론 추가/제거
- 간단한 스타일 문제

### 4. Import 정리 (선택적)

**대상 파일**: `.ts`, `.tsx`, `.js`, `.jsx`

```bash
# import 문 자동 정렬
npx organize-imports-cli <수정한_파일>

# 또는 prettier-plugin-organize-imports 사용
```

**효과**:
- import 알파벳 순 정렬
- 사용하지 않는 import 제거
- 그룹핑 (외부 → 내부)

### 5. 관련 테스트 실행 (선택적)

**조건**: 테스트 파일이 존재하는 경우

```bash
# 수정한 파일의 테스트 실행
npm test -- --findRelatedTests <수정한_파일>

# 예시
npm test -- --findRelatedTests src/auth/login.ts
```

## 워크플로우

```
파일 수정
    ↓
Prettier 포맷팅 (자동)
    ↓
ESLint --fix (자동)
    ↓
TypeScript 타입 체크
    ↓
    ├─ ✅ 통과 → 완료
    └─ ❌ 에러 → 사용자에게 알림
```

## 자동화 스크립트

`scripts/post-edit.sh` 생성:

```bash
#!/bin/bash

FILE=$1

echo "📝 Post-edit 작업 실행: $FILE"

# 1. Prettier 포맷팅
echo "🎨 Prettier 포맷팅..."
npx prettier --write "$FILE"

# 2. ESLint 자동 수정 (JS/TS 파일만)
if [[ "$FILE" =~ \.(ts|tsx|js|jsx)$ ]]; then
    echo "🔧 ESLint 자동 수정..."
    npx eslint "$FILE" --fix 2>/dev/null || true
fi

# 3. TypeScript 체크 (TS/TSX 파일만)
if [[ "$FILE" =~ \.(ts|tsx)$ ]]; then
    echo "📝 TypeScript 체크..."
    npx tsc --noEmit || echo "⚠️ TypeScript 에러 발견"
fi

echo "✅ Post-edit 작업 완료"
```

실행 권한 부여:
```bash
chmod +x scripts/post-edit.sh
```

## VS Code 설정

`.vscode/settings.json`:

```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.organizeImports": true
  },
  "typescript.tsdk": "node_modules/typescript/lib"
}
```

## 주의사항

### 성능 최적화

- **빠른 피드백**: 포맷팅 → Lint → 타입 체크 순서
- **병렬 실행 금지**: 파일 충돌 방지
- **캐싱 활용**: ESLint, Prettier 캐시 사용

### 에러 처리

- **포맷팅 실패**: 무시하고 진행 (수동 수정 필요)
- **Lint 에러**: 자동 수정 불가능한 것만 알림
- **타입 에러**: 반드시 알림 (빌드 실패 방지)

## 체크리스트

Post-edit 후 확인:
- [ ] 파일이 포맷팅됨
- [ ] ESLint 경고 없음
- [ ] TypeScript 에러 없음
- [ ] Import가 정리됨
- [ ] 관련 테스트 통과 (실행 시)

## 통합 예시

OpenCode에서 사용:

```bash
# 파일 수정 후
edit src/auth/login.ts

# 자동으로 post-edit 실행
bash scripts/post-edit.sh src/auth/login.ts
```

또는 에디터 플러그인이 자동으로 처리.
