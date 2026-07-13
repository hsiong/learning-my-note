# AGENTS.md

## Commands

### `/init`

Initialize the orchestration environment. On receiving `/init`, the agent must:

1. **Scan project structure** — Read `GEMINI.md`, `codex-antigravity/`, and verify `codex-local` MCP server availability.
2. **Report readiness** — Display a status table showing:
   - Project root path
   - MCP bridge status (`codex` / `codex-reply` tool availability)
   - Knowledge items loaded
3. **Await task assignment** — Prompt the user for the next action.

---

## Task Artifact Storage

All orchestration tasks **must** persist their prompts and generated outputs using the following directory convention:

```
task/
└── <task-name>/
    └── <YYMMDDHHmm>/
        ├── prompt/    # All prompts used during the session
        └── output/    # All generated content and final deliverables
```

### Rules

| Rule | Detail |
|---|---|
| **`<task-name>`** | A short, descriptive, kebab-case name for the task (e.g., `finance-forecast`, `market-analysis`). |
| **`<YYMMDDHHmm>`** | Timestamp of **task completion** time, formatted as 2-digit year + month + day + hour + minute (e.g., `2605171645` for 2026-05-17 16:45). |
| **`prompt/`** | Store the initial prompt and all follow-up prompts sent during the multi-round session. Name files sequentially: `round-0-init.md`, `round-1-review.md`, `round-2-review.md`, etc. |
| **`output/`** | Store all generated responses and the final consolidated deliverable. Name files sequentially: `round-0-response.md`, `round-1-response.md`, ..., `final.md`. |
| **Timing** | The `<YYMMDDHHmm>` directory is created/renamed only at task completion, ensuring a single consistent timestamp across all artifacts. |

### Example

A 4-round financial forecast task completed at 2026-05-17 16:45 would produce:

```
task/
└── finance-forecast/
    └── 2605171645/
        ├── prompt/
        │   ├── round-0-init.md
        │   ├── round-1-review.md
        │   ├── round-2-review.md
        │   └── round-3-review.md
        └── output/
            ├── round-0-response.md
            ├── round-1-response.md
            ├── round-2-response.md
            ├── round-3-response.md
            └── final.md
```

---

## Orchestration Workflow

When executing a multi-round task:

1. **Initiate** — Call `codex(prompt)` with the task-specific prompt. Record the prompt to `prompt/round-0-init.md`.
2. **Capture** — Save the response to `output/round-0-response.md`. Extract the `threadId`.
3. **Review & Refine** (repeat 3–4 rounds):
   - Analyze the response, generate critical feedback.
   - Record feedback to `prompt/round-N-review.md`.
   - Call `codex-reply(threadId, prompt)` with the feedback.
   - Save response to `output/round-N-response.md`.
4. **Finalize** — Produce `output/final.md` with the validated plan.
5. **Stamp** — Name the `<YYMMDDHHmm>` directory using the completion timestamp.
