---
name: init-harness
description: Initialize a repo into an AI-native project — lay down the harness (AGENTS.md, standard verbs, gates, spec directory), same entry point for new and existing repos. Use for project initialization, onboarding an agent working agreement, or migrating legacy setup artifacts.
---

# Init Harness

Initialize a repo into an AI-native project. Same entry point for new and existing repos, same output: slots in place, verbs unified, gates explicit.

Before you start, read `references/harness.md` (the spec) and `references/templates.md` (the templates) in this directory.

## Which path

Repo nearly empty → new project; existing code → retrofit.

## New project

1. Ask about the tech stack and toolchain preferences, plus the working language and style (see "Language & style").
2. Lay down `AGENTS.md` and `docs/specs/` from the templates (including the spec template `docs/specs/TEMPLATE.md`); `CLAUDE.md` only references `AGENTS.md`.
3. Write real commands into the gates; for verbs whose toolchain isn't set up yet, mark them "TODO" in `AGENTS.md` rather than fabricating one.
4. Don't pre-create an empty `CONTEXT.md` / ADR; create them only when there's real content.

## Existing project

1. **Probe**: identify the tech stack, existing test / build / lint commands, CI config, legacy conventions (`AGENTS.md` / `CLAUDE.md` / cursor rules, etc.), old docs, and dev logs.
2. **Wrap the verbs**: wrap existing commands into standard verbs behind a unified entry point; aim only for a unified entry point, don't require changing tools. A verb you don't have stays honestly absent.
3. **Mine context**: draft `CONTEXT.md` and ADRs from the code structure, git history, and old docs, **then confirm with the human before writing them in**. Fold legacy conventions into the new `AGENTS.md`; ask first about anything conflicting, outdated, or uncertain.
4. **Assess the verification gap and report it honestly**: estimate how much regression protection the existing tests give behavior, and state plainly "the agent can safely operate autonomously within X; widening that requires shoring up Y first." This step can't be skipped or sugarcoated — it sets how strict the gates are.
5. **Set gates by the gap**: weak coverage → stricter gates, more approval points, loosening gradually as coverage fills in; write "shore up verification" as the first batch of `proposed` specs into `docs/specs/`.
6. **Migrate legacy artifacts**: move a legacy `docs/implementation-specs/` into `docs/specs/` (completed ones straight into `archive/`, unfinished ones get a status). Don't delete old material outright; get confirmation before migrating, archiving, or replacing.

## Language & style

For both new and existing repos, ask the user, then write the answers into the AGENTS.md `## Language` section:

- What language the docs (`CONTEXT.md`, ADR, `docs/specs/`) should be written in.
- What language replies / conversation should use.
- Any tone or style preference (optional).

Carry a sensible default so the user just confirms instead of answering cold. If the user has no preference, drop the section rather than leaving a placeholder.

## Questioning rules

- Show findings and recommendations before writing files.
- Ask at most 3 questions at a time, and only ones that change the initialization outcome.
- Don't ask what you can determine from the repo's existing files.

## Completion criteria

- `AGENTS.md` exists and is thin, covering task flow, gates (real commands), approval points, and the language / style the user chose.
- `docs/specs/` and the spec template `docs/specs/TEMPLATE.md` are in place (both new and existing projects).
- Standard verbs each run via one command, or the gap and fill-in plan are noted honestly.
- Existing project: the verification gap is reported honestly; legacy conventions are folded in or explicitly flagged for later.
- Closing note: which legacy content was folded in, what context was converted, what the first batch of `proposed` specs are, and what remains unhandled.
