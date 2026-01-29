# 🎯 OpenCode 토큰 최적화 가이드

이 문서는 OpenCode 사용 시 토큰과 비용을 최적화하는 전략을 담고 있습니다.

## 📊 현재 효율성 (기준: 2026-01-29)

```
일평균 비용: $0.11
캐시 효율: 88.8%
무료 모델 비율: 91%
효율성 등급: S급 (상위 5%)
```

## 🎯 최적화 전략

### 1. 모델 선택 전략

#### 무료 모델 최대 활용
```json
{
  "sisyphus": "github-copilot/claude-sonnet-4.5",  // 무료
  "oracle": "github-copilot/claude-sonnet-4.5",    // 무료로 변경!
  "explore": "gemini-3-flash",                     // 저렴
  "librarian": "gemini-3-flash"                    // 저렴
}
```

**예상 절감:** Oracle 사용 시 $0.34 → $0.00 (100% 절감)

#### 모델별 용도

| 모델 | 비용 | 용도 |
|------|------|------|
| `claude-sonnet-4.5` (GitHub Copilot) | **무료** | 일반 코딩, 분석, Oracle 작업 |
| `gemini-3-flash` | $0.01/1M | 빠른 검색, 탐색, 단순 작업 |
| `gemini-3-pro` | $0.30/1M | 복잡한 UI, 고급 분석 (최소화) |

### 2. Serena MCP 적극 활용

#### 전환 가능한 작업

```bash
# ❌ 비효율: 파일 전체 읽기
read src/components/Button.tsx

# ✅ 효율: 심볼만 읽기
serena_get_symbols_overview src/components/Button.tsx
serena_find_symbol "Button" --include-body

# 절감: ~90%
```

#### Serena 도구 사용 가이드

```bash
# 파일 검색
serena_find_file "*.tsx" "src/"                    # glob 대신

# 패턴 검색  
serena_search_for_pattern "TODO" --context 2       # grep 대신

# 심볼 탐색
serena_find_symbol "MyClass" --depth 1             # 구조만 파악

# 정확한 수정
serena_replace_content --mode regex "old.*new"     # edit 대신
```

**목표:** Serena 사용률 19% → 30%+

### 3. 에이전트 위임 활용

#### 위임하면 좋은 작업

```bash
# 대량 파일 분석
opencode --dgt auto "모든 컴포넌트에서 useState 사용 패턴 분석"

# 병렬 리팩토링
opencode --con 10 "모든 API 호출을 async/await로 변경"

# UI 작업
opencode "반응형 네비게이션 바 구현"  # 자동으로 frontend 에이전트 위임
```

**장점:**
- 에이전트는 독립 컨텍스트 사용
- 메인 세션 토큰 절약
- 병렬 처리로 속도 향상

**목표:** delegate_task 사용률 0.5% → 5%+

### 4. 프로젝트 메모리 활용

#### 세션 시작 시

```bash
# 메모리에서 컨텍스트 복원
"이전 세션 컨텍스트 로드해줘"
```

#### 세션 종료 시

```bash
# 학습한 패턴 저장
"현재 프로젝트 패턴을 메모리에 저장해줘"
```

**효과:**
- 다음 세션에서 재탐색 불필요
- 세션당 5~10K 토큰 절약

### 5. 캐시 최적화

#### 캐시 친화적 패턴

```bash
# ✅ 좋음: 같은 파일 반복 참조
"auth.ts 분석"
"auth.ts 수정"
"auth.ts 테스트 추가"
# → 두 번째부터는 캐시 사용

# ❌ 나쁨: 매번 다른 파일
"file1.ts 분석"
"file2.ts 분석"  
"file3.ts 분석"
# → 캐시 활용 없음
```

#### 작업 그룹화

```bash
# ❌ 비효율
"Button.tsx 수정"
[새 대화] "Input.tsx 수정"
[새 대화] "Form.tsx 수정"

# ✅ 효율 (한 세션에서)
"Button.tsx, Input.tsx, Form.tsx 모두 수정"
# → 공통 컨텍스트 캐시 활용
```

### 6. 플래그 활용

#### 깊은 분석이 필요할 때만

```bash
# 일반 작업
opencode "버그 수정"

# 복잡한 분석
opencode --ult --seq "아키텍처 전체 분석"

# 대규모 병렬
opencode --dgt auto --con 12 "모노레포 전체 리팩토링"
```

**주의:** `--ult --seq`는 32K 토큰 사용 → 필요할 때만!

### 7. 컨텍스트 관리

#### 심볼 활용

```markdown
# ✅ 효율적 (30-50% 토큰 절감)
→ auth → security risk
impl ⇒ validated_output
∴ tests fail

# ❌ 비효율적
This leads to authentication which leads to security risk
The implementation transforms to validated output  
Therefore the tests fail
```

#### 간결한 질문

```bash
# ✅ 좋음
"Button 컴포넌트 props 타입 에러 수정"

# ❌ 나쁨
"안녕하세요, 제가 Button 컴포넌트를 작성하고 있는데요, 
props에서 타입 에러가 발생하고 있습니다. 
어떻게 하면 수정할 수 있을까요?"
```

## 📈 최적화 로드맵

### Phase 1: 즉시 적용 (0일)
- [x] Oracle을 무료 모델로 변경
- [ ] 심볼 문법 익히기
- [ ] Serena 도구 사용법 숙지

**예상 절감:** 10%

### Phase 2: 습관 형성 (1-2주)
- [ ] Serena 사용률 30% 달성
- [ ] 에이전트 위임 5% 달성
- [ ] 프로젝트 메모리 활용 시작

**예상 절감:** 추가 20%

### Phase 3: 고급 최적화 (1개월+)
- [ ] 캐시 효율 90%+ 달성
- [ ] 세션당 평균 토큰 50K 이하
- [ ] 일평균 비용 $0.05 이하

**예상 절감:** 추가 20%

## 🎯 목표 지표

```
현재 → 1개월 후 목표

일평균 비용:        $0.11 → $0.05
세션당 토큰:        225K → 100K
Serena 사용률:      19% → 35%
에이전트 위임:      0.5% → 5%
캐시 효율:          88.8% → 92%
무료 모델 비율:     91% → 95%

총 절감 목표: 50%+
```

## 💡 실전 팁

### 1. 작업 시작 전 체크리스트

```
[ ] 이 작업은 Serena로 할 수 있나?
[ ] 에이전트에게 위임할 수 있나?
[ ] 비슷한 작업을 이전에 했나? (메모리 확인)
[ ] 무료 모델로 충분한가?
```

### 2. 비용 모니터링

```bash
# 매일 확인
opencode stats --days 1

# 주간 리뷰
opencode stats --days 7 --models

# 월간 분석
opencode stats --days 30 --models --tools 20
```

### 3. 실험 & 학습

```bash
# 같은 작업을 다른 방식으로 시도
방법 A: read + edit (일반적)
방법 B: serena_find_symbol + serena_replace_content (Serena)

# 토큰 비교
opencode stats --days 1
```

## 🚨 피해야 할 패턴

### 1. 토큰 폭탄

```bash
# ❌ 큰 파일 전체 읽기
read dist/bundle.js  # 10,000+ 줄

# ❌ 불필요한 전체 탐색
"모든 파일에서 console.log 찾기" + read 100 files
```

### 2. 캐시 미스

```bash
# ❌ 세션 자주 바꾸기
매 작업마다 새 대화 시작

# ❌ 컨텍스트 자주 초기화  
"이전 내용 무시하고..."
```

### 3. 비효율적 모델 사용

```bash
# ❌ 단순 작업에 고급 모델
"오타 수정" → claude-opus 사용

# ❌ 복잡한 작업에 약한 모델
"전체 아키텍처 재설계" → gemini-flash 사용
```

## 📚 참고 자료

- [Serena MCP 공식 문서](https://github.com/oraios/serena)
- [OpenCode 최적화 가이드](~/.config/opencode/rules/performance.md)
- [에이전트 위임 가이드](~/.config/opencode/rules/agents.md)

---

**마지막 업데이트:** 2026-01-29  
**다음 리뷰:** 2026-02-05 (1주일 후)
