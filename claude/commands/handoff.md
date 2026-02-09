---
name: handoff
description: 다음 에이전트를 위한 HANDOFF.md 생성. 컨텍스트 없이도 작업 이어받기 가능.
---

Create a `HANDOFF.md` file that enables a fresh agent to continue this task with zero prior context.

## Location

Place `HANDOFF.md` in the most relevant directory for the current task. If $ARGUMENTS specifies a path, use that instead.

## Required Sections

Write the following sections:

### 1. Goal
What is the end goal? One clear sentence.

### 2. Current Status
Where are we now? What percentage is done? What's the current state of the codebase?

### 3. What Was Tried
For each approach attempted:
- **Approach**: What was tried
- **Result**: Did it work or fail?
- **Why**: Why it succeeded or failed

### 4. Key Decisions Made
Important architectural or design decisions already made, with rationale. The next agent should NOT revisit these.

### 5. Remaining Work
Numbered list of concrete steps to finish the task. Be specific enough that the next agent can execute without guessing.

### 6. Important Context
- Relevant file paths
- Gotchas or traps to avoid
- Dependencies or constraints
- Any non-obvious details the next agent needs

## Rules

- Write as if the reader has **never seen this codebase** and has **no conversation history**
- Be concrete: file paths, function names, exact error messages
- Don't summarize what the code does in general — focus on **what changed and why**
- Keep it under 200 lines. Concise but complete.
- Write in English (code context), but match the project's language conventions
