---
name: rhandoff
description: HANDOFF.md를 읽어서 세션 시작. 이전 작업 컨텍스트를 빠르게 로드.
---

Read the `HANDOFF.md` file in the repository root and start a new session.

## Steps

1. **Read** `HANDOFF.md` completely
2. **Cleanup** — reduce file size by removing redundancy:
   - Merge old sessions (3+ sessions ago) into a single "Previous Sessions" summary with one-line-per-session format
   - Keep only the last 2-3 sessions in full detail
   - Remove resolved items from "What Didn't Work" (if the issue was fixed in a later session)
   - Remove entries from "What Worked" that are obvious or no longer relevant
   - Update "Next Steps" to reflect current state
   - Write the cleaned version back to `HANDOFF.md`
3. **Summarize** the current state:
   - What sessions have been completed and key accomplishments
   - Any unresolved issues or blockers
   - Next steps listed in the document
4. **Identify** the next session number (increment from last completed session)
5. **Report** a concise session start summary in this format:

```
세션 N 시작.
- 완료: [key accomplishments from previous sessions]
- 미해결: [any open issues, or "없음"]
- 다음: [suggested next steps or "작업 대기"]
```

6. Ask what to work on if no clear next steps exist.

Keep the summary short and actionable. Do not repeat the entire HANDOFF.md contents.
