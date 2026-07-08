---
name: translate-zh
description: Translates English documents into natural Simplified Chinese while preserving meaning, document structure, terminology consistency, and author intent. Use when the user asks to translate English text, Markdown, documents, articles, specs, manuals, emails, reports, or files into Chinese, especially when they want idiomatic Chinese instead of literal translation.
---

# English to Natural Chinese Translation

## First Principle

Translation is not replacing English words with Chinese words.

Translation is rebuilding, in Chinese, what the source text wants readers to understand, feel, believe, or do.

## Default Output

- Translate into **Simplified Chinese**.
- Preserve the source document structure unless the user asks otherwise.
- Keep file formats, Markdown structure, headings, lists, tables, links, images, code blocks, placeholders, variables, and frontmatter intact.
- For files, write the result next to the source file using `_zh` before the extension, unless the user specifies another path.

## Translation Standard

Good translation must be faithful at three levels:

1. **Meaning**
   - Do not distort, omit, or invent information.
   - Preserve numbers, names, dates, constraints, negation, comparisons, causality, and scope.

2. **Function**
   - Preserve what the text is doing: explaining, persuading, warning, instructing, selling, documenting, comforting, or joking.
   - Match the source tone: formal, plain, technical, conversational, urgent, restrained, or emotional.

3. **Chinese Reader Experience**
   - The Chinese should read like writing originally composed for Chinese readers.
   - Do not preserve English sentence structure unless the structure itself matters.
   - Prefer clear, idiomatic Chinese over word-for-word correspondence.

## Workflow

1. **Read for Context**
   - Read the whole text or enough surrounding context before translating.
   - Identify topic, audience, purpose, tone, domain, and document type.

2. **Build a Terminology Map**
   - Identify repeated domain terms, product names, feature names, proper nouns, acronyms, and UI labels.
   - Choose consistent Chinese translations.
   - Keep brand names, code identifiers, API names, file paths, commands, and exact UI strings unchanged when translation would break usage.

3. **Translate by Meaning**
   - Translate paragraphs or logical blocks, not isolated sentences.
   - Reorder clauses when Chinese needs a different flow.
   - Split long English sentences when Chinese readability improves.
   - Merge artificially broken lines when they are only line wrapping.
   - Convert nominalized English into active Chinese when clearer.

4. **Polish as Chinese**
   - Remove translationese.
   - Prefer verbs over abstract noun chains.
   - Prefer concise Chinese where English is wordy.
   - Use natural connectors, but do not over-explain.
   - Keep technical precision when the text is technical.

5. **Check Against Source**
   - Compare with the original for missing details, added claims, wrong logic, broken references, inconsistent terms, and formatting damage.
   - If a phrase is genuinely ambiguous, choose the most likely meaning from context and note the uncertainty briefly.

## English-to-Chinese Rewrite Rules

Use these rules when they improve Chinese readability:

- English passive voice can become active Chinese.
  - `This feature is designed to reduce latency.`
  - `这个功能旨在降低延迟。`

- English noun chains should often become verb phrases.
  - `the implementation of improvements`
  - `落实改进`

- English long sentences may be split.
  - Keep the logical relationship, not the punctuation.

- English pronouns may need explicit nouns in Chinese.
  - Replace unclear `it`, `they`, `this`, `that` with the actual subject when needed.

- English hedging should be preserved, not flattened.
  - `may`, `might`, `can`, `typically`, `roughly`, `in some cases` all affect meaning.

- Technical terms should be consistent.
  - Do not alternate between multiple Chinese translations unless the source distinguishes them.

## What Not To Do

- Do not translate word by word.
- Do not keep awkward English word order.
- Do not make the translation more ornate than the source.
- Do not simplify away technical distinctions.
- Do not add explanations inside the translation unless the user asks or comprehension requires it.
- Do not translate code, commands, paths, identifiers, config keys, URLs, package names, or placeholders.
- Do not change Markdown, tables, frontmatter, or code fences while translating prose around them.

## Document Handling

### Markdown

- Translate headings, paragraphs, list text, table prose, captions, and alt text.
- Preserve heading levels, list nesting, table shape, links, anchors, code fences, inline code, HTML tags, and frontmatter keys.
- Translate frontmatter values only when they are human-facing prose.

### Technical Docs

- Keep API names, function names, classes, parameters, enum values, error codes, CLI flags, and environment variables unchanged.
- Translate explanations, warnings, examples' surrounding prose, and conceptual descriptions.
- Preserve RFC-style words carefully: MUST, SHOULD, MAY can be translated as 必须、应该、可以/可能 depending on normative force.

### Product and UI Copy

- Prefer clear, direct Chinese.
- Keep button labels short.
- Preserve the user's likely task and mental model.
- Avoid stiff literal renderings of marketing phrases.

### Articles and Essays

- Preserve argument structure, rhythm, and stance.
- Make the Chinese readable as an article, not a line-by-line gloss.
- Keep metaphors only when they work in Chinese; otherwise translate the effect.

## Quality Checklist

Before finalizing:

- [ ] The Chinese can be understood without seeing the English.
- [ ] Meaning, logic, tone, and intent match the source.
- [ ] No important condition, limitation, negation, or comparison is missing.
- [ ] Terminology is consistent.
- [ ] Names, numbers, links, code, commands, and file paths are intact.
- [ ] Formatting and document structure are preserved.
- [ ] The translation does not sound like English in Chinese words.

## When to Ask

Ask the user only when a choice materially affects the output and cannot be inferred:

- Target region: Mainland China, Taiwan, Hong Kong, or global Chinese.
- Required style: formal, conversational, publication-ready, technical, legal, marketing, or academic.
- Whether to localize examples, cultural references, units, or product terminology.

If not specified, use Mainland Simplified Chinese, natural professional tone, and preserve examples rather than localizing them.
