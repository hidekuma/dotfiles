---
name: techdebt
description: Find and fix technical debt. Run at end of session to clean up.
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
