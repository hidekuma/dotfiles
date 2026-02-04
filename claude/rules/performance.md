# 성능 최적화 가이드

## 모델 선택 전략

### 작업별 최적 모델

| 작업 유형 | 권장 모델 | 이유 |
|---------|----------|------|
| **탐색/검색** | Gemini 3 Flash | 빠르고 저렴, 충분한 품질 |
| **간단한 코드 작성** | Claude Sonnet 4.5 | 균형잡힌 성능/비용 |
| **복잡한 리팩토링** | Gemini 3 Pro | 깊은 추론 필요 |
| **아키텍처 설계** | GPT 5.2 Codex | 최고 품질 필요 |
| **문서 작성** | Gemini 3 Flash | 속도 중요 |

### Agent 모델 매핑

```json
{
  "agents": {
    "sisyphus": "github-copilot/claude-sonnet-4.5",
    "librarian": "google-vertex/gemini-3-flash-preview",
    "explore": "google-vertex/gemini-3-flash-preview",
    "oracle": "google-vertex/gemini-3-pro-preview",
    "frontend-ui-ux-engineer": "google-vertex/gemini-3-pro-preview",
    "code-reviewer": "google-vertex/gemini-3-pro-preview",
    "document-writer": "google-vertex/gemini-3-flash-preview"
  }
}
```

## 컨텍스트 윈도우 관리

### Critical Rule: 80 도구 제한

**실사용 컨텍스트 = 200k - (MCP 도구 * 1k)**

```
이론: 200k 컨텍스트
현실:
- 10 MCP servers × 8 tools/server = 80 tools → 120k 실사용
- 5 MCP servers × 6 tools/server = 30 tools → 170k 실사용
```

### MCP 관리 전략

```json
// opencode.json - 많이 설정하되, 선택적 활성화
{
  "mcp": {
    // 핵심 도구 (항상 활성)
    "serena": {"enabled": true},
    "context7": {"enabled": true},
    
    // 필요 시에만 활성화
    "sequential-thinking": {"enabled": false},
    "playwright": {"enabled": false},
    "github": {"enabled": false}
  }
}

// 프로젝트별 .opencode/settings.json
{
  "enabledMcpServers": ["serena", "sequential-thinking"]
}
```

### 도구 수 확인

```bash
# 현재 활성화된 도구 수 체크
# (OpenCode 세션에서)
도구 목록을 보여주세요 → 80개 미만인지 확인
```

## 토큰 최적화 원칙

### 1. MCP 스크립트는 블랙박스

```bash
# ❌ BAD: 컨텍스트 오염
cat scripts/long_script.py  # 수천 줄 로드

# ✅ GOOD: help만 확인
python scripts/long_script.py --help
```

### 2. 심볼 시스템 활용

**30-50% 토큰 절약**:

```markdown
# ❌ 장황한 표현 (50 토큰)
The authentication module is connected to and depends on the security module

# ✅ 심볼 사용 (15 토큰)
auth → security
```

### 주요 심볼

```
→ leads to          ⇒ transforms to
& and, combine      | or, separator
✅ completed        ❌ failed
⚠️ warning          🔍 analysis
⚡ performance      🔧 configuration
```

### 3. 점진적 정보 공개

```markdown
# ❌ 한 번에 모든 파일 읽기
read file1.ts
read file2.ts
read file3.ts
read file4.ts

# ✅ 필요한 것만 점진적으로
1. 먼저 파일 목록만: ls src/
2. 관련 파일만 읽기: read src/auth.ts
3. 필요하면 추가 읽기
```

## Skills 최적화

### 스킬 크기 제한

**SKILL.md는 500줄 이하 유지**:

```markdown
# ❌ 모든 것을 SKILL.md에
---
name: huge-skill
---

# 거대한 스킬 (2000줄)
...모든 상세 내용...

# ✅ 참조 기반 구조
---
name: optimized-skill
---

# 최적화된 스킬 (200줄)

핵심 가이드라인만 여기에.

상세 규칙은:
- rules/async-patterns.md
- rules/bundle-optimization.md
(필요할 때만 읽음)
```

### On-demand 로딩

```markdown
Skills는 필요할 때만 로드됩니다:

1. 시작 시: 스킬 이름 + 설명만 로드 (100 토큰)
2. 활성화 시: SKILL.md 전체 로드 (1000 토큰)
3. 참조 파일: 명시적으로 읽을 때만 로드

→ 불필요한 스킬은 로드 안 됨 = 토큰 절약
```

## 병렬 처리

### Delegate 플래그 활용

```bash
# ❌ 순차 처리 (느림)
각 파일을 하나씩 분석

# ✅ 병렬 처리 (빠름)
--delegate auto 전체 프로젝트를 병렬로 분석
--concurrency 10  # 10개 동시 실행
```

### 효과

- **40-70% 시간 절약**
- 50개 이상 파일 → `--delegate files`
- 7개 이상 디렉토리 → `--delegate folders`

## Rules 모듈화

### 컨텍스트 효율적 구조

```
# ❌ 하나의 거대한 파일 (2000줄)
~/.config/opencode/OPENCODE.md

→ 매 세션마다 2000줄 전체 로드
→ 20k 토큰 소비

# ✅ 모듈화된 rules (각 200줄)
~/.config/opencode/rules/
├── security.md      # 필요할 때만
├── coding-style.md  # 필요할 때만
├── testing.md       # 필요할 때만
└── performance.md   # 필요할 때만

→ 관련 규칙만 선택적 로드
→ 2-5k 토큰만 소비 (75% 절약)
```

## 세션 관리

### 메모리 영속성

```bash
# 매 세션마다 컨텍스트 재구축 (비효율)
새 세션 → 프로젝트 구조 다시 파악 → 5분 소요

# 메모리 영속성 사용 (효율)
세션 시작 → 이전 컨텍스트 로드 → 즉시 시작
```

### 세션 종료 시 저장

```json
// ~/.config/opencode/memory/session-state.json
{
  "projectStructure": "...",
  "currentTask": "...",
  "learnedPatterns": [...]
}
```

## 빌드 성능

### 프론트엔드

```typescript
// ❌ 모든 것을 한 번에 번들
import * from '@mui/material'

// ✅ 필요한 것만 import
import { Button } from '@mui/material/Button'

// ✅ 동적 import
const HeavyComponent = lazy(() => import('./HeavyComponent'))
```

### API 호출 최적화

```typescript
// ❌ 순차 호출 (느림)
const user = await fetchUser()
const posts = await fetchPosts()
const comments = await fetchComments()

// ✅ 병렬 호출 (빠름)
const [user, posts, comments] = await Promise.all([
  fetchUser(),
  fetchPosts(),
  fetchComments()
])
```

## 데이터베이스 최적화

### 인덱스

```sql
-- ❌ 인덱스 없음 (느림)
SELECT * FROM users WHERE email = 'test@example.com';

-- ✅ 인덱스 추가 (빠름)
CREATE INDEX idx_users_email ON users(email);
```

### N+1 쿼리 방지

```typescript
// ❌ N+1 쿼리
const users = await User.findAll()
for (const user of users) {
  const posts = await user.getPosts() // N번 쿼리!
}

// ✅ Eager loading
const users = await User.findAll({
  include: [Post]
})
```

## 캐싱 전략

### 레이어별 캐싱

```typescript
// 1. 메모리 캐시 (가장 빠름)
const cache = new Map()

function getUser(id) {
  if (cache.has(id)) return cache.get(id)
  const user = db.query('SELECT * FROM users WHERE id = ?', [id])
  cache.set(id, user)
  return user
}

// 2. Redis (중간)
const cached = await redis.get(`user:${id}`)
if (cached) return JSON.parse(cached)

// 3. 데이터베이스 (느림)
const user = await db.query(...)
await redis.set(`user:${id}`, JSON.stringify(user), 'EX', 3600)
```

## 성능 측정

### 프로파일링

```bash
# Node.js 프로파일링
node --prof app.js
node --prof-process isolate-*.log

# 번들 크기 분석
npm run build -- --analyze
```

### 성능 메트릭

- **LCP (Largest Contentful Paint)**: < 2.5s
- **FID (First Input Delay)**: < 100ms
- **CLS (Cumulative Layout Shift)**: < 0.1
- **TTFB (Time to First Byte)**: < 600ms

## 체크리스트

성능 최적화 시:
- [ ] 적절한 모델 선택 (작업에 맞게)
- [ ] MCP 도구 80개 미만
- [ ] 컨텍스트 효율적 구조
- [ ] 병렬 처리 활용
- [ ] 캐싱 전략 구현
- [ ] 데이터베이스 인덱스 확인
- [ ] 번들 크기 최적화
- [ ] 성능 메트릭 측정
