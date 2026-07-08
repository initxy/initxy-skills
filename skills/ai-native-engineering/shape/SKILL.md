---
name: shape
description: Converge a vague idea into a spec with acceptance criteria. Use for requirement discussion, approach clarification, unclear boundaries/decisions/acceptance criteria, or when an approach must be settled before implementation.
---

# Shape

Converge a vague idea into a spec. This is the "define intent" step of human-machine collaboration: **in this mode you write no implementation code, and no spec until the design has converged.**

The method is an interview: press every point that affects implementation to the bottom, walk every branch of the design tree, until you and the user share the same understanding. The spec isn't something to rush out — it's the byproduct that falls out naturally once the design converges.

## Red lines

- ❌ Asking two or three questions and deciding it's "close enough" to start drafting. As long as one point that would change the implementation path, boundary, or acceptance criteria remains unconfirmed with the user, the interview isn't over.
- ❌ Writing the spec before the design converges.
- ❌ Sliding from finished spec into implementation. Shape ends at the finalized draft; implementation is started separately by the user.

## Interview

Before starting, read `CONTEXT.md`, `docs/adr/`, the relevant code, and any related spec in `docs/specs/`; restate in one sentence what the user actually wants to achieve, then move into questioning:

- Ask one question at a time, carrying your recommended answer and the reasoning, so the user confirms or overrides rather than answering from scratch.
- Walk the design tree branch by branch. Definition of the design tree: every decision point that would change the implementation path, boundary, or acceptance criteria is a node; each time you settle a node, check what new downstream decision points it opens and add them to the queue. Settle prerequisite decisions first, then the ones that depend on them.
- Look up whatever you can from code, docs, and context; don't bring it to the user as a question.
- Only ask questions that would change the implementation path, boundary, or acceptance criteria.

**Exception**: when the user explicitly says "just give me an approach / don't interview / recommend directly," give the recommended approach and reasoning straight, flagging the key assumptions you made on their behalf.

## When the interview is done

- The queue is empty: settling the most recent decision opened no new decision points.
- Every decision that would change the implementation path, boundary, or acceptance criteria is confirmed.
- No open item blocks implementation.

When unsure, default to "not done yet" and keep asking.

Whenever a decision settles during the interview, record it in place: new domain terms and system boundaries go into (or are proposed for) `CONTEXT.md`; trade-offs that are costly to reverse and will be questioned later go into an ADR; one-off details aren't recorded.

## Finalizing

Enter this step only when every item under "When the interview is done" holds. Write the spec per the harness convention:

- Path `docs/specs/<YYYY-MM-DD>-<slug>.md`, format per the repo's `docs/specs/TEMPLATE.md`. When the repo has no template: frontmatter carries `status` and `created`, body follows Goal / Non-goals / Context / Decisions / Plan / Acceptance criteria / Risks / Progress log.
- Mark it `active` if implementation starts right after the interview; mark it `proposed` if it's queued for later.
- A small task can be output in the conversation only, not written to disk.
- Slug in English (kebab-case).

## Completion criteria

- The interview has converged (every item under "When the interview is done" holds).
- `Goal` says it in one sentence; `Non-goals` excludes the scope most likely to creep.
- `Acceptance criteria` can be checked off one by one in review.
- `Plan` shows the task breakdown and dependency order.
- Long-term information is written into, or explicitly proposed for, `CONTEXT.md` / ADR.
- Shape stops here, with no overstep into implementation.
