# initxy-skills

initxy 个人日常使用的 agent skills 集合。以软件工程为主，加几个日常会用到的通用工具。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![skills.sh](https://skills.sh/b/initxy/initxy-skills)](https://skills.sh/initxy/initxy-skills)

## 借鉴了什么

主要借鉴 [Matt Pocock 的 skills](https://github.com/mattpocock/skills)，借得最多。从它那儿拿来的有几样：

- **一条工程主线**：先把想法聊清楚，再动手写，写完对照检查。mattpocock 把这拆成追问、写 PRD、拆 issue、TDD、改架构好几个 skill，这里压回三个：`shape → implement → review`。
- **几个关键概念**：把复杂逻辑藏在小接口后面（它叫 deep module）、用 `CONTEXT.md` 记项目里稳定的术语和约定、用 ADR 记影响长远的架构决策、交接给下一段对话的 `handoff`。这些直接沿用。
- **每个 skill 小而独立**：一个 skill 只管一件事，单文件，能拼着用，不绑死某个工具。

也参考了 [superpowers](https://github.com/obra/superpowers)、[gstack](https://github.com/garrytan/gstack)、[Everything Claude Code](https://github.com/WorldFlowAI/everything-claude-code)（ecc）——它们思路对，但落地偏重，所以只取思路、不取体量。

## 和 mattpocock 的对比

| | initxy-skills | [mattpocock/skills](https://github.com/mattpocock/skills) |
|---|---|---|
| 工程类数量 | 6 个 | 20 个左右 |
| 怎么分类 | 不分，都一个风格 | 分两类：你主动喊的 / 模型自己该用时自动用的 |
| 做需求 | 一个 `shape` 把追问、写 PRD、拆 issue 一口气做完 | 分 `grill-me`、`to-prd`、`to-issues` 三步走 |
| 写代码 | `implement` 不绑死方法，能用就用 | 有专门的 `tdd`，强制红绿重构 |
| 改架构 | `improve-architecture` 一个 skill 管到底 | 拆成发现、出报告、追问好几步 |
| 交接 | `handoff` | `handoff`（基本一致） |
| 文件 | 单文件 | 单文件 |
| 底子 | 瘦身版，把流程合并、判断交还给你 | 流程细、分得开，每步都有专门 skill |

一句话：mattpocock 把工程动作拆得细，每步一个 skill，适合想要每步都被管着走的人；这套把同类动作合并，skill 更少，适合想自己掌控节奏、不被一堆 skill 带着跑的人。底子是同一套，区别在粒度。

## 和其他几个集合的对比

| | initxy-skills | [gstack](https://github.com/garrytan/gstack) | [ecc](https://github.com/WorldFlowAI/everything-claude-code) | [superpowers](https://github.com/obra/superpowers) |
|---|---|---|---|---|
| 是什么 | 个人日常用的轻量 skill | 一个虚拟工程团队 | 开箱全家桶 | 通用流程 skill |
| 多大 | 6 工程 + 通用工具 | 23 角色 + 8 工具 | agents / commands / skills / rules / hooks / MCP 全包 | 几十个，多领域 |
| 怎么组织 | 一条主线 + 三个旁支 | 多角色流水线 | 按需调用各类资源 | 阶段化，触发条件细 |
| 适合谁 | 想自己掌控流程的人 | 想要完整团队流程的人 | 想要开箱全家桶的人 | 需要流程约束的场景 |

不是谁好谁坏，是取舍不同：那几个追求覆盖全、流程完整，适合「都替我安排好」；这套追求轻和少，适合想自己拿主意的人。

## 为什么这样设计

模型现在够强，把流程写太细反而抢它的注意力、拖慢上下文。所以这里只留下少量、边界清楚的 skill，把目标和完成标准说清，剩下怎么干交给模型自己判断。

好处是：

- **上下文干净**：一个 skill 一个文件，加载就够，不用跳着读。
- **注意力集中**：只留必要的流程，模型把心思放在任务本身。
- **好读好改**：每个 skill 独立，加一个改一个都不碰别的。
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

跑完 `setup`，`AGENTS.md` 里会写明这条路径，照着串就行。

通用工具：

- `translate`：把英文文档译成自然地道的简体中文，保留结构和术语一致性。

## 结构

每个 skill 位于 `skills/<name>/SKILL.md`，符合 skills.sh / Agent Skills 格式。

## License

[MIT](LICENSE)
