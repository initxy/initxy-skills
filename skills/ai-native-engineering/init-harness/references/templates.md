# Templates

File templates that `init-harness` writes into the target repo. Tailor to the repo: fill in real commands, add or drop approval points, and don't keep empty sections you won't use. The `## Language` section is filled from the user's answers at init time (doc language, reply language, and any tone/style preference) — see `init-harness`'s "Language & style" step; drop it if the user has no preference.

Templates marked **conditional** are laid down only when they apply: `docs/releasing.md` when the project publishes something; `CONTRIBUTING.md` and the PR template when outside contributors are expected.

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
- Implement against the spec: flip status to `active` on start (and set `owner` in the frontmatter when others may be working in parallel); tick Plan tasks as they complete; log progress, decision changes, and friction (retries / confusion / slow tests) in the spec's Progress log as you go.
- done = every acceptance criterion met + all automated gates green. Both required, no exceptions. Pass review before merge.
- Resume across sessions from the spec alone; write no separate handoff doc.

## Verbs

<!-- One command per verb; wrap existing tools rather than replacing them. A verb the project doesn't have stays TODO — don't fabricate. -->

- dev: `<cmd>`
- test: `<cmd>`
- lint: `<cmd>`
- build: `<cmd>`
- e2e: `<cmd>`
- check: `<one command that runs every automated gate>`
- release: `<cmd>` — approval gate, see below; drop along with the Release section if the project publishes nothing

## Gates

- Automated gates (required for done): run `check`. CI runs the same `check`, plus any CI-only steps listed here: <list them explicitly, or "none">.
- Approval gates (a human must sign off before running): release, data migration, data deletion, external publishing.

## Release
<!-- Drop this section if the project doesn't publish anything. -->

- Follow `docs/releasing.md`. Human sign-off = <tag push / release PR approval>.

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
owner: <set when flipping to active, if others may work in parallel — else drop>
branch: <the working branch, if one exists — else drop>
---

# <Title>

## Goal

## Non-goals

## Context

## Decisions

## Plan
<!-- Discrete tasks with checkboxes, in dependency order. Tick as you complete — this is the resume point across sessions and compactions. -->
- [ ] …
- [ ] …

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

## docs/releasing.md (conditional — the project publishes something)

Adapt to what the project actually ships — a package, a service, an app. Keep every step concrete enough for an agent to execute; only the sign-off belongs to a human.

```md
# Releasing

<!-- What is published, and the versioning policy — e.g. patch by default; minor / major is the maintainer's explicit call. -->

1. Changelog: collect user-visible changes since the last release — archived
   specs in `docs/specs/archive/` are the raw material. Curate; don't paste
   commit subjects.
2. Bump the version(s).
3. Run `check`; all gates green.
4. Human sign-off: <tag push / release PR approval>.
5. Publish: <release verb, or the automation the sign-off triggers>.
   Automation must refuse a version that has no changelog entry.
6. Verify the published artifact: install / deploy it fresh and exercise
   what this release changed.
```

## CONTRIBUTING.md (conditional — outside contributors expected)

```md
# Contributing

## Start with AGENTS.md

Read [`AGENTS.md`](AGENTS.md) before changing code — it holds the working
conventions: task flow, verbs, gates, and the definition of done. It is
self-contained: you (or your agent) need no particular tool or skill set to
follow it.

## Verify before submitting

`<check cmd>` reproduces the automated gates locally. <List anything that
only runs in CI, or drop this sentence.>

## Large changes

Open an issue first for anything large or decision-changing. Once the
approach is agreed, it becomes a spec in `docs/specs/` and implementation
proceeds against it.

## AI-assisted contributions

Contributions written with or by AI agents are welcome — this repo is built
to be workable by agents. Two requirements:

- Every PR has an accountable human who understands the change and can
  answer review questions about it.
- Every PR states how it was verified.

Submissions showing no understanding of the change are closed without
detailed review.
```

## PR template (conditional — write to the forge's expected path, e.g. .github/PULL_REQUEST_TEMPLATE.md)

```md
## Summary

<!-- What this changes and why. Lead with the conclusion. -->

## How verified

<!-- Which gates ran (`<check cmd>`) and what they showed. Note anything that couldn't be verified and why. -->

## Docs

- [ ] If a long-term decision changed: ADR and `CONTEXT.md` updated in lockstep.
- [ ] If this implements a spec: status, Plan checkboxes, and Progress log updated.
```
