# 커스텀 설정

이 파일은 global instructions로 자동 로드됩니다.

---

## ⚡ 토큰 최적화 원칙

**MCP 도구 사용 시 컨텍스트 관리**:
- MCP 도구 스크립트를 직접 읽지 말 것
- 스크립트는 **블랙박스**로 취급 - `--help`로 사용법만 확인
- 큰 스크립트 파일은 컨텍스트 윈도우 오염 방지
- 필요 시에만 선택적으로 읽기

**예시**:
```bash
# ✅ GOOD: 먼저 help로 사용법 확인
python scripts/with_server.py --help

# ❌ BAD: 소스 코드 전체를 읽어서 컨텍스트 낭비
cat scripts/with_server.py
```

**원칙**: 도구는 호출만 하고, 내부 구현은 절대적으로 필요할 때만 확인.

## 📋 플래그 빠른 참조

| 전체 플래그 | 약어 | 목적 | 예시 |
|------------|------|------|------|
| `--ultrathink` | `--ult` | 32K 토큰 깊이 분석 | `--ult --seq 아키텍처 분석` |
| `--seq` | - | Sequential MCP 활성화 | `--seq 버그 디버깅` |
| `--delegate [전략]` | `--dgt [전략]` | Sub-agent 병렬 처리 | `--dgt auto 모노레포 분석` |
| `--concurrency [n]` | `--con [n]` | 동시 실행 수 제어 | `--con 10 대규모 리팩토링` |

**조합 예시**: `--ult --seq --dgt auto --con 12` → 최대 분석 + 병렬 처리 + 12개 동시 실행

---

## 분석 플래그

### `--ultrathink` / `--ult`
**목적**: Critical system redesign analysis (~32K tokens)
**사용 시기**: 복잡한 시스템 분석, 아키텍처 설계, 레거시 현대화
**자동 활성화**: Sequential MCP (`--seq`), Context7 (`--c7`), 모든 MCP (`--all-mcp`)

**사용 예시**:
```
--ult --seq 이 레거시 시스템의 현대화 방안을 분석해줘
--ultrathink 이 아키텍처의 병목 지점과 개선 방안을 제시해줘
```

### `--seq` / `--sequential`
**목적**: Sequential MCP를 사용한 복잡한 다단계 분석
**사용 시기**: 디버깅, 시스템 설계, 구조화된 문제 해결
**MCP 서버**: `sequential-thinking`

**사용 예시**:
```
--seq 이 버그의 근본 원인을 단계적으로 찾아줘
--seq 이 성능 문제를 체계적으로 분석해줘
```

---

## 병렬 작업 플래그

### `--delegate [files|folders|auto]` / `--dgt [files|folders|auto]`
**목적**: Sub-agent를 활용한 병렬 처리로 40-70% 시간 절약
**전략**:
- `files`: 파일별 병렬 분석 (50개 이상 파일)
- `folders`: 디렉토리별 병렬 분석 (7개 이상 디렉토리)
- `auto`: 자동 전략 선택 (권장)

**사용 예시**:
```
--dgt auto 이 모노레포 전체를 분석해줘
--delegate files src/ 디렉토리의 모든 파일을 리팩토링해줘
--dgt folders 각 모듈의 테스트 커버리지를 확인해줘
```

### `--concurrency [n]` / `--con [n]`
**목적**: 동시 실행 sub-agent 수 제어 (기본: 7, 범위: 1-15)
**사용 시기**: 시스템 리소스에 맞춰 병렬 처리 최적화

**사용 예시**:
```
--con 10 --dgt folders 전체 프로젝트를 병렬로 분석
--concurrency 5 --delegate auto 중간 규모 리팩토링 작업
```

---

## 토큰 효율 - 심볼 시스템

Claude가 응답할 때 다음 심볼을 사용하여 30-50% 토큰 절약:

### 논리 & 흐름
- `→` leads to, implies (예: `auth.js:45 → security risk`)
- `⇒` transforms to (예: `input ⇒ validated_output`)
- `←` rollback, reverse (예: `migration ← rollback`)
- `⇄` bidirectional (예: `sync ⇄ remote`)
- `&` and, combine (예: `security & performance`)
- `|` separator, or (예: `react|vue|angular`)
- `:` define, specify (예: `scope: file|module`)
- `»` sequence, then (예: `build » test » deploy`)
- `∴` therefore (예: `tests fail ∴ code broken`)
- `∵` because (예: `slow ∵ O(n²) algorithm`)

### 상태 & 진행
- `✅` completed, passed
- `❌` failed, error → 즉시 조치 필요
- `⚠️` warning → 검토 필요
- `ℹ️` information
- `🔄` in progress
- `⏳` waiting, pending
- `🚨` critical, urgent
- `🎯` target, goal
- `📊` metrics, data
- `💡` insight, learning

### 기술 도메인
- `⚡` Performance (속도, 최적화)
- `🔍` Analysis (검색, 조사)
- `🔧` Configuration (설정, 도구)
- `🛡️` Security (보안)
- `📦` Deployment (배포)
- `🎨` Design (UI, 프론트엔드)
- `🌐` Network (웹, 네트워크)
- `📱` Mobile (반응형)
- `🏗️` Architecture (시스템 구조)
- `🧩` Components (모듈)

### 약어
**시스템**: cfg(configuration), impl(implementation), arch(architecture), perf(performance), ops(operations), env(environment)

**개발**: req(requirements), deps(dependencies), val(validation), test(testing), docs(documentation), std(standards)

**품질**: qual(quality), sec(security), err(error), rec(recovery), sev(severity), opt(optimization)

---

## 플래그 조합 예시

### 복잡한 시스템 분석
```
--ult --seq --dgt auto 이 레거시 시스템을 분석하고 현대화 방안을 제시해줘
```
→ 최대 깊이 분석(32K) + Sequential MCP + Sub-agent 병렬 처리

### 대규모 리팩토링
```
--dgt folders --con 10 전체 프로젝트를 리팩토링해줘
```
→ 디렉토리별 병렬 처리 + 10개 동시 실행

### 긴급 버그 수정
```
--seq 이 크리티컬 버그의 근본 원인을 찾아서 수정해줘
```
→ Sequential MCP로 체계적 디버깅

### 모노레포 전체 분석
```
--ult --dgt auto --con 12 이 모노레포의 모든 모듈을 분석해줘
```
→ 최대 깊이 분석 + 자동 전략 + 12개 병렬 실행

---

## 🎯 Agent Skills

사용 가능한 스킬들 (`~/.config/opencode/skills/`에 위치):

### React Best Practices
**이름**: `vercel-react-best-practices`
**설명**: React와 Next.js 성능 최적화 가이드라인 (Vercel Engineering)

**사용 시기**:
- React 컴포넌트나 Next.js 페이지 작성
- 데이터 페칭 구현 (클라이언트/서버)
- 성능 이슈 코드 리뷰
- 번들 크기나 로드 시간 최적화

**카테고리** (우선순위별):
1. ⚡ **Eliminating Waterfalls** (CRITICAL) - `async-*`
   - `async-defer-await`: await을 실제 사용하는 브랜치로 이동
   - `async-parallel`: 독립적 작업에 Promise.all() 사용
   - `async-api-routes`: API 라우트에서 promise를 일찍 시작, 늦게 await

2. 📦 **Bundle Size** (CRITICAL) - `bundle-*`
   - `bundle-barrel-imports`: barrel 파일 대신 직접 import
   - `bundle-dynamic-imports`: 무거운 컴포넌트에 next/dynamic 사용
   - `bundle-defer-third-party`: hydration 후 analytics/logging 로드

3. 🏗️ **Server-Side Performance** (HIGH) - `server-*`
   - `server-cache-react`: React.cache()로 요청별 중복 제거
   - `server-cache-lru`: LRU 캐시로 cross-request 캐싱
   - `server-parallel-fetching`: 컴포넌트 재구성으로 fetch 병렬화

4. 🌐 **Client-Side Data Fetching** (MEDIUM-HIGH) - `client-*`
   - `client-swr-dedup`: SWR로 자동 요청 중복 제거

5. 🔄 **Re-render Optimization** (MEDIUM) - `rerender-*`
   - `rerender-memo`: 비용 높은 작업을 memoized 컴포넌트로 추출
   - `rerender-dependencies`: effect에 primitive 의존성 사용

6. 🎨 **Rendering Performance** (MEDIUM) - `rendering-*`
7. ⚡ **JavaScript Performance** (LOW-MEDIUM) - `js-*`
8. 🧩 **Advanced Patterns** (LOW) - `advanced-*`

**참조**: `skills/react-best-practices/SKILL.md`

---

### Web Design Guidelines
**이름**: `web-design-guidelines`
**설명**: 웹 인터페이스 베스트 프랙티스에 대한 UI 코드 리뷰

**트리거**:
- "Review my UI"
- "Check accessibility"
- "Audit design"
- "Review UX"
- "Check my site against best practices"

**카테고리**:
- ♿ Accessibility (aria-labels, semantic HTML, keyboard handlers)
- 🎯 Focus States (visible focus, focus-visible patterns)
- 📝 Forms (autocomplete, validation, error handling)
- 🎬 Animation (prefers-reduced-motion, compositor-friendly transforms)
- 📐 Typography (curly quotes, ellipsis, tabular-nums)
- 🖼️ Images (dimensions, lazy loading, alt text)
- ⚡ Performance (virtualization, layout thrashing, preconnect)
- 🧭 Navigation & State (URL reflects state, deep-linking)
- 🌓 Dark Mode & Theming (color-scheme, theme-color meta)
- 📱 Touch & Interaction (touch-action, tap-highlight)
- 🌍 Locale & i18n (Intl.DateTimeFormat, Intl.NumberFormat)

**사용법**:
1. 최신 가이드라인 fetch: `https://raw.githubusercontent.com/vercel-labs/web-interface-guidelines/main/command.md`
2. 지정된 파일 읽기
3. 모든 규칙에 대해 체크
4. `file:line` 포맷으로 결과 출력

**참조**: `skills/web-design-guidelines/SKILL.md`

---

### Vercel Deploy
**이름**: `vercel-deploy`
**설명**: Vercel에 앱과 웹사이트를 즉시 배포. 인증 불필요 - claimable deployment 방식

**트리거**:
- "Deploy my app"
- "Deploy this to production"
- "Push this live"
- "Deploy and give me the link"

**기능**:
- 40+ 프레임워크 자동 감지 (`package.json`에서)
- Preview URL (라이브 사이트) + Claim URL (소유권 이전) 반환
- 정적 HTML 프로젝트 자동 처리
- `node_modules`, `.git` 제외

**작동 방식**:
1. 프로젝트를 tarball로 패키징
2. 프레임워크 감지 (Next.js, Vite, Astro 등)
3. 배포 서비스에 업로드
4. Preview URL과 Claim URL 반환

**지원 프레임워크**:
- React: Next.js, Gatsby, CRA, Remix
- Vue: Nuxt, Vitepress, Vuepress
- Svelte: SvelteKit
- 기타: Astro, Angular, Solid, Express, Hono 등

**참조**: `skills/claude.ai/vercel-deploy-claimable/SKILL.md`

---

---

## 🎨 Anthropic Agent Skills

Anthropic의 공식 스킬들 (`~/.config/opencode/anthropic-skills/skills/`):

### 🎨 Creative & Design

**Algorithmic Art** (`algorithmic-art`)
- p5.js로 알고리즘 아트 생성
- 시드 랜덤, 플로우 필드, 파티클 시스템
- 트리거: "generative art", "algorithmic art", "flow fields"

**Canvas Design** (`canvas-design`)
- 아름다운 시각 아트를 .png/.pdf로 생성
- 디자인 철학 기반 포스터/아트 제작
- 트리거: "create a poster", "piece of art", "design"

**Frontend Design** (`frontend-design`)
- 고품질 프론트엔드 인터페이스 생성
- 독창적이고 프로덕션급 UI/UX
- 트리거: "build web components", "landing page", "dashboard"
- ⚠️ 일반적인 "AI slop" 미학 회피 (centered layouts, purple gradients, Inter font)

**Theme Factory** (`theme-factory`)
- 10개 프리셋 테마 + 커스텀 테마 생성
- 슬라이드, 문서, 리포트, 랜딩 페이지에 적용
- 컬러 팔레트 + 폰트 페어링

**Slack GIF Creator** (`slack-gif-creator`)
- Slack 최적화 애니메이션 GIF 생성
- 크기: 128x128 (emoji) / 480x480 (message)
- FPS: 10-30, 3초 이하 권장

---

### 💼 Enterprise & Communication

**Brand Guidelines** (`brand-guidelines`)
- Anthropic 공식 브랜드 컬러 & 타이포그래피 적용
- 트리거: "brand colors", "style guidelines", "corporate identity"

**Internal Comms** (`internal-comms`)
- 내부 커뮤니케이션 작성 (3P 업데이트, 뉴스레터, FAQ 등)
- 트리거: "status report", "leadership update", "incident report"

**Doc Co-authoring** (`doc-coauthoring`)
- 문서 공동 작성 워크플로우
- 3단계: Context Gathering → Refinement → Reader Testing
- 트리거: "write documentation", "draft proposal", "create spec"

---

### 🛠️ Development & Technical

**MCP Builder** (`mcp-builder`)
- 고품질 MCP 서버 생성 가이드
- Python (FastMCP) / Node.js (MCP SDK) 지원
- LLM과 외부 서비스 통합

**Web Artifacts Builder** (`web-artifacts-builder`)
- 복잡한 다중 컴포넌트 HTML 아티팩트 생성
- 스택: React 18 + TypeScript + Vite + Tailwind + shadcn/ui
- 상태 관리, 라우팅, shadcn/ui 컴포넌트 필요 시 사용

**WebApp Testing** (`webapp-testing`)
- Playwright로 로컬 웹앱 테스트
- 프론트엔드 기능 검증, UI 디버깅, 스크린샷, 브라우저 로그

**Skill Creator** (`skill-creator`)
- 새로운 스킬 생성 가이드
- 트리거: "create a new skill", "update existing skill"

---

### 📄 Document Skills (Proprietary)

**DOCX** (`docx`)
- Word 문서 생성/편집/분석
- Tracked changes, comments, formatting preservation

**PDF** (`pdf`)
- PDF 텍스트/표 추출, 생성, 병합/분할
- 폼 작성 지원

**PPTX** (`pptx`)
- PowerPoint 프레젠테이션 생성/편집/분석
- 레이아웃, 코멘트, 스피커 노트

**XLSX** (`xlsx`)
- Excel 스프레드시트 생성/편집/분석
- 수식, 포맷, 데이터 분석, 시각화
- ⚠️ ZERO formula errors 원칙

---

## 스킬 사용 방법

스킬은 관련 작업이 감지되면 자동으로 사용됩니다. 명시적으로 트리거하려면:

```
# React 성능 최적화
이 React 컴포넌트를 react-best-practices에 따라 리뷰해줘

# UI/UX 감사
이 페이지를 web-design-guidelines로 체크해줘

# 배포
이 앱을 Vercel에 배포해줘

# 알고리즘 아트
algorithmic-art를 사용해서 flow field 생성해줘

# 프론트엔드 디자인
frontend-design으로 독창적인 랜딩 페이지 만들어줘

# 문서 생성
docx 스킬로 회사 제안서를 작성해줘
```
