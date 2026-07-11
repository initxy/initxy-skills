# initxy-skills

[English](README.md) · **简体中文**

把仓库变成这样一个地方：任何 agent 冷启动进来，不问人就能理解任务、写完、自己验证、把决策写回去。人只出现在两个地方——**定意图**和**收结果**。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![skills.sh](https://skills.sh/b/initxy/initxy-skills)](https://skills.sh/initxy/initxy-skills)

克隆下来，把 skill 文件夹拷进你的 agent 的 skills 目录（以 Claude Code 为例）：

```bash
git clone https://github.com/initxy/initxy-skills
mkdir -p ~/.claude/skills
cp -r initxy-skills/skills/*/*/ ~/.claude/skills/
```

只装进某个项目就用 `.claude/skills/`；只装部分就单独拷对应文件夹（如 `initxy-skills/skills/ai-native-engineering/shape`）。以后 `git pull` 后重拷即可更新。

## 和别的 skill 有什么不一样

大多数 skill 集靠「加 skill」变大——一个步骤一个 skill，教模型「这一步怎么做」。这个赌注正在快速贬值：今天写死的最佳实践，下一代模型自己就会，还白占上下文。

这套反着赌。它**减流程**，把力气投在唯一不随模型进化的东西上——仓库这一侧的约定：上下文放哪、怎么验证、什么算完成、怎么拦住漂移。中间的步骤，交给模型。

| | 常见 skill 集 | initxy-skills |
|---|---|---|
| 赌注 | 更多 skill 覆盖更多步骤 | 更少 skill，约定归仓库 |
| 教模型什么 | 「怎么一步步干活」 | 什么都不教——步骤是模型的事 |
| 投在哪 | 工作流程 | 槽位和动词，跨模型代际稳定 |
| 随时间 | 随模型变强而贬值 | 稳住——仓库约定不动 |

同类的 [mattpocock/skills](https://github.com/mattpocock/skills)、[superpowers](https://github.com/obra/superpowers)、[gstack](https://github.com/garrytan/gstack)、[ecc](https://github.com/WorldFlowAI/everything-claude-code) 大多用更多 skill 覆盖更多步骤；这里反方向收：步骤归模型，约定归仓库。

## 这套赌的是什么

一个仓库达到 AI native，指的是任何 agent 冷启动进来，不问人就能理解任务、写完、自己验证、把决策写回去。人只出现两次：**定意图**和**收结果**。

四条判断撑着这个取舍：

- **约定槽位和动词，不约定步骤。** 步骤归模型，随模型进化；槽位（`AGENTS.md` / `CONTEXT.md` / ADR / spec）和动词（`test` / `build` / `release`）归仓库，长期不变。
- **反馈回路是上限。** 一个项目能放心交给 agent 的范围，约等于它反馈回路的质量。agent 验证不了的事就别交给它，验证弱的仓库先补验证再谈自主。
- **仓库即记忆。** spec 带着状态和进度，边做边写。换个 session 随时接上，不需要交接仪式。
- **熵控制单列一档。** 功能任务保持聚焦，代价是结构必然漂移，靠 `gc` 定期收回来，不指望模型顺手维护。

还有一个容易被忽略的第三触点：agent 反复失败时，该改的是 **harness**，不是那一次的产出。反复失败几乎总意味着 context 或验证有缺口，补上，让下次不再发生。

## Skills

```
init-harness  ·  一次性铺底（新仓库、存量仓库走同一入口）

  shape ──▶ 实现（无专门 skill：照 spec 干、跑门禁）──▶ review
    ▲                                                  │
    └───────── gc（大功能后 scoped · 定期 global）◀───────┘
```

### AI Native 工程

| Skill | 做什么 | 什么时候用 |
|---|---|---|
| `init-harness` | 把仓库铺成 AI native 项目：建 `AGENTS.md`、标准动词、门禁、`docs/specs/`；存量项目先探测已有命令、包成统一入口，再如实报告验证缺口 | 接入一个项目，一次性 |
| `shape` | 访谈式追问，把模糊想法收束成带验收标准的 spec；只定意图，不写一行实现 | 需求 / 边界 / 验收标准不清，实现前要先定方案 |
| `review` | 先跑门禁（不绿直接打回），再对照 spec 验收标准逐条核对，给出「可合入 / 修改后再看 / 重新 shape」的结论；可合入时才归档 | 判断一个改动能不能合入 |
| `gc` | 熵控制，发现与实施分离：文档和代码对账、清死代码、归档 spec 这类安全的直接做；要动结构的只出提案，不动手 | 大功能合入后 scoped，定期 global |

没有 `implement`：「照 spec 干、跑门禁、算 done」写在 `AGENTS.md` 的任务流里，模型照着做就行。实现流程属于项目 harness，不单拎出来。

### Self

| Skill | 做什么 | 什么时候用 |
|---|---|---|
| `handoff` | 把当前对话和进度压成交接说明，让下一个 session 接着做 | 要交接、续接、总结进度时 |
| `translate-zh` | 英译中，出地道简体中文而非逐词直译，保留结构和术语一致 | 翻译英文文档 / Markdown / 邮件 |
| `write-zh` | 引导式中文写作：访谈挖出你的真素材，逐节起草、论点条条可溯源，冷读收尾，去 AI 味、多配图 | 想被带着写，而不是一键生成整篇 |

## Harness 铺了什么

`init-harness` 在目标仓库落下这些槽位（完整规范见 [harness.md](skills/ai-native-engineering/init-harness/references/harness.md)）：

```
AGENTS.md             # 唯一入口，保持薄：任务流、动词、门禁、语言
CONTEXT.md            # 领域概念、系统边界、术语表（现状以代码为准，文档只讲「为什么」）
docs/adr/             # 长期决策，带 status（accepted / superseded）
docs/specs/           # 每任务一份 spec：proposed → active → done → archive/
scripts/ 或 Makefile   # 标准动词：dev / test / lint / build / e2e / check / release
docs/releasing.md     # 发布手册——项目有发布物才铺
CONTRIBUTING.md       # 贡献者门面（含 PR 模板）——预期有外部贡献者才铺
```

完成的定义只有一条：**spec 验收标准逐条满足，且自动门禁全绿**。`check` 一条命令跑完全部自动门禁，CI 跑的也是同一条——本地绿即 CI 绿，维护者、贡献者和他们的 agent 共用一条反馈回路。release、数据迁移、删数据这类不可逆动作另设审批门禁，必须人放行；发布照手册走，手册写到 agent 能执行除签字外的每一步。

有外部贡献者的仓库，`AGENTS.md` 保持自洽（裸 agent 照着步骤就能走，不引用任何私有 skill 或环境），`CONTRIBUTING.md` 带一段「欢迎但问责」的 AI 贡献政策：agent 写的 PR 是一等公民，但每个 PR 要有一个读懂改动的人类负责人，并写明怎么验证的。

这些槽位都贴通用约定，不发明私有格式：`AGENTS.md` 是事实标准，spec 和 ADR 都是普通 Markdown。初始化出来的项目对任何 agent 工具都是 AI native 的，不锁死在这套 skill 上。

## 上手

1. 进项目跑 `init-harness`，一次性铺好槽位和动词。
2. 新需求用 `shape` 谈清，落成 spec。
3. 让 agent 照 spec 实现（任务流和完成定义已经写进 `AGENTS.md`），完事用 `review` 验收。
4. 大功能合入后跑 scoped `gc`；再挂个定时任务，定期跑 global `gc`。

需求本来就清楚，可以跳过 `shape` 直接做。`handoff`、`translate-zh`、`write-zh` 三个 Self 工具互相独立，随时单用。

## 结构

skill 按用途分两个文件夹：

- `skills/ai-native-engineering/`：工程主线，`init-harness`、`shape`、`review`、`gc`。
- `skills/self/`：日常工具，`handoff`、`translate-zh`、`write-zh`。

每个 skill 在各自分类下的 `<name>/SKILL.md`，符合 Agent Skills 格式。多数单文件；`init-harness` 和 `write-zh` 把规范、模板拆进同目录 `references/`，主文件按需引用。

## License

[MIT](LICENSE)
