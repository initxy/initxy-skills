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

1. Ask about the tech stack and toolchain preferences, the working language and style (see "Language & style"), and the two conditional-slot questions: does the project publish anything (→ `docs/releasing.md`), and are outside contributors expected (→ `CONTRIBUTING.md` + PR template).
2. Lay down `AGENTS.md` and `docs/specs/` from the templates (including the spec template `docs/specs/TEMPLATE.md`), plus whichever conditional slots apply; `CLAUDE.md` only references `AGENTS.md`.
3. Write real commands into the verbs and gates, including the `check` aggregate; for verbs whose toolchain isn't set up yet, mark them "TODO" in `AGENTS.md` rather than fabricating one. If CI exists or is being set up, point it at the same `check` command.
4. Don't pre-create an empty `CONTEXT.md` / ADR; create them only when there's real content.

## Existing project

1. **Probe**: identify the tech stack, existing test / build / lint commands, CI config, release automation, contributor files (CONTRIBUTING / issue / PR templates), legacy conventions (`AGENTS.md` / `CLAUDE.md` / cursor rules, etc.), old docs, and dev logs.
2. **Wrap the verbs**: wrap existing commands into standard verbs behind a unified entry point; aim only for a unified entry point, don't require changing tools. A verb you don't have stays honestly absent. Provide the `check` aggregate and reconcile it with CI: everything CI runs is either inside `check` or listed as CI-only in `AGENTS.md`; if CI runs different commands than `check`, point CI at `check` (or record the gap as a `proposed` spec) — local green must mean CI green.
3. **Mine context**: draft `CONTEXT.md` and ADRs from the code structure, git history, and old docs, **then confirm with the human before writing them in**. Fold legacy conventions into the new `AGENTS.md`, keeping it self-contained — no references to skills, tools, or setup only this environment has; ask first about anything conflicting, outdated, or uncertain.
4. **Assess the verification gap and report it honestly**: estimate how much regression protection the existing tests give behavior, and state plainly "the agent can safely operate autonomously within X; widening that requires shoring up Y first." This step can't be skipped or sugarcoated — it sets how strict the gates are.
5. **Set gates by the gap**: weak coverage → stricter gates, more approval points, loosening gradually as coverage fills in; write "shore up verification" as the first batch of `proposed` specs into `docs/specs/`.
6. **Lay conditional slots**: if the project publishes anything, write `docs/releasing.md` from what the existing release automation actually does; if outside contributors are expected, lay down `CONTRIBUTING.md` and the PR template, folding in any existing ones rather than replacing them.
7. **Migrate legacy artifacts**: move a legacy `docs/implementation-specs/` into `docs/specs/` (completed ones straight into `archive/`, unfinished ones get a status). Don't delete old material outright; get confirmation before migrating, archiving, or replacing.

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

- `AGENTS.md` exists and is thin, covering task flow, verbs (real commands, including `check`), gates, approval points, and the language / style the user chose — self-contained, with no reference to anything only the maintainer has.
- `docs/specs/` and the spec template `docs/specs/TEMPLATE.md` are in place (both new and existing projects).
- Standard verbs each run via one command, or the gap and fill-in plan are noted honestly; where CI exists, it runs the same `check`, or the difference is written down.
- Conditional slots (`docs/releasing.md`, `CONTRIBUTING.md` + PR template) are laid down where they apply, or explicitly skipped with the reason.
- Existing project: the verification gap is reported honestly; legacy conventions are folded in or explicitly flagged for later.
- Closing note: which legacy content was folded in, what context was converted, what the first batch of `proposed` specs are, and what remains unhandled.
