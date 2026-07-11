---
name: gc
description: Project entropy control (gc) — reconcile docs against code, clear dead code and stale docs, archive specs, scan friction, and generate architecture-improvement proposals. Use to clean up a project, when docs have drifted from reality, to find refactor directions, after a large feature merges (scoped), or for periodic maintenance (global).
---

# GC

Entropy control. The price of keeping feature work focused is that structural and doc drift accumulate; this skill periodically pulls it back.

The core rule is **separate discovery from execution**: do the safe things directly (gate-protected), and for anything that touches structure, only propose — don't act.

## Scope

- **scoped**: triggered after a large feature merges, looking only at the changed area.
- **global**: triggered periodically (weekly suggested), across the whole repo.

When the user doesn't specify, judge from the trigger context and state which scope you're running.

## Actions

### 1. Reconcile (execute directly, gate-protected)

- Move `done`-but-unarchived specs in `docs/specs/` into `archive/`; flag long-stale `active` / `proposed` ones (including stale claims — an `owner` whose Progress log has gone quiet) for the user, don't delete on your own.
- Reconcile `CONTEXT.md` against code entry by entry: code is the single source of truth for "what is"; where they don't match, fix the doc.
- Mark ADRs overturned by newer decisions `superseded`, don't delete.
- Dead code, references to deleted files, stale TODOs: only counts once the full automated gate suite is green after removal.

### 2. Scan (record only, don't modify)

- Duplicate patterns (abstraction opportunities where the rule of three is met), shallow modules, tests that drag the feedback loop.
- **Mine the friction notes in spec Progress logs first**: where the agent retried, got confused, or got stuck on slow tests — wherever the agent worked hardest is where a refactor pays most. This beats abstract aesthetic judgment.

### 3. Propose (don't act)

- Write architecture-level changes as `proposed`-status specs in `docs/specs/`: motivation (cite specific friction or scan evidence), expected benefit, acceptance criteria.
- Proposals queue for a human to pick; a picked one goes through the normal shape → implement flow.

## Red lines

- Don't mix in feature changes; every change this skill makes leaves behavior unchanged.
- Run the gates after each cleanup step; if red, roll that step back.
- When you can't judge whether something is stale, ask — don't delete.

## Completion criteria

- Reconciliation changes are landed and all gates green.
- Every proposal has a motivation, evidence, and acceptance criteria, ready for shape / implement to pick up.
- Output a short report: what was cleaned, what was found, what was proposed, and what's left for the user to decide.
