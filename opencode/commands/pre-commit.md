# Pre-commit 체크

Git 커밋 전 자동 체크리스트를 실행합니다.

## 사용법

```bash
# 수동 실행
커밋하기 전에 pre-commit 체크 실행해줘

# 또는 커밋 시 자동으로 실행되도록 Git Hook 설정 가능
```

## 체크 항목

### 1. 보안 체크 🛡️

```bash
# console.log 제거 확인
grep -rn "console\.log" src/ --include=\*.{ts,tsx,js,jsx}

# 하드코딩된 시크릿 검색
grep -rn -E "(api[_-]?key|secret|password|token).*=.*['\"]" src/ --include=\*.{ts,tsx,js,jsx}
```

**결과**:
- ✅ 발견 없음 → 통과
- ❌ 발견됨 → **제거 필요**

### 2. 타입 체크

```bash
# TypeScript 타입 에러 확인
npx tsc --noEmit
```

**결과**:
- ✅ 에러 없음 → 통과
- ❌ 에러 있음 → **수정 필요**

### 3. 린트 체크

```bash
# ESLint 실행
npm run lint
# 또는
npx eslint src/
```

**결과**:
- ✅ 에러 없음 → 통과
- ⚠️ Warning만 있음 → 통과 (권장: 수정)
- ❌ Error 있음 → **수정 필요**

### 4. 포맷 체크

```bash
# Prettier 확인
npx prettier --check "src/**/*.{ts,tsx,js,jsx,json,css,md}"

# 자동 수정
npx prettier --write "src/**/*.{ts,tsx,js,jsx,json,css,md}"
```

### 5. 테스트 실행

```bash
# 변경된 파일 관련 테스트만
npm test -- --onlyChanged

# 또는 전체 테스트
npm test
```

**결과**:
- ✅ 모든 테스트 통과 → 통과
- ❌ 실패한 테스트 있음 → **수정 필요**

### 6. .env 파일 체크

```bash
# .gitignore에 .env 있는지 확인
grep -q "^\.env$" .gitignore

# git에 추적되고 있지 않은지 확인
! git ls-files | grep -q "^\.env$"
```

**결과**:
- ✅ .env가 무시됨 → 통과
- ❌ .env가 추적됨 → **⚠️ 위험: .gitignore 추가 필요**

## 자동 수정 가능 항목

다음 항목은 자동으로 수정 가능:

```bash
# Prettier 자동 포맷팅
npx prettier --write "src/**/*.{ts,tsx,js,jsx}"

# ESLint 자동 수정
npx eslint src/ --fix
```

## 체크리스트 요약

커밋 전 수동 확인:
- [ ] `console.log` 제거됨
- [ ] 하드코딩된 시크릿 없음
- [ ] TypeScript 에러 없음
- [ ] ESLint 에러 없음
- [ ] Prettier 포맷팅 적용됨
- [ ] 테스트 통과
- [ ] `.env` 파일 gitignore됨

모든 항목 통과 시:
✅ **커밋 가능**

## Git Hook으로 자동화

`.git/hooks/pre-commit` 파일 생성:

```bash
#!/bin/bash

echo "🔍 Pre-commit 체크 실행..."

# TypeScript 체크
echo "📝 TypeScript 체크..."
npx tsc --noEmit || exit 1

# Lint 체크
echo "🔧 ESLint 체크..."
npm run lint || exit 1

# 테스트 실행
echo "🧪 테스트 실행..."
npm test -- --onlyChanged || exit 1

# 보안 체크
echo "🛡️ 보안 체크..."
if grep -rq "console\.log" src/; then
    echo "❌ console.log 발견! 제거해주세요."
    exit 1
fi

echo "✅ 모든 체크 통과!"
```

Hook 실행 권한 부여:
```bash
chmod +x .git/hooks/pre-commit
```

## 주의사항

- Hook은 로컬에만 적용됨 (Git은 hook을 push하지 않음)
- 팀 전체 적용 시 Husky + lint-staged 사용 권장
- CI/CD 파이프라인에서도 동일한 체크 실행 필수
