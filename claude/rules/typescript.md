# TypeScript 베스트 프랙티스

## 타입 안전성

### any 사용 금지
```typescript
// ❌ 절대 금지
function process(data: any) { }

// ✅ 명시적 타입 사용
function process(data: UserData) { }
// 또는 제네릭
function process<T>(data: T) { }
```

### Strict Mode 필수
```json
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true
  }
}
```

## 타입 정의

### Interface vs Type
```typescript
// Interface: 객체 형태 정의, 확장 가능
interface User {
  id: string
  name: string
}

// Type: 유니온, 튜플, 복잡한 타입
type Status = 'active' | 'inactive' | 'pending'
type Coordinates = [number, number]
```

### 유틸리티 타입 활용
```typescript
// Partial - 모든 속성 optional
type PartialUser = Partial<User>

// Required - 모든 속성 필수
type RequiredUser = Required<User>

// Pick - 특정 속성만 선택
type UserName = Pick<User, 'name'>

// Omit - 특정 속성 제외
type UserWithoutId = Omit<User, 'id'>
```

## 체크리스트

- [ ] any 타입 없음
- [ ] strict mode 활성화
- [ ] null/undefined 명시적 처리
- [ ] 함수 반환 타입 명시
- [ ] 제네릭 적절히 활용
