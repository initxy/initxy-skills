# Harness spec

This spec defines what an "AI-native project" is. `init-harness` initializes a repo against it; `shape` / `review` / `gc` depend on it to run.

What it fixes is **slots and verbs**, not steps — steps are the model's job and evolve with the model; slots and verbs are the project's job and stay stable.

## Definition

One checkable sentence:

> Any agent cold-starting into the repo can, without asking a human, understand the task, complete the implementation, verify it itself, and write its decisions back into the repo — the human appears only at "define intent" and "collect results."

Broken into four properties:

| Property | Meaning | Carrier |
|---|---|---|
| Self-describing | Intent, domain concepts, boundaries, and past decisions live in the repo, not in someone's head | `AGENTS.md` / `CONTEXT.md` / ADR |
| Self-verifying | Test, build, and check are one-command verbs; the agent forms its feedback loop from them | Standard verbs + gates |
| Self-recording | Decisions and progress are a byproduct of the work, written back as you go, not an after-the-fact ritual | Spec with status + Progress log |
| End-to-end operable | run / release / deploy are scripted verbs too, so the agent can carry a change to the finish line | Verbs + approval gates |

One hard principle runs through it all: **a project's AI-nativeness is capped by the quality of its feedback loop.** What an agent can't verify, you can't safely hand to an agent. A repo with weak verification: shore up verification first, talk about autonomy second.

## Slots

```
AGENTS.md            # single entry point, kept thin: task flow, verbs, gates, language; points to the other slots
CONTEXT.md           # domain concepts, system boundaries, glossary
docs/adr/            # long-term decisions, with status (accepted / superseded)
docs/specs/          # one spec per task: intent + acceptance criteria + status + progress
scripts/ or Makefile # standard verbs
docs/releasing.md    # release runbook — only when the project publishes something
CONTRIBUTING.md      # contributor surface (+ PR template) — only when outside contributors are expected
```

- Tool entry points like `CLAUDE.md` only reference `AGENTS.md`; they hold no content.
- **`AGENTS.md` is self-contained**: write the method as steps a bare agent can follow; never reference skills, tools, or setup only the maintainer has. Costs nothing to keep, and pays off the moment any other agent — a contributor's, or your own in a fresh environment — shows up.
- Don't create empty placeholder files; a slot appears once it has real content.
- Stay close to common conventions (`AGENTS.md` is the de-facto standard); don't invent private formats — a project you initialize should read as AI-native to any agent tool.

## Verbs

`dev` / `test` / `lint` / `build` / `e2e` / `check` / `release`, one command per verb, written in `AGENTS.md`.

- **Wrap, don't replace**: for an existing repo, wrap current commands into a unified entry point; don't require switching tools.
- Don't fabricate a verb you don't have; pull in ones outside the list (e.g. `migrate`) all the same.
- The agent's feedback loop = run the relevant verb after a change; verb output must be machine-readable (exit code, error message).
- **`check` is the aggregate**: one command that runs every automated gate. It's what an agent — the maintainer's or a contributor's — runs before calling anything done.

## Gates and the definition of done

**done = every acceptance criterion met + all agreed gates green.** Both are required.

Gates come in two levels:

- **Automated gates**: test / lint / build and the like — the agent runs and judges them itself; green is the price of calling something done.
- **Approval gates**: irreversible or outward-facing actions — release, data migration, data deletion, external publishing — require a human to sign off.

**CI parity**: CI runs the same `check` verb agents run locally, so local green means CI green. When something can only run in CI (a live service, a matrix build), list it explicitly in `AGENTS.md` — a gate an agent can't reproduce and doesn't know about is a broken feedback loop for everyone but the maintainer.

A project with weak verification coverage runs stricter gates (smaller autonomous scope for the agent), loosening as coverage fills in.

## Release

Release is the approval gate exercised most often, so it gets a runbook: `docs/releasing.md` — only when the project publishes something (a package, a service, an app; the form doesn't matter).

- The runbook states what is published, the versioning policy (including who decides patch vs minor/major), and the procedure step by step — concrete enough that an agent can execute everything up to the sign-off.
- Changelog before publish: archived specs since the last release are the raw material — curated, user-visible changes, not commit subjects.
- The human sign-off takes a concrete, observable form the runbook names (pushing the tag, approving the release PR); automation refuses to publish a version that has no changelog entry.

## Spec lifecycle

The spec is the task's memory, and the entire basis for resuming across sessions — no separate handoff doc needed.

- Path `docs/specs/<YYYY-MM-DD>-<slug>.md`, slug in English; format per `docs/specs/TEMPLATE.md`.
- State machine: `proposed` (queued) → `active` (implementing) → `done` (review passed) → moved to `docs/specs/archive/`.
- `Plan` is a checkbox task ledger: discrete tasks in dependency order, ticked as they complete. It's the resume point after a session switch or context compaction — state lives in the checkboxes, not in narrative.
- **Claiming**: when more than one person or agent may work the repo in parallel, claim a spec before implementing — set `owner` (and `branch` if one exists) in the frontmatter when flipping it `active`. An `active` spec someone else owns is hands-off.
- The spec is a living doc: progress, decision changes, and friction (retries, confusion, tests that drag) go into the Progress log as you implement. Friction notes are the main signal source for `gc`'s architecture proposals.
- The spec is a one-shot artifact; code comments must not reference it. Long-term content moves into `CONTEXT.md` / ADR when review wraps up.

## Doc division of labor and the GC-able convention

**Code is the single source of truth for "what is"; docs only carry "why" and "what concept."** When they conflict, fix the docs.

For staleness to be judged mechanically — turning GC from a judgment call into a reconciliation pass:

- Specs carry status and date.
- ADRs carry status; one overturned by a newer decision is marked `superseded`, not deleted.
- `CONTEXT.md` entries point to verifiable code locations where possible.

## Behavior / structure separation

- Feature work changes behavior; maintenance work changes structure — **never in one diff**: run their verifications separately so failure signals don't get muddled.
- The price of keeping feature work focused (no drive-by refactors) is that structural drift accumulates, so entropy control is a separate, standing action — see below.

## Entropy control

| Layer | Trigger | What it does |
|---|---|---|
| Inline | Each task's review wrap-up | Archive the spec, update `CONTEXT.md` / ADR, clean only the files you touched |
| Milestone | After a large feature merges | Run `gc` over the changed area (scoped) |
| Global | Periodically (weekly suggested) | Whole-repo `gc`: doc reconciliation + friction scan + architecture proposals |

Architectural refactors should be infrequent and batched — a pattern emerging (rule of three) is the moment to act; doc GC is frequent and automatic.

## Contributor surface

Applies when agents other than the maintainer's show up — an open-source repo, or any repo shared across people. Every convention here stays tool-agnostic: it must work for whatever agent a contributor brings.

- `AGENTS.md` is already self-contained (see Slots — that rule is unconditional); here it's what lets a contributor's agent get the full working conventions from the same file the maintainer's agent reads.
- `CONTRIBUTING.md` is the front door for humans and agents alike, and stays thin: read `AGENTS.md` first, how to run `check`, when a change needs an issue or spec before code (large or decision-changing work), and the AI-contribution policy.
- **AI-contribution policy — welcoming but accountable**: agent-written contributions are first-class; every PR has a human owner who understands the change and can defend it in review; every PR states how it was verified. Submissions showing no understanding of the change are closed without detailed review.
- The PR template asks for what reviewers need from any contributor, human or agent: what changed and why, how it was verified, and doc lockstep (ADR / `CONTEXT.md` updated when a decision changed; spec updated when one is implemented).

## The human's three touchpoints

1. **Define intent**: what to build, the trade-offs, the taste (`shape`).
2. **Collect results**: judgments outside the acceptance criteria (product feel, UX), plus signing off approval gates (`review` + approval).
3. **Fix the harness, not the output**: an agent that fails repeatedly, or keeps asking the same class of question, signals a gap in context or verification; the right move is to patch the harness so it doesn't recur.
