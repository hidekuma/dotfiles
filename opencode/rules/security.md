# 보안 가이드라인

## 필수 보안 체크

**모든 커밋 전 확인 사항**:
- [ ] 하드코딩된 시크릿 없음 (API 키, 비밀번호, 토큰)
- [ ] 모든 사용자 입력 검증됨
- [ ] SQL 인젝션 방지 (파라미터화된 쿼리)
- [ ] XSS 방지 (HTML 새니타이즈)
- [ ] CSRF 보호 활성화
- [ ] 인증/권한 확인됨
- [ ] 모든 엔드포인트에 Rate Limiting
- [ ] 에러 메시지가 민감 정보를 노출하지 않음

## 시크릿 관리

```typescript
// ❌ 절대 금지: 하드코딩된 시크릿
const apiKey = "sk-proj-xxxxx"

// ✅ 항상: 환경 변수 사용
const apiKey = process.env.OPENAI_API_KEY

if (!apiKey) {
  throw new Error('OPENAI_API_KEY가 설정되지 않았습니다')
}
```

## 환경 변수 체크리스트

- [ ] `.env` 파일이 `.gitignore`에 포함됨
- [ ] `.env.example`에 필요한 키 목록 문서화
- [ ] 프로덕션 환경에서 다른 시크릿 사용
- [ ] 로그에 시크릿이 출력되지 않음

## 보안 이슈 발견 시 프로토콜

1. **즉시 중단**
2. **security-reviewer** 에이전트 사용
3. **CRITICAL** 이슈 먼저 수정
4. 노출된 시크릿 즉시 교체
5. 전체 코드베이스에서 유사 이슈 검토

## 일반적인 보안 취약점

### 1. 인증/권한
```typescript
// ❌ 잘못된 예: 권한 체크 없음
app.delete('/api/users/:id', async (req, res) => {
  await deleteUser(req.params.id)
})

// ✅ 올바른 예: 권한 확인
app.delete('/api/users/:id', requireAuth, async (req, res) => {
  if (req.user.id !== req.params.id && !req.user.isAdmin) {
    return res.status(403).json({ error: '권한이 없습니다' })
  }
  await deleteUser(req.params.id)
})
```

### 2. SQL 인젝션
```typescript
// ❌ 잘못된 예: 문자열 연결
const query = `SELECT * FROM users WHERE email = '${email}'`

// ✅ 올바른 예: 파라미터화된 쿼리
const query = 'SELECT * FROM users WHERE email = ?'
await db.query(query, [email])
```

### 3. XSS (Cross-Site Scripting)
```typescript
// ❌ 잘못된 예: 새니타이즈 없이 HTML 삽입
element.innerHTML = userInput

// ✅ 올바른 예: textContent 사용 또는 새니타이즈
element.textContent = userInput
// 또는
import DOMPurify from 'dompurify'
element.innerHTML = DOMPurify.sanitize(userInput)
```

### 4. CSRF 보호
```typescript
// ✅ CSRF 토큰 사용
app.use(csrf())

app.post('/api/action', (req, res) => {
  // CSRF 미들웨어가 자동으로 토큰 검증
  // ...
})
```

## 민감 데이터 로깅 금지

```typescript
// ❌ 절대 금지
console.log('User login:', { email, password })
logger.info('API call', { headers: req.headers }) // Authorization 헤더 포함

// ✅ 올바른 예
console.log('User login:', { email })
logger.info('API call', { 
  headers: omit(req.headers, ['authorization', 'cookie']) 
})
```

## Rate Limiting

```typescript
import rateLimit from 'express-rate-limit'

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15분
  max: 100, // 최대 100 요청
  message: '너무 많은 요청이 발생했습니다. 나중에 다시 시도해주세요.'
})

app.use('/api/', limiter)
```

## 보안 헤더

```typescript
import helmet from 'helmet'

app.use(helmet()) // 기본 보안 헤더 설정
app.use(helmet.contentSecurityPolicy({
  directives: {
    defaultSrc: ["'self'"],
    styleSrc: ["'self'", "'unsafe-inline'"],
    scriptSrc: ["'self'"],
    imgSrc: ["'self'", 'data:', 'https:'],
  }
}))
```
