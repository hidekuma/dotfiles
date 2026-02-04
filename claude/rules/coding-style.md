# 코딩 스타일 가이드

## 불변성 (CRITICAL)

**항상 새 객체를 생성하고, 절대 변경하지 마세요**:

```javascript
// ❌ 잘못된 예: 뮤테이션
function updateUser(user, name) {
  user.name = name  // 뮤테이션!
  return user
}

// ✅ 올바른 예: 불변성
function updateUser(user, name) {
  return {
    ...user,
    name
  }
}
```

### 배열 불변성

```javascript
// ❌ 잘못된 예
const addItem = (arr, item) => {
  arr.push(item)  // 뮤테이션!
  return arr
}

// ✅ 올바른 예
const addItem = (arr, item) => [...arr, item]

// ✅ 배열 필터링
const removeItem = (arr, id) => arr.filter(item => item.id !== id)

// ✅ 배열 업데이트
const updateItem = (arr, id, updates) => 
  arr.map(item => item.id === id ? { ...item, ...updates } : item)
```

## 파일 구조

**많은 작은 파일 > 적은 큰 파일**:
- 높은 응집도, 낮은 결합도
- 일반적으로 200-400줄, 최대 800줄
- 큰 컴포넌트에서 유틸리티 추출
- 타입별이 아닌 기능/도메인별로 구성

### 디렉토리 구조 예시

```
src/
├── features/
│   ├── auth/
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── utils/
│   │   └── types.ts
│   └── dashboard/
│       ├── components/
│       ├── hooks/
│       └── utils/
├── shared/
│   ├── components/
│   ├── hooks/
│   └── utils/
└── lib/
```

## 에러 처리

**항상 포괄적으로 에러를 처리하세요**:

```typescript
// ❌ 잘못된 예: 에러 무시
try {
  const result = await riskyOperation()
  return result
} catch (error) {
  // 에러 무시
}

// ✅ 올바른 예: 적절한 에러 처리
try {
  const result = await riskyOperation()
  return result
} catch (error) {
  console.error('작업 실패:', error)
  throw new Error('사용자 친화적인 상세 메시지')
}
```

### 에러 타입별 처리

```typescript
try {
  const result = await apiCall()
  return result
} catch (error) {
  if (error instanceof ValidationError) {
    // 검증 에러 - 사용자에게 표시
    return { success: false, message: error.message }
  } else if (error instanceof NetworkError) {
    // 네트워크 에러 - 재시도 제안
    return { success: false, message: '연결 실패. 다시 시도해주세요.' }
  } else {
    // 예상치 못한 에러 - 로깅하고 일반 메시지
    logger.error('Unexpected error:', error)
    return { success: false, message: '오류가 발생했습니다.' }
  }
}
```

## 입력 검증

**항상 사용자 입력을 검증하세요**:

```typescript
import { z } from 'zod'

// 스키마 정의
const userSchema = z.object({
  email: z.string().email('유효한 이메일을 입력해주세요'),
  age: z.number().int().min(0).max(150),
  name: z.string().min(1).max(100)
})

// 검증 실행
try {
  const validated = userSchema.parse(input)
  // validated를 사용
} catch (error) {
  if (error instanceof z.ZodError) {
    // 검증 에러 처리
    console.error('검증 실패:', error.errors)
  }
}
```

## 함수 작성 원칙

### 1. 작고 집중된 함수
```typescript
// ❌ 너무 큰 함수
function processUserData(user) {
  // 100줄의 코드...
}

// ✅ 작고 집중된 함수들
function validateUser(user) { /* ... */ }
function enrichUserData(user) { /* ... */ }
function saveUser(user) { /* ... */ }

function processUserData(user) {
  const validated = validateUser(user)
  const enriched = enrichUserData(validated)
  return saveUser(enriched)
}
```

### 2. 순수 함수 선호
```typescript
// ✅ 순수 함수: 동일 입력 → 동일 출력, 부작용 없음
function add(a: number, b: number): number {
  return a + b
}

// ❌ 비순수 함수: 외부 상태 변경
let total = 0
function addToTotal(value: number) {
  total += value  // 부작용!
}
```

### 3. 명확한 함수명
```typescript
// ❌ 모호한 이름
function process(data) { /* ... */ }
function handle(item) { /* ... */ }

// ✅ 명확한 이름
function calculateUserDiscount(user) { /* ... */ }
function validateEmailFormat(email) { /* ... */ }
```

## 네이밍 컨벤션

### 변수명
```typescript
// Boolean: is, has, should
const isValid = true
const hasPermission = false
const shouldRetry = true

// 배열: 복수형
const users = []
const items = []

// 함수: 동사로 시작
function fetchUser() { }
function createOrder() { }
function validateInput() { }
```

### 상수
```typescript
// 대문자 스네이크 케이스
const MAX_RETRY_COUNT = 3
const API_BASE_URL = 'https://api.example.com'
const DEFAULT_TIMEOUT_MS = 5000
```

## 코드 품질 체크리스트

작업 완료 표시 전:
- [ ] 코드가 읽기 쉽고 이름이 명확함
- [ ] 함수가 작음 (<50줄)
- [ ] 파일이 집중됨 (<800줄)
- [ ] 깊은 중첩 없음 (4단계 이하)
- [ ] 적절한 에러 처리
- [ ] console.log 문 없음
- [ ] 하드코딩된 값 없음
- [ ] 뮤테이션 없음 (불변 패턴 사용)
- [ ] TypeScript 타입 에러 없음
- [ ] 테스트 통과

## 주석 작성

```typescript
// ❌ 나쁜 주석: 코드가 무엇을 하는지 반복
// 이름을 대문자로 변환
const upperName = name.toUpperCase()

// ✅ 좋은 주석: 왜 그렇게 하는지 설명
// API는 대소문자를 구분하지 않으므로 정규화
const normalizedName = name.toUpperCase()

// ✅ 좋은 주석: 복잡한 로직 설명
/**
 * 사용자의 할인율을 계산합니다.
 * 
 * 등급별 기본 할인에 누적 구매 금액에 따른
 * 보너스 할인을 추가로 적용합니다.
 * 
 * @param user - 할인을 계산할 사용자
 * @returns 할인율 (0-1 사이의 소수)
 */
function calculateDiscount(user: User): number {
  // 구현...
}
```

## 금지 패턴

### 1. any 타입 사용 금지
```typescript
// ❌ 절대 금지
function process(data: any) { }

// ✅ 명시적 타입 사용
function process(data: UserData) { }
// 또는 제네릭
function process<T>(data: T) { }
```

### 2. console.log 커밋 금지
```typescript
// ❌ 디버깅 코드 커밋 금지
console.log('Debug:', data)

// ✅ 적절한 로깅 라이브러리 사용
logger.debug('Processing data', { data })
```

### 3. 매직 넘버 금지
```typescript
// ❌ 의미 불명확
if (user.age > 18) { }

// ✅ 명명된 상수 사용
const ADULT_AGE = 18
if (user.age > ADULT_AGE) { }
```
