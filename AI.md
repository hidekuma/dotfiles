# OpenCode 핵심 가이드

> **중요**: 항상 한국어로 소통하고 응답합니다.

## ⚡ 기본 원칙

1. **토큰은 귀중하다** - MCP 도구 스크립트는 블랙박스로 취급 (`--help`로 사용법만 확인)
2. **Rules는 자동 로드** - `~/.config/opencode/rules/` 내용이 자동 적용됨
3. **모듈화된 설정** - 관심사별로 분리된 구조 유지

## 📋 플래그 빠른 참조

| 전체 플래그 | 약어 | 목적 | 예시 |
|------------|------|------|------|
| `--ultrathink` | `--ult` | 32K 토큰 깊이 분석 | `--ult --seq 아키텍처 분석` |
| `--seq` | - | Sequential MCP 활성화 | `--seq 버그 디버깅` |
| `--delegate [전략]` | `--dgt [전략]` | Sub-agent 병렬 처리 | `--dgt auto 모노레포 분석` |
| `--concurrency [n]` | `--con [n]` | 동시 실행 수 제어 | `--con 10 대규모 리팩토링` |

**조합 예시**: `--ult --seq --dgt auto --con 12` → 최대 분석 + 병렬 처리 + 12개 동시 실행

---

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
- cfg, impl, arch, perf, ops, env
- req, deps, val, test, docs, std
- qual, sec, err, rec, sev, opt

---

## 🎯 Agent Skills

### ⚛️ React & Performance
**react-best-practices** - Vercel 45개 규칙 (async, bundle, server 최적화)

### 🎨 UI/UX & Design
**web-design-guidelines** - 웹 접근성 & 베스트 프랙티스 100+ 규칙

---

## 📚 상세 규칙 위치

모든 상세 가이드라인은 자동으로 로드됩니다:

```
~/.config/opencode/rules/
├── security.md          # 보안 체크리스트
├── coding-style.md      # 불변성, 파일 구조
├── testing.md           # TDD, 커버리지
├── git-workflow.md      # 커밋 포맷
├── performance.md       # 모델 선택, 토큰 최적화
└── agents.md            # Agent 위임 가이드
```

---

## 🚀 빠른 시작

### 분석 작업
```bash
--seq 이 버그의 근본 원인을 찾아줘
--ult --seq 시스템 아키텍처 분석
```

### 병렬 작업
```bash
--dgt auto 전체 프로젝트 리팩토링
--con 10 --dgt folders 모든 모듈 분석
```

**프로젝트별 설정**: `.opencode/settings.json`에서 MCP 서버 선택적 활성화 가능

