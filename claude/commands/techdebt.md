---
name: techdebt
description: 기술 부채 탐지 및 수정. 세션 종료 시 정리용으로 실행.
---

Scan the codebase for technical debt:

1. **Duplicate code** - Find copy-pasted logic that should be abstracted
2. **Dead code** - Unused functions, imports, variables
3. **TODOs/FIXMEs** - Outstanding tasks in comments
4. **Type issues** - `any` types, missing type annotations
5. **Complexity** - Functions over 50 lines, deep nesting

For each issue found:
- File and line number
- Severity (High/Medium/Low)
- Suggested fix

Then offer to fix the top 3 highest-severity issues.
