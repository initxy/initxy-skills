---
name: write-a-skill
description: 创建结构正确、支持渐进披露并可带资源文件的新 agent skill。当用户想创建、编写或构建新 skill 时使用。
---

# Writing Skills

## 流程

1. 收集需求：
   - skill 覆盖什么任务 / 领域？
   - 需要处理哪些具体用例？
   - 需要脚本，还是只要说明？
   - 是否有参考材料？
2. 起草：
   - `SKILL.md`：简洁说明。
   - 内容超过 500 行时拆参考文件。
   - 需要确定性操作时加脚本。
3. 与用户 review：
   - 是否覆盖用例？
   - 是否遗漏或含糊？
   - 哪些部分需要增减细节？

## 结构

```text
skill-name/
├── SKILL.md
├── REFERENCE.md
├── EXAMPLES.md
└── scripts/
    └── helper.js
```

## SKILL.md 模板

```md
---
name: skill-name
description: Brief description of capability. Use when [specific triggers].
---

# Skill Name

## Quick start

[Minimal working example]

## Workflows

[Step-by-step processes]

## Advanced features

See [REFERENCE.md](REFERENCE.md).
```

## Description 要求

description 是 agent 决定是否加载 skill 时唯一可见内容。

目标：让 agent 知道：

1. skill 提供什么能力。
2. 何时触发：关键词、上下文、文件类型。

格式：

- 最多 1024 字符。
- 第三人称。
- 第一句：它做什么。
- 第二句：`Use when ...`

好例子：

```text
Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when user mentions PDFs, forms, or document extraction.
```
