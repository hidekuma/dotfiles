# Git 워크플로우 가이드

## 커밋 메시지 포맷

### Conventional Commits 형식

```
<타입>(<범위>): <제목>

<본문>

<푸터>
```

### 타입 (Type)

| 타입 | 설명 | 예시 |
|------|------|------|
| `feat` | 새 기능 | `feat(auth): 소셜 로그인 추가` |
| `fix` | 버그 수정 | `fix(api): 사용자 조회 오류 수정` |
| `docs` | 문서 변경 | `docs(readme): 설치 가이드 업데이트` |
| `style` | 코드 포맷팅 (기능 변경 없음) | `style: prettier 적용` |
| `refactor` | 리팩토링 | `refactor(user): 중복 코드 제거` |
| `test` | 테스트 추가/수정 | `test(auth): 로그인 테스트 추가` |
| `chore` | 빌드/설정 변경 | `chore: eslint 설정 업데이트` |
| `perf` | 성능 개선 | `perf(db): 쿼리 최적화` |

### 예시

```bash
# 좋은 커밋 메시지
feat(auth): JWT 기반 인증 구현

- JWT 토큰 생성 및 검증 로직 추가
- 리프레시 토큰 메커니즘 구현
- 인증 미들웨어 작성

Closes #123

# 나쁜 커밋 메시지
git commit -m "수정"
git commit -m "버그 픽스"
git commit -m "코드 업데이트"
```

## 브랜치 전략

### 브랜치 네이밍

```
<타입>/<이슈번호>-<간단한-설명>

예시:
feature/123-social-login
fix/456-api-error
hotfix/789-security-patch
refactor/321-code-cleanup
```

### 기본 브랜치

- `main` / `master`: 프로덕션 코드
- `develop`: 개발 중인 코드
- `feature/*`: 새 기능 개발
- `fix/*`: 버그 수정
- `hotfix/*`: 긴급 수정

### 워크플로우

```bash
# 1. 새 브랜치 생성
git checkout -b feature/123-new-feature

# 2. 작업 진행 및 커밋
git add .
git commit -m "feat(feature): 새 기능 추가"

# 3. 원격에 푸시
git push origin feature/123-new-feature

# 4. PR 생성 (GitHub CLI)
gh pr create --title "feat: 새 기능 추가" --body "설명"

# 5. 리뷰 후 머지
gh pr merge 123 --squash
```

## 커밋 원칙

### 1. 원자적 커밋 (Atomic Commits)

**하나의 커밋 = 하나의 논리적 변경**

```bash
# ❌ 나쁜 예: 여러 기능을 한 커밋에
git add .
git commit -m "여러 기능 추가"

# ✅ 좋은 예: 각 기능을 별도 커밋
git add src/auth/
git commit -m "feat(auth): 로그인 기능 추가"

git add src/user/
git commit -m "feat(user): 프로필 조회 추가"
```

### 2. 의미 있는 커밋

```bash
# ❌ 의미 없는 커밋
git commit -m "변경사항"
git commit -m "업데이트"
git commit -m "wip"

# ✅ 의미 있는 커밋
git commit -m "fix(api): null 체크 누락으로 인한 크래시 수정"
git commit -m "perf(db): 사용자 조회 쿼리 인덱스 추가로 50% 개선"
git commit -m "refactor(auth): 중복된 검증 로직을 validateUser 함수로 통합"
```

### 3. 작고 자주 커밋

```bash
# ✅ 작업 단위로 자주 커밋
git commit -m "feat(auth): 로그인 API 엔드포인트 추가"
git commit -m "feat(auth): 로그인 유효성 검증 추가"
git commit -m "feat(auth): 로그인 에러 처리 추가"
git commit -m "test(auth): 로그인 테스트 케이스 추가"

# ❌ 하루 작업을 한 번에 커밋
git commit -m "로그인 기능 전체 구현"
```

## Pull Request (PR) 가이드

### PR 제목

커밋 메시지와 동일한 형식:

```
feat(auth): JWT 기반 인증 시스템 구현
fix(api): 사용자 조회 시 null 처리 오류 수정
```

### PR 본문 템플릿

```markdown
## 변경 사항
- JWT 토큰 생성 및 검증 로직 구현
- 리프레시 토큰 메커니즘 추가
- 인증 미들웨어 작성

## 테스트
- [ ] 단위 테스트 작성 완료
- [ ] 통합 테스트 작성 완료
- [ ] 수동 테스트 완료

## 스크린샷 (필요 시)
[스크린샷 첨부]

## 체크리스트
- [ ] 코드 리뷰 준비 완료
- [ ] 테스트 통과
- [ ] 문서 업데이트
- [ ] 브레이킹 체인지 없음 (또는 명시)

Closes #123
```

### PR 크기

- **Small PR (권장)**: 200-300줄 이하
- **Medium PR**: 300-500줄
- **Large PR (피해야 함)**: 500줄 이상

큰 PR은 여러 작은 PR로 나누기:

```bash
# 큰 기능을 여러 PR로 분리
# PR 1: 데이터 모델 정의
# PR 2: API 엔드포인트 추가
# PR 3: 프론트엔드 연동
# PR 4: 테스트 추가
```

## 코드 리뷰

### 리뷰어 체크리스트

- [ ] 코드가 요구사항을 충족하는가?
- [ ] 테스트가 충분한가?
- [ ] 에러 처리가 적절한가?
- [ ] 보안 이슈가 없는가?
- [ ] 성능 문제가 없는가?
- [ ] 코드가 읽기 쉬운가?
- [ ] 문서가 업데이트되었는가?

### 리뷰 코멘트 예시

```markdown
# 좋은 리뷰 코멘트
💡 제안: 이 로직을 별도 함수로 추출하면 테스트가 더 쉬울 것 같습니다.

⚠️ 주의: 여기서 null 체크가 필요해 보입니다.

✅ 좋습니다: 에러 처리가 잘 되어 있네요!

# 나쁜 리뷰 코멘트
❌ "이거 안 좋은데요" (구체적이지 않음)
❌ "다시 작성하세요" (건설적이지 않음)
```

## Git 유용한 명령어

### 커밋 수정

```bash
# 마지막 커밋 메시지 수정
git commit --amend -m "새로운 커밋 메시지"

# 마지막 커밋에 파일 추가
git add forgotten_file.ts
git commit --amend --no-edit

# ⚠️ 주의: 이미 푸시한 커밋은 amend 금지!
```

### 커밋 되돌리기

```bash
# 작업 디렉토리는 유지하고 커밋만 취소
git reset --soft HEAD~1

# 작업 디렉토리도 되돌리기 (주의!)
git reset --hard HEAD~1

# 특정 커밋 되돌리기 (새 커밋 생성)
git revert <commit-hash>
```

### Stash (임시 저장)

```bash
# 현재 변경사항 임시 저장
git stash

# 이름을 붙여서 저장
git stash save "작업 중인 기능"

# Stash 목록 보기
git stash list

# Stash 적용 및 삭제
git stash pop

# Stash 적용만 (삭제 안 함)
git stash apply
```

### 브랜치 관리

```bash
# 로컬 브랜치 목록
git branch

# 원격 브랜치 포함 전체 목록
git branch -a

# 머지된 브랜치 정리
git branch --merged | grep -v "main" | xargs git branch -d

# 원격 브랜치 삭제
git push origin --delete feature/old-feature
```

### 히스토리 보기

```bash
# 간단한 로그
git log --oneline

# 그래프와 함께
git log --oneline --graph --all

# 특정 파일의 히스토리
git log --follow -- path/to/file.ts

# 특정 작성자의 커밋
git log --author="홍길동"
```

## Git Hooks

### Pre-commit Hook

```bash
# .git/hooks/pre-commit
#!/bin/bash

# TypeScript 타입 체크
npm run type-check || exit 1

# Lint 체크
npm run lint || exit 1

# 테스트 실행
npm test || exit 1

echo "✅ Pre-commit checks passed!"
```

### Commit-msg Hook

```bash
# .git/hooks/commit-msg
#!/bin/bash

commit_msg=$(cat "$1")

# Conventional Commits 형식 검증
if ! echo "$commit_msg" | grep -qE "^(feat|fix|docs|style|refactor|test|chore|perf)(\(.+\))?: .+"; then
    echo "❌ 커밋 메시지가 Conventional Commits 형식이 아닙니다."
    echo "형식: <타입>(<범위>): <제목>"
    exit 1
fi

echo "✅ Commit message format is valid!"
```

## 체크리스트

커밋 전:
- [ ] console.log 제거됨
- [ ] 하드코딩된 시크릿 없음
- [ ] 테스트 통과
- [ ] TypeScript 에러 없음
- [ ] Lint 통과
- [ ] 의미 있는 커밋 메시지

PR 생성 전:
- [ ] 브랜치가 최신 main과 동기화됨
- [ ] 모든 테스트 통과
- [ ] PR 설명 작성 완료
- [ ] 스크린샷 첨부 (UI 변경 시)
- [ ] 리뷰어 지정
