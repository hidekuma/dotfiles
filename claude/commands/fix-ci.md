---
name: fix-ci
description: 실패한 CI 테스트 자동 수정. "/fix-ci"만 입력하면 자동 처리.
---

Fix the failing CI tests:

1. **Identify** - Find which tests/checks are failing
2. **Analyze** - Read the error messages and stack traces
3. **Diagnose** - Understand root cause (not just symptoms)
4. **Fix** - Make minimal changes to fix the issue
5. **Verify** - Run tests locally to confirm fix
6. **Commit** - Create a commit with clear message

If CI logs aren't available, ask for them or check:
- `git log` for recent changes
- Test output files
- GitHub Actions / GitLab CI logs

Be systematic. Fix one issue at a time. Verify before moving to next.
