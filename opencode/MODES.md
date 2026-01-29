# OpenCode 커스텀 모드

이 파일은 OpenCode에서 사용할 수 있는 커스텀 모드를 정의합니다.

## 사용법

메시지 앞에 모드 태그를 추가:

```xml
<ultrawork-mode>
당신의 요청...
</ultrawork-mode>
```

---

## 📋 정의된 모드

### 🚀 Ultrawork Mode

**활성화:**
```xml
<ultrawork-mode>
[작업 요청]
</ultrawork-mode>
```

**특징:**
- 최대 정밀도 및 완성도 요구
- 100% 확신 전 구현 금지
- Plan agent 필수 호출
- 모든 독립 작업 병렬 실행
- 검증 없이 완료 선언 금지
- 부분 구현 절대 금지

**사용 시기:**
- 복잡한 아키텍처 작업
- 실패 허용 안 되는 프로덕션 코드
- 여러 시스템 통합 작업

---

### 🔍 Analyze Mode

**활성화:**
```xml
<analyze-mode>
[분석 요청]
</analyze-mode>
```

**특징:**
- 컨텍스트 수집 우선
- Explore/Librarian 에이전트 병렬 실행
- 복잡한 경우 Oracle 컨설팅
- 충분한 정보 수집 후 종합 분석

**사용 시기:**
- 대규모 코드베이스 이해
- 버그 근본 원인 분석
- 아키텍처 리뷰

---

### ⚡ Rapid Mode

**활성화:**
```xml
<rapid-mode>
[빠른 작업 요청]
</rapid-mode>
```

**특징:**
- 빠른 실행 우선
- 명확한 작업만 즉시 수행
- 최소한의 질문
- 검증은 사후 진행

**사용 시기:**
- 간단한 버그 수정
- 명확한 요구사항
- 프로토타입 작업

---

### 🧠 Thinking Mode

**활성화:**
```xml
<thinking-mode>
[사고 요청]
</thinking-mode>
```

**특징:**
- 깊은 사고 과정 우선
- Sequential MCP 활용 (--seq)
- 단계별 추론 과정 표시
- 결론 도출 전 충분한 분석

**사용 시기:**
- 복잡한 알고리즘 설계
- 최적화 전략 수립
- 디버깅 전략 수립

---

### 🔬 Research Mode

**활성화:**
```xml
<research-mode>
[조사 요청]
</research-mode>
```

**특징:**
- 탐색 우선, 구현 나중
- Librarian 에이전트 적극 활용
- 외부 문서/예제 검색
- 베스트 프랙티스 조사

**사용 시기:**
- 새로운 라이브러리 학습
- 설계 패턴 조사
- 기술 스택 선정

---

## 🎯 모드 조합

여러 모드를 동시에 사용할 수 있습니다:

```xml
<ultrawork-mode>
<analyze-mode>
[복잡한 분석 + 최대 정밀도 작업]
</analyze-mode>
</ultrawork-mode>
```

---

## 🔧 CLI 플래그와의 관계

| XML 모드 | 대응 CLI 플래그 |
|----------|----------------|
| `<thinking-mode>` | `--seq` |
| `<ultrawork-mode>` | `--ult --seq --dgt auto` |
| `<rapid-mode>` | (플래그 없이 일반 실행) |
| `<analyze-mode>` | `--dgt auto` |

**예시:**
```bash
# 터미널에서
opencode --ult --seq "복잡한 아키텍처 분석"

# 대화에서 (동일한 효과)
<ultrawork-mode>
<thinking-mode>
복잡한 아키텍처 분석해줘
</thinking-mode>
</ultrawork-mode>
```

---

## 💡 커스텀 모드 만들기

자신만의 모드를 추가할 수 있습니다:

```markdown
### 🎨 Design Mode

**활성화:**
```xml
<design-mode>
[UI/UX 작업]
</design-mode>
```

**특징:**
- Frontend UI/UX 에이전트 활용
- 웹 디자인 가이드라인 적용
- 접근성 우선 고려
- 반응형 디자인 기본

**사용 시기:**
- UI 컴포넌트 작업
- 디자인 시스템 구축
- 사용자 경험 개선
```

---

## 📚 참고

- 모든 모드는 OPENCODE.md에 정의됨
- Skills로 모듈화 가능 (`~/.config/opencode/agent-skills/skills/`)
- AI가 이 문서를 읽고 모드를 이해함
- Claude 네이티브 기능이 아닌 OpenCode 전용 관례
