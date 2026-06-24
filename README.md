# initxy-skills

initxy 个人日常使用的 agent skills 集合，以软件工程为主，外加几个通用工具。所有 skill 均以中文撰写，面向中文工作流。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![skills.sh](https://skills.sh/b/initxy/initxy-skills)](https://skills.sh/initxy/initxy-skills)

## 中文友好

集合内每个 skill 的指令正文（而不只是描述）都用中文写成，措辞贴近中文表达习惯。好处有两点：

- 在中文对话里调用时衔接自然，不会因为指令是英文而把模型悄悄带向英文输出。
- 指令本身好读好改，按自己的习惯调整也没有语言隔阂。

`translate-zh` 进一步专门处理英译中，输出地道的简体中文而非逐词直译。

## 借鉴了什么

主要借鉴 [Matt Pocock 的 skills](https://github.com/mattpocock/skills)，沿用了几点：

- **一条工程主线**：先把想法聊清楚，再动手实现，完成后对照检查。mattpocock 将其拆成追问、写 PRD、拆 issue、TDD、改架构等多个 skill，这里收敛为三个：`shape → implement → review`。
- **几个关键概念**：把复杂逻辑封装在小接口背后（deep module）、用 `CONTEXT.md` 记录项目内稳定的术语与约定、用 ADR 记录影响长远的架构决策、用 `handoff` 交接给下一段对话。
- **每个 skill 小而独立**：一个 skill 只做一件事，单文件，可组合，不绑定特定工具。

同时参考了 [superpowers](https://github.com/obra/superpowers)、[gstack](https://github.com/garrytan/gstack)、[Everything Claude Code](https://github.com/WorldFlowAI/everything-claude-code)（ecc）——思路可取，但落地偏重，因此只取思路、不取体量。

## 和 mattpocock 的对比

| | initxy-skills | [mattpocock/skills](https://github.com/mattpocock/skills) |
|---|---|---|
| 工程类数量 | 6 个 | 20 个左右 |
| 分类方式 | 不分，统一风格 | 分两类：主动调用 / 模型按需自动调用 |
| 需求阶段 | 一个 `shape` 完成追问、PRD、拆 issue | 分 `grill-me`、`to-prd`、`to-issues` 三步 |
| 实现阶段 | `implement` 不绑定具体方法 | 专门的 `tdd`，强制红绿重构 |
| 架构改进 | `improve-architecture` 一个 skill 覆盖 | 拆成发现、报告、追问多步 |
| 交接 | `handoff` | `handoff`（基本一致） |

底层方法一致，区别在粒度：mattpocock 把工程动作拆得细，每步一个 skill，适合希望每一步都有明确指引的人；这套把同类动作合并，skill 更少，适合希望自己掌控节奏的人。

## 和其他集合的对比

| | initxy-skills | [gstack](https://github.com/garrytan/gstack) | [ecc](https://github.com/WorldFlowAI/everything-claude-code) | [superpowers](https://github.com/obra/superpowers) |
|---|---|---|---|---|
| 定位 | 个人日常用的轻量 skill | 虚拟工程团队 | 开箱全家桶 | 通用流程 skill |
| 规模 | 6 工程 + 通用工具 | 23 角色 + 8 工具 | agents / commands / skills / rules / hooks / MCP 全包 | 数十个，覆盖多领域 |
| 组织方式 | 一条主线 + 数个旁支 | 多角色流水线 | 按需调用各类资源 | 阶段化，触发条件细 |
| 适合谁 | 想自己掌控流程的人 | 想要完整团队流程的人 | 想要开箱全家桶的人 | 需要流程约束的场景 |

并无优劣，只是取舍不同：那几个追求覆盖全、流程完整，适合「都替我安排好」；这套追求轻和少，适合想自己拿主意的人。

## 为什么这样设计

模型已经足够强，把流程写得太细反而会抢占它的注意力、拖累上下文。因此这里只保留少量、边界清晰的 skill，把目标和完成标准讲明白，剩下怎么干交给模型自己判断。好处是：

- **上下文干净**：一个 skill 一个文件，加载即用，无需跳读。
- **注意力集中**：只保留必要流程，模型把心思放在任务本身。
- **好读好改**：每个 skill 独立，增改一个都不牵动其他。
- **只放真在用的**：不堆数量，不为凑数加 skill。

## 安装

需要 Node.js。直接用 npx，无需全局安装：

```bash
npx skills add initxy/initxy-skills
```

## Skills

工程类，一条主线：

- `setup`：初始化仓库的 agent 工作约定（`AGENTS.md`、CONTEXT / ADR 规范）。一次性。
- `shape`：把模糊想法收束成完整实现说明。
- `implement`：按明确需求或 `shape` 说明完成实现。
- `review`：审查实现是否符合需求和代码库标准。
- `improve-architecture`：发现改进机会，提出架构调整方案。按需。
- `handoff`：把当前对话和工作进度压缩成交接说明。任意阶段。

```
setup（一次性初始化）

shape ──► implement ──► review ──►（不达标则回到 shape）

improve-architecture（架构改进，按需）
handoff（跨 session 交接，任意阶段）
```

跑完 `setup`，`AGENTS.md` 里会写明这条路径，照着串即可。

通用工具：

- `translate-zh`：把英文文档译成自然地道的简体中文，保留结构和术语一致性。

## 结构

每个 skill 位于 `skills/<name>/SKILL.md`，符合 skills.sh / Agent Skills 格式。

## License

[MIT](LICENSE)
