---
name: review
description: Accept an implementation — gates first, then human judgment — deciding mergeability against the spec's acceptance criteria, and wrapping up with distillation and archiving. Use for review, checking a diff/PR, acceptance, or judging mergeability.
---

# Review

Acceptance, not a line-by-line recheck. What a machine can check goes to the gates; this skill only makes the judgments the gates can't cover.

## Prerequisites

- Run the automated gates defined in `AGENTS.md` first. **Gates not green → reject immediately, no human review.**
- When the repo has no `AGENTS.md` or no defined gates, substitute its existing test / lint / build commands; if there's no runnable verification at all, say so honestly and write "verification missing" into the findings itself.
- Find the corresponding spec (default: search `docs/specs/`). With no requirement source, review by code quality and risk, and state clearly that requirement conformance can't be judged.

## Review

1. **Against the acceptance criteria**: check off each of the spec's Acceptance criteria, with evidence (test, output, code location); "should be fine" is not accepted.
2. **Check scope**: any creep into Non-goals, any unrelated refactor mixed in.
3. **Check risks the gates can't cover**: boundary conditions, data migration, compatibility, security, concurrency, error handling.
4. **Check tests**: whether the critical path and failure path of new behavior are covered.

## Findings

Sorted by severity, only actionable issues:

```md
- [P1] Title
  File/location:
  Problem / Impact / Suggestion:
```

`P0` data loss, serious security, core flow unusable; `P1` must fix before merge; `P2` boundary issue, test gap; `P3` minor, non-blocking.

## Verdict

One of three: **mergeable / revise and re-review / needs re-shape**. When there are no issues, say explicitly that no blocking issues were found.

## Wrap-up distillation (when the verdict is mergeable)

- Flip the spec's status to `done`, move it into `docs/specs/archive/`.
- Stable terms and system boundaries that emerged during implementation go into `CONTEXT.md`; long-term decisions go into an ADR, with any overturned old ADR marked `superseded`.
- If this was a large feature, suggest a scoped `gc` over the changed area.

## Completion criteria

- Gate results confirmed; each acceptance criterion has evidence.
- Every finding has a clear impact and suggestion; no style preference disguised as a defect.
- The verdict directly supports the next action.
- When mergeable, distillation and archiving are done or explicitly listed as pending.
