---
name: setup-os
description: 在新 repo 里初始化 initxy-skills 的项目约定：单文件 AGENTS.md（Karpathy 风格 onboarding 文档）。每个 repo 首次接入时手动运行一次；缺失 AGENTS.md / CLAUDE.md 时补跑。触发词：初始化项目、setup os、项目结构、添加 agent 指引、AGENTS.md。
# disable-model-invocation 是 Claude Code 专用字段：阻止模型因 description 关键词
# 命中就自动触发本 skill，必须由用户显式运行。其它平台（Codex 等）目前不识别该字段，
# 因此 description 首句已用「手动运行」给出跨平台兜底语义。
disable-model-invocation: true
---

# Setup OS

初始化一个 Karpathy 风格的 `AGENTS.md`（或既有的 `CLAUDE.md`）作为本 repo 的 agent onboarding 文档。**单文件**，不预建任何 `docs/` 子目录，不复制 skill 路由表。

## When to use

- 第一次把这个 repo 接入 initxy-skills 工作流。
- 已有 AGENTS.md / CLAUDE.md 但缺少 `## Agent skills` 段，无法让接手 agent 知道本 repo 用了 initxy-skills。

## When not to use

- 30 分钟以内的一次性脚本或临时探索——不值得建任何 agent 文档。
- 已有 AGENTS.md 且其中 `## Agent skills` 段已指向 initxy-skills——再跑一遍无效。

## Implementation

1. **选定目标文件**
   - 若 `AGENTS.md` 存在 → 用它。
   - 否则若 `CLAUDE.md` 存在 → 用它。
   - 否则 → `cp setup-os/templates/AGENTS.md ./AGENTS.md`，提示用户填写占位符。

2. **注入引用段**
   - 在目标文件中搜索 `## Agent skills` 标题。
   - 找到 → 用 `templates/skills-reference.md` 的内容替换整段。
   - 未找到 → 追加 `templates/skills-reference.md` 内容到文件末尾。

3. **打印一行处置结果**：`CREATE` / `APPEND` / `REPLACE` / `SKIP`。

## Do not

- 不预建 `docs/adr/`、`docs/sop/`、`docs/diag/` 等空目录——首次写第一份 ADR / SOP / 诊断笔记时再 `mkdir -p`。
- 不把 skill 路由表、铁律或工作流复制进 AGENTS.md。Skill 的 `description` 字段已注入 system prompt，复制就是占用每次对话的 context tokens，且会触发 superpowers 警告过的"description shortcut"陷阱。
- 不分析业务、不评估 ROI、不规划下一步——那是 `assess` / `os` 的事。本 skill 跑完即停。

## Templates

- [`templates/AGENTS.md`](templates/AGENTS.md) — Karpathy 风格 onboarding 模板（新建时用）
- [`templates/skills-reference.md`](templates/skills-reference.md) — 单段引用块（向已有文件追加/替换用）

## Background

为什么单一 AGENTS.md，而不是 CONTEXT.md + STATE.md + AGENTS.md 三件套？

- **Karpathy 范式**：AGENTS.md = README for the agent，像给新成员做 onboarding。一个文件、可读、可维护。
- **三件套问题**：边界模糊（glossary 算 state 还是 context？），agent 每次要读 3 个文件才能 onboard，更新成本翻倍。
- **进化路径**：当 AGENTS.md 因为某节变化太频繁污染 diff 时，再把那一节拆出去——演化的拆分胜过预先的拆分。
