---
name: handoff
description: Compress the current conversation and work progress into a handoff note. Use for handoff, handover, resuming, summarizing progress, or letting a later session continue.
---

# Handoff

Write a handoff note so the next session can continue from the current state without re-excavating.

## Flow

1. **Pin the next objective**: if the user specifies what the next session should do, put it first; otherwise organize around the current unfinished tasks.
2. **Gather state**: lay out the goal, changes already made, key decisions, verification results, open items, blockers, and risks.
3. **Reference, don't copy**: for existing implementation notes, ADRs, commits, diffs, docs, and reports, give only the path or URL — don't repeat the full text.
4. **Protect sensitive info**: never write API keys, passwords, tokens, or PII; when needed, just note "credentials must be re-fetched."
5. **Give the next steps**: list the suggested skills, priority actions, files to read first, and things to watch out for.
6. **Save location**: when the user doesn't specify a location, write the handoff note to the system temp directory and give the absolute path in your reply; don't default to writing into the current repo.

## Handoff note format

```md
# Handoff

## Next Objective

## Current State

## Completed

## Key Decisions

## Important Files / Links

## Validation

## Open Items

## Risks / Blockers

## Suggested Skills

## Suggested Next Steps
```

## Completion criteria

- The next agent can understand the current goal, state, and best next step.
- Completed and unfinished content are separated, not mixed.
- Key decisions state their reasons and reference the relevant `CONTEXT.md`, ADR, implementation note, or code location.
- No large existing artifact is copied wholesale; only paths, URLs, or commits are referenced.
- No sensitive information is leaked.
