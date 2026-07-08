# Templates

File templates that `init-harness` writes into the target repo. Tailor to the repo: fill in real commands, add or drop approval points, and don't keep empty sections you won't use. The `## Language` section is filled from the user's answers at init time (doc language, reply language, and any tone/style preference) — see `init-harness`'s "Language & style" step; drop it if the user has no preference.

## AGENTS.md

```md
## Communication

- Be concise and direct: lead with the conclusion and the next step.
- State assumptions and risks when uncertain; skip filler.

## Language

- Docs (`CONTEXT.md`, ADR, `docs/specs/`): <language chosen at init>.
- Replies / conversation: <language chosen at init>.
<!-- Add a tone/style line only if the user stated a preference. -->

## Context

- Read `CONTEXT.md` before touching domain concepts, system boundaries, or stable conventions.
- Read `docs/adr/` before revisiting long-term architecture calls; never rely on ADRs marked `superseded`.
- Code is the single source of truth for "what is." When docs and code disagree, trust the code and fix the docs.
- Code comments reference `CONTEXT.md` and ADRs only — never `docs/specs/` (one-shot artifacts; the reference breaks once archived).

## Task flow

- Vague request → shape a spec first; a small, well-defined change can start directly.
- Implement against the spec: flip status to `active` on start; log progress, decision changes, and friction (retries / confusion / slow tests) in the spec's Progress log as you go.
- done = every acceptance criterion met + all automated gates green. Both required, no exceptions. Pass review before merge.
- Resume across sessions from the spec alone; write no separate handoff doc.

## Gates

- Automated gates (required for done): `<test cmd>`, `<lint cmd>`, `<build cmd>`.
- Approval gates (a human must sign off before running): release, data migration, data deletion, external publishing.

## Engineering constraints

- Feature work changes behavior; maintenance work changes structure. Never mix them in one diff.
- Prefer existing patterns; keep changes focused; no unrelated refactors.
- Prefer deep modules: a small interface hiding enough implementation.
- The interface is the test surface; don't introduce a seam without a real need to swap implementations.
- Run verification matched to the change's risk; if you can't verify, say why.

## Maintenance

- After a large feature merges, run a scoped gc over the changed area.
- Periodically (weekly is a good default) run a global gc: doc reconciliation, friction scan, architecture proposals.
```

## CLAUDE.md (create only if needed — a reference, nothing else)

```md
@AGENTS.md
```

## Spec template (write verbatim to docs/specs/TEMPLATE.md)

Each spec is created from this template as `docs/specs/<YYYY-MM-DD>-<slug>.md`; when `shape` finalizes one, the repo's `TEMPLATE.md` is the source of truth.

```md
---
status: proposed | active | done
created: YYYY-MM-DD
---

# <Title>

## Goal

## Non-goals

## Context

## Decisions

## Plan
<!-- task breakdown, dependency order, areas to touch -->

## Acceptance criteria

## Risks

## Progress log
<!-- Jot down as you implement: progress, decision changes, friction (retries / confusion / slow tests). Date each entry. -->
```

## ADR (docs/adr/NNN-<slug>.md)

```md
# ADR-NNN: <Title>

- Status: accepted | superseded by ADR-MMM
- Date: YYYY-MM-DD

## Context

## Decision

## Consequences
```
