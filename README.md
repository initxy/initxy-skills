# initxy-skills

**一套中文原生、少而精的 agent skills。** 把「先想清楚 → 再动手 → 做完检查」这条工程主线，加上几个高频的中文写作、翻译工具，装进你的 AI 编程助手。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![skills.sh](https://skills.sh/b/initxy/initxy-skills)](https://skills.sh/initxy/initxy-skills)

- **是什么** — 8 个可组合的 agent skill，覆盖需求收敛、实现、审查、架构改进、交接，外加英译中和引导式中文写作。
- **适合谁** — 用中文和 AI 协作写代码、又想自己掌控节奏的人；不想背上多角色重型框架，只要几件趁手的工具。
- **解决什么** — 让 AI 不要「一句需求直接开写」，而是走一条边界清晰的工程流程；同时避免流程写太细，反而抢占模型注意力、拖累上下文。

```bash
npx skills add initxy/initxy-skills
```

## 亮点

- **中文原生，不只是翻译。** 每个 skill 的指令正文（而非只有描述）都用中文写成，措辞贴近中文表达。中文对话里调用衔接自然，不会因为指令是英文而把模型悄悄带向英文输出；指令本身也好读好改。
- **一条主线，少而清晰。** 需求到交付收敛成 `shape → implement → review` 三步，把同类工程动作合并（对照 mattpocock 的 ~20 个 skill，这里只有 6 个工程 skill）。每个 skill 只做一件事、可组合、不绑定特定工具。
- **上下文干净。** 以单文件为主，主文件加载即用、无需跳读；细节才拆进同目录 `references/`，只在用到那一步才读，主文件始终精简。
- **只给目标，把「怎么干」交给模型。** 模型已经足够强，skill 只讲清目标和完成标准，剩下的判断留给它。流程不堆细节，注意力放在任务本身。
- **能力可验证，不是空话。** `shape` 是访谈式逐题追问，设计没收敛不落一字实现说明；`review` 用 P0–P3 分级输出可行动 findings；`setup` 沉淀 `AGENTS.md` / `CONTEXT.md` / ADR；`write-zh` 自带去 AI 味清单和五种可切换风格。

## Skills

**工程主线**（一条路走完，不达标回到上一步）：

```
setup（一次性初始化）

shape ──► implement ──► review ──►（不达标则回到 shape）

improve-architecture（架构改进，按需）
handoff（跨 session 交接，任意阶段）
```

| Skill | 做什么 | 什么时候用 |
|---|---|---|
| `setup` | 初始化仓库的 agent 工作约定（`AGENTS.md`、`CONTEXT.md` / ADR 规范） | 新仓库起手，一次性 |
| `shape` | 访谈式追问，把模糊想法收束成完整实现说明 | 需求/边界/验收标准不清时 |
| `implement` | 按实现说明或明确任务落地，不重新发散需求 | 目标已清楚，动手写代码 |
| `review` | 对照需求和代码库标准审查，P0–P3 分级给 findings | 检查 diff / PR，判断能否合入 |
| `improve-architecture` | 找架构摩擦，提出把 shallow module 变 deep 的方案 | 想重构、降耦合、提升可测性时 |
| `handoff` | 把对话和进度压缩成交接说明，让下一段 session 续接 | 换 session、跨天续接、总结进度 |

跑完 `setup`，`AGENTS.md` 里会写明这条路径，照着串即可。

**通用工具**：

| Skill | 做什么 | 什么时候用 |
|---|---|---|
| `translate-zh` | 英译中，输出地道简体中文而非逐词直译，保留结构与术语一致 | 翻译英文文档 / Markdown / 邮件 |
| `write-zh` | 引导式中文写作，逐节带你把文档写出来，去 AI 味、多配图 | 想被引导着写而非一键生成一整篇 |

`write-zh` 的细节拆成三份按需读取的 references：`techniques`（人味从哪来）、`de-ai`（去 AI 味清单和正反例）、`styles`（五种可切换的语言风格画像）。

## 快速上手

安装后，在你的 AI 编程助手里：

1. 进入一个项目，先跑 `setup` 建立 agent 工作约定（一次性）。
2. 有新需求时用 `shape` 把它聊清楚，产出实现说明。
3. 用 `implement` 按说明落地，再用 `review` 审查能否合入；不达标就回到 `shape`。

需求已经很清楚时可以跳过 `shape`，直接 `implement`。翻译、写作两个工具独立使用，随时调用。

## 安装

需要 Node.js。直接用 npx，无需全局安装：

```bash
npx skills add initxy/initxy-skills
```

每个 skill 位于 `skills/<name>/SKILL.md`，符合 skills.sh / Agent Skills 格式。

## 设计取舍与对比

这套的取舍是「轻和少」：模型已经够强，把流程拆得太细反而抢占它的注意力、拖累上下文，所以只保留少量、边界清晰的 skill，把目标和完成标准讲明白，剩下交给模型判断。

主要借鉴 [Matt Pocock 的 skills](https://github.com/mattpocock/skills)，也参考了 [superpowers](https://github.com/obra/superpowers)、[gstack](https://github.com/garrytan/gstack)、[Everything Claude Code](https://github.com/WorldFlowAI/everything-claude-code)（ecc）——思路可取，但落地偏重，因此只取思路、不取体量。

和 mattpocock 的粒度差异：

| | initxy-skills | [mattpocock/skills](https://github.com/mattpocock/skills) |
|---|---|---|
| 工程类数量 | 6 个 | 20 个左右 |
| 需求阶段 | 一个 `shape` 完成追问、PRD、拆 issue | 分 `grill-me`、`to-prd`、`to-issues` 三步 |
| 实现阶段 | `implement` 不绑定具体方法 | 专门的 `tdd`，强制红绿重构 |
| 架构改进 | `improve-architecture` 一个 skill 覆盖 | 拆成发现、报告、追问多步 |

底层方法一致，区别在粒度：mattpocock 把工程动作拆得细，每步一个 skill，适合希望每一步都有明确指引的人；这套把同类动作合并，skill 更少，适合希望自己掌控节奏的人。

和其他集合的定位差异：

| | initxy-skills | [gstack](https://github.com/garrytan/gstack) | [ecc](https://github.com/WorldFlowAI/everything-claude-code) | [superpowers](https://github.com/obra/superpowers) |
|---|---|---|---|---|
| 定位 | 个人日常用的轻量 skill | 虚拟工程团队 | 开箱全家桶 | 通用流程 skill |
| 规模 | 6 工程 + 通用工具 | 23 角色 + 8 工具 | agents / commands / skills / rules / hooks / MCP 全包 | 数十个，覆盖多领域 |
| 适合谁 | 想自己掌控流程的人 | 想要完整团队流程的人 | 想要开箱全家桶的人 | 需要流程约束的场景 |

并无优劣，只是取舍不同：那几个追求覆盖全、流程完整，适合「都替我安排好」；这套追求轻和少，适合想自己拿主意的人。

## 结构

每个 skill 位于 `skills/<name>/SKILL.md`。多数 skill 单文件即可；个别（如 `write-zh`）把不常用的细节拆进同目录的 `references/`，由主文件按需引用，主文件本身保持精简。

## License

[MIT](LICENSE)
