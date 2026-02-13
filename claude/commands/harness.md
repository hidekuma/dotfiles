---
name: harness
description: Eval harness 세팅. ARCHITECTURE.md + EXECPLAN.md 자동 생성.
---

You are setting up an **eval harness** for this project. Your goal is to produce two files: `ARCHITECTURE.md` and `EXECPLAN.md`.

**Focus area (optional):** $ARGUMENTS

---

## Step 1: Detect Mode

Count source code files in the project (exclude node_modules, .git, dist, build, vendor, __pycache__, .venv).

- **3+ source files → Mode 1** (Analysis mode)
- **< 3 source files → Mode 2** (Scaffold mode)

---

## Step 2: Generate Files

### Mode 1 — Analysis Mode

Deeply analyze the codebase. If `$ARGUMENTS` is provided, focus analysis on that area while still covering the full structure.

**ARCHITECTURE.md** — Write all 11 sections with real, specific content derived from the codebase:

1. **System Overview** — Purpose, core value proposition, 2-3 sentence summary
2. **High-Level Architecture** — Mermaid diagram of major components and their relationships (fall back to ASCII if Mermaid is inappropriate)
3. **Technology Stack** — Languages, frameworks, libraries, tools with versions where available
4. **Component Deep Dives** — Each major module/package: responsibility, public API surface, key files
5. **Data Flow** — How data moves through the system (request lifecycle, event flow, pipeline stages). Include a Mermaid sequence or flowchart diagram
6. **Data Model** — Core entities, relationships, storage strategy. Include ER diagram if applicable
7. **External Interfaces** — APIs consumed/exposed, file I/O, network protocols, third-party integrations
8. **Infrastructure & Deployment** — How the system is built, tested, deployed. CI/CD, containerization, hosting
9. **Security Model** — Authentication, authorization, secrets management, trust boundaries
10. **Performance Characteristics** — Known bottlenecks, caching strategy, scaling approach
11. **Cross-Cutting Concerns** — Logging, error handling, configuration management, observability

**EXECPLAN.md** — Write all 12 sections as an actionable execution plan:

1. **Objective** — What this project achieves, success criteria
2. **Scope** — In-scope and out-of-scope boundaries
3. **Prerequisites** — Required tools, accounts, environment setup
4. **Architecture Decisions** — Key technical decisions already made and their rationale (ADR-style)
5. **Implementation Phases** — Ordered phases with milestones. Use a checklist format
6. **Task Breakdown** — Granular tasks within each phase. Include file paths and estimated complexity (S/M/L)
7. **Testing Strategy** — Unit, integration, E2E approach. Coverage targets. Test file locations
8. **Data & State Management** — Database migrations, seed data, state transitions
9. **Integration Points** — External services, APIs, webhooks. Include error handling strategy
10. **Risk Register** — Known risks with likelihood, impact, and mitigation plan
11. **Rollback Plan** — How to revert each phase if something goes wrong
12. **Definition of Done** — Checklist that must pass before the project is considered complete

### Mode 2 — Scaffold Mode

Generate both files with placeholder content. Each section should contain:
- A brief description of what belongs in that section
- `<!-- TODO: Fill in after implementation begins -->` marker
- An example snippet showing the expected format/depth

Use the same 11 + 12 section structure as Mode 1.

---

## Step 3: Summary

After generating both files, output a brief summary:

- Which mode was used and why
- Key architectural insights discovered (Mode 1) or recommended next steps (Mode 2)
- Any areas that need human input marked with `<!-- REVIEW -->` tags

Do NOT ask for confirmation before generating. Analyze and produce the files directly.
