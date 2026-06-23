# initxy-skills

initxy 的 agent skills 集合。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![skills.sh](https://skills.sh/b/initxy/initxy-skills)](https://skills.sh/initxy/initxy-skills)

## 为什么是这个集合

随着模型能力变强，不少知名 skill 集合在编排上越来越重：[superpowers](https://github.com/obra/superpowers)、[Matt Pocock skills](https://github.com/mattpocock/skills) 等会拆出大量阶段化流程、子文件和细粒度触发条件。这类显式编排在能力较弱的模型上有用，但对现在的模型，过多的流程约束反而挤占注意力、增加漂移和上下文负担。

这套 skills 反过来做：只保留少量、边界清楚的 skill，把工作压成一条主线 `shape → implement → review`，再加 `setup`、`improve-architecture`、`handoff` 三个旁支。每个 skill 单文件，把目标、流程、产物和完成标准说清，不再多层拆分，让模型自己判断怎么用。

## 安装

需要 Node.js。直接用 npx，无需全局安装：

```bash
npx skills add initxy/initxy-skills
```

## Skills

- `setup`：初始化仓库的 agent 工作约定（`AGENTS.md`、CONTEXT / ADR 规范）。
- `shape`：把模糊想法收束成完整实现说明。
- `implement`：按明确需求或 `shape` 实现说明完成实现。
- `review`：审查实现是否符合需求和代码库标准。
- `improve-architecture`：发现 deepening 机会并提出架构改进方案。
- `handoff`：把当前对话和工作进度压缩成交接说明。

## 工作流

```
setup（一次性初始化）

shape ──► implement ──► review ──►（不达标则回到 shape）

improve-architecture（架构改进方向，按需）
handoff（跨 session 交接，任意阶段）
```

`setup` 生成的 `AGENTS.md` 里已写明这条路径，跑完 `setup` 即知道怎么串。

## 结构

每个 skill 位于 `skills/<name>/SKILL.md`，符合 skills.sh / Agent Skills 格式。

## License

[MIT](LICENSE)
