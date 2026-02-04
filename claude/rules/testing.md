# 테스팅 가이드라인

## TDD (Test-Driven Development)

**테스트 주도 개발 원칙을 따릅니다**:

### Red-Green-Refactor 사이클

1. **Red**: 실패하는 테스트 작성
2. **Green**: 테스트를 통과시키는 최소한의 코드 작성
3. **Refactor**: 코드 개선 (테스트는 계속 통과)

```typescript
// 1. Red: 실패하는 테스트 작성
describe('calculateDiscount', () => {
  it('should return 0.1 for premium users', () => {
    const user = { tier: 'premium' }
    expect(calculateDiscount(user)).toBe(0.1)
  })
})

// 2. Green: 최소한의 구현
function calculateDiscount(user) {
  if (user.tier === 'premium') return 0.1
  return 0
}

// 3. Refactor: 개선
function calculateDiscount(user: User): number {
  const DISCOUNT_RATES = {
    premium: 0.1,
    standard: 0.05,
    basic: 0
  }
  return DISCOUNT_RATES[user.tier] || 0
}
```

## 커버리지 요구사항

**최소 80% 코드 커버리지 유지**:

- 라인 커버리지: 80% 이상
- 브랜치 커버리지: 75% 이상
- 함수 커버리지: 90% 이상

```bash
# 커버리지 확인
npm test -- --coverage

# 커버리지가 기준 미달이면 빌드 실패
"jest": {
  "coverageThreshold": {
    "global": {
      "lines": 80,
      "branches": 75,
      "functions": 90
    }
  }
}
```

## 테스트 구조

### AAA 패턴 (Arrange-Act-Assert)

```typescript
describe('UserService', () => {
  it('should create a new user', async () => {
    // Arrange: 테스트 설정
    const userData = {
      email: 'test@example.com',
      name: '홍길동'
    }
    const mockDb = createMockDatabase()
    const service = new UserService(mockDb)

    // Act: 테스트 대상 실행
    const result = await service.createUser(userData)

    // Assert: 결과 검증
    expect(result).toBeDefined()
    expect(result.email).toBe(userData.email)
    expect(mockDb.insert).toHaveBeenCalledWith(userData)
  })
})
```

## 테스트 유형

### 1. 단위 테스트 (Unit Tests)

**개별 함수/메서드 테스트**:

```typescript
// utils/formatDate.ts
export function formatDate(date: Date): string {
  return date.toISOString().split('T')[0]
}

// utils/formatDate.test.ts
describe('formatDate', () => {
  it('should format date as YYYY-MM-DD', () => {
    const date = new Date('2025-01-29T14:30:00Z')
    expect(formatDate(date)).toBe('2025-01-29')
  })

  it('should handle edge cases', () => {
    const date = new Date('2025-12-31T23:59:59Z')
    expect(formatDate(date)).toBe('2025-12-31')
  })
})
```

### 2. 통합 테스트 (Integration Tests)

**여러 컴포넌트 간 상호작용 테스트**:

```typescript
describe('User Registration Flow', () => {
  it('should register user and send welcome email', async () => {
    // 실제 DB와 이메일 서비스 모킹
    const mockDb = createMockDatabase()
    const mockEmailService = createMockEmailService()
    
    const authService = new AuthService(mockDb)
    const notificationService = new NotificationService(mockEmailService)
    
    const user = await authService.register({
      email: 'test@example.com',
      password: 'secure123'
    })
    
    await notificationService.sendWelcomeEmail(user)
    
    expect(user).toBeDefined()
    expect(mockEmailService.send).toHaveBeenCalledWith({
      to: 'test@example.com',
      template: 'welcome'
    })
  })
})
```

### 3. E2E 테스트 (End-to-End Tests)

**전체 사용자 플로우 테스트**:

```typescript
// Playwright 예시
test('user can complete checkout', async ({ page }) => {
  // 로그인
  await page.goto('/login')
  await page.fill('[name="email"]', 'test@example.com')
  await page.fill('[name="password"]', 'password123')
  await page.click('button[type="submit"]')

  // 상품 선택
  await page.goto('/products')
  await page.click('text=Add to Cart')

  // 결제
  await page.goto('/checkout')
  await page.fill('[name="cardNumber"]', '4242424242424242')
  await page.click('text=Complete Purchase')

  // 성공 확인
  await expect(page.locator('text=Order Confirmed')).toBeVisible()
})
```

## 모킹 (Mocking)

### 외부 의존성 모킹

```typescript
// ❌ 실제 API 호출 (느리고 불안정)
it('should fetch user data', async () => {
  const user = await fetch('https://api.example.com/user/1')
  expect(user.name).toBe('John')
})

// ✅ 모킹 사용 (빠르고 안정적)
it('should fetch user data', async () => {
  // API 응답 모킹
  global.fetch = jest.fn(() =>
    Promise.resolve({
      json: () => Promise.resolve({ id: 1, name: 'John' })
    })
  )

  const user = await fetchUser(1)
  expect(user.name).toBe('John')
  expect(fetch).toHaveBeenCalledWith('https://api.example.com/user/1')
})
```

### 시간 모킹

```typescript
// 시간 의존적 코드 테스트
it('should expire token after 1 hour', () => {
  jest.useFakeTimers()
  const now = new Date('2025-01-29T12:00:00Z')
  jest.setSystemTime(now)

  const token = createToken()
  expect(token.isValid()).toBe(true)

  // 1시간 경과
  jest.advanceTimersByTime(60 * 60 * 1000)
  expect(token.isValid()).toBe(false)

  jest.useRealTimers()
})
```

## 테스트 네이밍

### 명확한 테스트 이름

```typescript
// ❌ 모호한 이름
it('works', () => { })
it('test user', () => { })

// ✅ 명확한 이름
it('should return 404 when user does not exist', () => { })
it('should throw ValidationError for invalid email format', () => { })
it('should update user profile and return updated data', () => { })
```

### Given-When-Then 패턴

```typescript
describe('Order Service', () => {
  it('given user has insufficient balance, when placing order, then should throw InsufficientFundsError', () => {
    // Given
    const user = { balance: 10 }
    const order = { total: 100 }
    
    // When & Then
    expect(() => orderService.place(user, order))
      .toThrow(InsufficientFundsError)
  })
})
```

## 테스트 데이터

### Factory 패턴 사용

```typescript
// test/factories/user.factory.ts
export function createUser(overrides = {}) {
  return {
    id: Math.random().toString(),
    email: 'test@example.com',
    name: '테스트 유저',
    createdAt: new Date(),
    ...overrides
  }
}

// 사용
it('should handle premium users', () => {
  const premiumUser = createUser({ tier: 'premium' })
  expect(getPricing(premiumUser)).toBe(discountedPrice)
})
```

## 비동기 테스트

```typescript
// ✅ async/await 사용
it('should fetch data', async () => {
  const data = await fetchData()
  expect(data).toBeDefined()
})

// ✅ Promise 리턴
it('should fetch data', () => {
  return fetchData().then(data => {
    expect(data).toBeDefined()
  })
})

// ❌ 비동기 처리 안 함 (테스트가 너무 빨리 끝남)
it('should fetch data', () => {
  fetchData().then(data => {
    expect(data).toBeDefined() // 실행 안 됨!
  })
})
```

## 테스트 전/후 처리

```typescript
describe('Database Tests', () => {
  // 모든 테스트 전 한 번 실행
  beforeAll(async () => {
    await database.connect()
  })

  // 각 테스트 전 실행
  beforeEach(async () => {
    await database.clear()
    await database.seed()
  })

  // 각 테스트 후 실행
  afterEach(async () => {
    await database.clear()
  })

  // 모든 테스트 후 한 번 실행
  afterAll(async () => {
    await database.disconnect()
  })

  it('should create user', async () => {
    const user = await createUser()
    expect(user).toBeDefined()
  })
})
```

## 스냅샷 테스팅

```typescript
// React 컴포넌트 스냅샷
it('should render correctly', () => {
  const tree = renderer
    .create(<UserProfile user={mockUser} />)
    .toJSON()
  expect(tree).toMatchSnapshot()
})

// 스냅샷 업데이트가 필요할 때
// npm test -- -u
```

## 테스트 체크리스트

테스트 작성 시:
- [ ] 모든 새 기능에 테스트 있음
- [ ] 엣지 케이스 커버됨
- [ ] 에러 케이스 테스트됨
- [ ] 80% 이상 커버리지
- [ ] 테스트가 독립적임 (순서 무관)
- [ ] 빠르게 실행됨 (<5초 for unit tests)
- [ ] 명확한 테스트 이름
- [ ] 외부 의존성 모킹됨
- [ ] 실패 시 명확한 에러 메시지
