# 공통 패턴

## API 응답 포맷

### 표준 응답 인터페이스

```typescript
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: {
    total: number
    page: number
    limit: number
  }
}
```

### 사용 예시

```typescript
// 성공 응답
const successResponse: ApiResponse<User[]> = {
  success: true,
  data: users,
  meta: { total: 100, page: 1, limit: 10 }
}

// 에러 응답
const errorResponse: ApiResponse<null> = {
  success: false,
  error: '사용자를 찾을 수 없습니다'
}
```

## Custom Hooks 패턴

### useDebounce

```typescript
export function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value)

  useEffect(() => {
    const handler = setTimeout(() => setDebouncedValue(value), delay)
    return () => clearTimeout(handler)
  }, [value, delay])

  return debouncedValue
}

// 사용 예시
const searchTerm = useDebounce(inputValue, 300)
```

### useLocalStorage

```typescript
export function useLocalStorage<T>(key: string, initialValue: T) {
  const [storedValue, setStoredValue] = useState<T>(() => {
    try {
      const item = window.localStorage.getItem(key)
      return item ? JSON.parse(item) : initialValue
    } catch {
      return initialValue
    }
  })

  const setValue = (value: T | ((val: T) => T)) => {
    const valueToStore = value instanceof Function ? value(storedValue) : value
    setStoredValue(valueToStore)
    window.localStorage.setItem(key, JSON.stringify(valueToStore))
  }

  return [storedValue, setValue] as const
}
```

## Repository 패턴

### 인터페이스 정의

```typescript
interface Repository<T> {
  findAll(filters?: Filters): Promise<T[]>
  findById(id: string): Promise<T | null>
  create(data: CreateDto): Promise<T>
  update(id: string, data: UpdateDto): Promise<T>
  delete(id: string): Promise<void>
}
```

### 구현 예시

```typescript
class UserRepository implements Repository<User> {
  constructor(private db: Database) {}

  async findAll(filters?: UserFilters): Promise<User[]> {
    return this.db.users.findMany({ where: filters })
  }

  async findById(id: string): Promise<User | null> {
    return this.db.users.findUnique({ where: { id } })
  }

  async create(data: CreateUserDto): Promise<User> {
    return this.db.users.create({ data })
  }

  async update(id: string, data: UpdateUserDto): Promise<User> {
    return this.db.users.update({ where: { id }, data })
  }

  async delete(id: string): Promise<void> {
    await this.db.users.delete({ where: { id } })
  }
}
```

## Skeleton Projects 활용

### 새 기능 구현 워크플로우

```markdown
1. **검색**: 검증된 skeleton 프로젝트 찾기
   - GitHub trending 확인
   - awesome-* 목록 참조
   - 커뮤니티 추천 확인

2. **평가**: 병렬 Agent로 옵션 평가
   - 보안 평가 (Security Agent)
   - 확장성 분석 (Architect Agent)
   - 관련성 점수 (Explore Agent)
   - 구현 계획 (Planner Agent)

3. **선택**: 최적 매칭 선택
   - 요구사항 충족도
   - 유지보수 활성도
   - 문서화 수준
   - 라이선스 호환성

4. **적용**: 검증된 구조 내에서 반복
   - 기존 패턴 유지
   - 점진적 커스터마이징
   - 테스트 커버리지 확보
```

## Error Handling 패턴

### Result 타입

```typescript
type Result<T, E = Error> =
  | { ok: true; value: T }
  | { ok: false; error: E }

function parseJson<T>(json: string): Result<T> {
  try {
    return { ok: true, value: JSON.parse(json) }
  } catch (e) {
    return { ok: false, error: e as Error }
  }
}

// 사용
const result = parseJson<Config>(configStr)
if (result.ok) {
  console.log(result.value)
} else {
  console.error(result.error.message)
}
```

## 체크리스트

패턴 적용 시:
- [ ] 일관된 API 응답 포맷 사용
- [ ] Custom hooks 재사용
- [ ] Repository 패턴으로 데이터 접근 추상화
- [ ] 검증된 skeleton 프로젝트 활용
- [ ] Error handling 표준화
