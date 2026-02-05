---
name: serena
description: Serena MCP 서버 활성화. 심볼릭 코드 분석 및 편집 기능 사용 가능.
---

# Serena 프로젝트 활성화

현재 작업 디렉토리를 Serena 프로젝트로 활성화합니다.

## 실행 순서

1. **현재 설정 확인**: `get_current_config`로 활성화된 프로젝트 확인
2. **프로젝트 활성화**: `activate_project`로 현재 디렉토리 활성화
3. **심볼 개요 확인**: `get_symbols_overview`로 코드 구조 파악

## MCP 도구 사용

```bash
# 1. 현재 설정 확인
mcp-cli call plugin_serena_serena/get_current_config '{}'

# 2. 프로젝트 활성화 (현재 디렉토리)
mcp-cli call plugin_serena_serena/activate_project '{"project": "$PWD"}'

# 3. 심볼 개요 (선택)
mcp-cli call plugin_serena_serena/get_symbols_overview '{"relative_path": "."}'
```

## 활성화 후 사용 가능한 기능

| 도구 | 설명 |
|------|------|
| `find_symbol` | 심볼 검색 (함수, 클래스, 변수) |
| `get_symbols_overview` | 파일/디렉토리의 심볼 개요 |
| `find_referencing_symbols` | 심볼 참조 찾기 |
| `replace_symbol_body` | 심볼 본문 교체 |
| `insert_before_symbol` / `insert_after_symbol` | 심볼 주변에 코드 삽입 |
| `rename_symbol` | 심볼 이름 변경 (전체 참조 포함) |
| `search_for_pattern` | 패턴 검색 |

## 자동 실행

이 스킬이 호출되면 자동으로:
1. 현재 프로젝트 상태 확인
2. 필요시 프로젝트 활성화
3. 활성화 결과 보고

**Arguments**: $ARGUMENTS
