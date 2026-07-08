# initxy-skills

**English** · [简体中文](README.zh.md)

Turn your repo into a place where any agent can cold-start, understand the task, implement it, verify itself, and write its decisions back — no human in the loop except to **define intent** and **collect results**.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![skills.sh](https://skills.sh/b/initxy/initxy-skills)](https://skills.sh/initxy/initxy-skills)

Clone and drop the skill folders into your agent's skills directory (Claude Code shown):

```bash
git clone https://github.com/initxy/initxy-skills
mkdir -p ~/.claude/skills
cp -r initxy-skills/skills/*/*/ ~/.claude/skills/
```

Use `.claude/skills/` for a single project, or copy only the folders you want (e.g. `initxy-skills/skills/ai-native-engineering/shape`). Update later with `git pull` and re-copy.

## Why it's different

Most skill collections grow by adding skills — one per workflow step, teaching the model *how* to do each thing. That bet is depreciating fast: what you hardcode as best practice today, the next model already knows, and it just burns context.

This set bets the other way. It **removes** process and invests in the one thing that doesn't evolve with the model — your repo's conventions: where context lives, how to verify, what counts as done, how to stop drift. The steps in between go to the model.

| | Typical skill collections | initxy-skills |
|---|---|---|
| The bet | More skills cover more steps | Fewer skills; the repo owns the conventions |
| Teaches the model | *How* to work, step by step | Nothing — steps are the model's job |
| Invests in | Workflow procedures | Slots & verbs, stable across model generations |
| Over time | Depreciates as models improve | Holds — repo conventions don't move |

Peers like [mattpocock/skills](https://github.com/mattpocock/skills), [superpowers](https://github.com/obra/superpowers), [gstack](https://github.com/garrytan/gstack), and [ecc](https://github.com/WorldFlowAI/everything-claude-code) mostly cover more steps with more skills. This one goes the other direction: steps to the model, conventions to the repo.

## The bet

A repo is AI-native when any agent can cold-start into it and — without asking a human — understand the task, implement it, verify itself, and write decisions back. The human shows up only twice: **define intent** and **collect results**.

Four calls hold up the trade-off:

- **Fix slots and verbs, not steps.** Steps belong to the model and evolve with it. Slots (`AGENTS.md` / `CONTEXT.md` / ADR / spec) and verbs (`test` / `build` / `release`) belong to the repo and stay stable.
- **The feedback loop is the ceiling.** How much you can safely hand an agent ≈ the quality of the repo's feedback loop. What the agent can't verify, don't hand it — shore up verification before autonomy.
- **The repo is the memory.** Specs carry status and progress, written as you go. Pick up in any session with no handoff ritual.
- **Entropy control is its own track.** Feature work stays focused, so structure drifts by design; `gc` pulls it back periodically instead of relying on the model to tidy in passing.

There's a quieter third touchpoint too: when an agent fails repeatedly, fix the **harness**, not that one output. Repeated failure almost always means a gap in context or verification — patch it so next time it doesn't happen.

## Skills

```
init-harness  ·  one-time setup (new or existing repo — same entry)

  shape ──▶ implement (no skill: follow the spec, run the gates) ──▶ review
    ▲                                                                │
    └────────── gc (scoped after big features · periodic global) ◀───┘
```

### AI-native engineering

| Skill | What it does | When to use |
|---|---|---|
| `init-harness` | Lays the harness into a repo: `AGENTS.md`, standard verbs, gates, `docs/specs/`. For existing repos, first probes current commands, wraps them behind one entry point, then reports the verification gap honestly. | Onboarding a project, one-time |
| `shape` | Interview-style questioning that converges a vague idea into a spec with acceptance criteria — defines intent only, writes no implementation. | Requirements / boundaries / acceptance criteria unclear, before implementing |
| `review` | Runs the gates first (not green → rejected), then checks the spec's acceptance criteria one by one, and returns a verdict: mergeable / revise / re-shape. Archives on merge. | Deciding whether a change can merge |
| `gc` | Entropy control, discovery separated from execution: safe things (doc-vs-code reconciliation, dead-code cleanup, spec archiving) done directly; structural changes proposed only. | Scoped after a big feature merges; periodic global |

No `implement` skill: "follow the spec, run the gates, call it done" lives in the task flow in `AGENTS.md`. The implementation flow belongs to the project harness, not a separate skill.

### Self

| Skill | What it does | When to use |
|---|---|---|
| `handoff` | Compresses the current conversation and progress into a handoff note so the next session continues. | Handing off, resuming, summarizing progress |
| `translate-zh` | English → Chinese, producing idiomatic Simplified Chinese rather than a literal gloss; preserves structure and term consistency. | Translating English docs / Markdown / email |
| `write-zh` | Guided Chinese writing, section by section — de-AI'd, diagram-rich. | When you want to be guided through writing, not one-shot generation |

## What the harness lays down

`init-harness` drops these slots into the target repo (full spec: [harness.md](skills/ai-native-engineering/init-harness/references/harness.md)):

```
AGENTS.md              # single thin entry point: task flow, gates, language
CONTEXT.md             # domain concepts, system boundaries, glossary ("why", not "what is")
docs/adr/              # long-term decisions with status (accepted / superseded)
docs/specs/            # one spec per task: proposed → active → done → archive/
scripts/ or Makefile   # standard verbs: dev / test / lint / build / e2e / release
```

The definition of done is one line: **every acceptance criterion met, and all automated gates green.** Irreversible actions — release, data migration, data deletion — sit behind an approval gate a human must clear.

Every slot follows a common convention rather than a private format: `AGENTS.md` is the de-facto standard; specs and ADRs are plain Markdown. A repo you initialize reads as AI-native to any agent tool, not locked to this set.

## Getting started

1. Run `init-harness` in the project to lay down the slots and verbs, once.
2. Talk a new requirement through with `shape`, land it as a spec.
3. Let the agent implement against the spec (the task flow and definition of done are already in `AGENTS.md`), then accept with `review`.
4. After a big feature merges, run a scoped `gc`; schedule a periodic global `gc` on top.

If the requirement is already clear, skip `shape` and go straight to implementation. `handoff`, `translate-zh`, and `write-zh` are independent — use any of them standalone.

## Structure

Skills are split into two folders by purpose:

- `skills/ai-native-engineering/` — the engineering line: `init-harness`, `shape`, `review`, `gc`.
- `skills/self/` — everyday tools: `handoff`, `translate-zh`, `write-zh`.

Each skill is a `<name>/SKILL.md` under its category, in Agent Skills format. Most are single-file; `init-harness` and `write-zh` split their spec and templates into a sibling `references/` directory, referenced on demand.

## License

[MIT](LICENSE)
