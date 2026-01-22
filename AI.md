# 커스텀 설정

이 파일은 global instructions로 자동 로드됩니다.

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
