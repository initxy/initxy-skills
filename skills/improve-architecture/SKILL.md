---
name: improve-architecture
description: 发现代码库 deepening 机会并提出架构改进方案。用于架构改进、重构方向、模块/interface/seam 设计、降低耦合、提升测试性或 AI 可导航性。
---

# Improve Architecture

从代码和长期文档里找真实架构摩擦，提出 deepening 机会：把 shallow modules 变成 deep modules。这个 skill 做发现、判断和方案设计；不直接改代码，除非用户明确要求进入实现。

## 架构语言

统一使用这些词，不要漂移成 component、service、API、boundary。

- **Module**：任何有 interface 和 implementation 的东西，函数、类、包、跨层流程都算。
- **Interface**：调用方正确使用 module 必须知道的一切，包括类型、调用顺序、不变量、错误模式、配置和性能特征。
- **Implementation**：module 内部代码。讨论 seam 时，满足 interface 的具体实现叫 adapter。
- **Depth**：interface 上的杠杆率。小 interface 后隐藏大量行为是 deep；interface 几乎和 implementation 一样复杂是 shallow。
- **Seam**：可以不改调用方就替换行为的位置，也就是 module interface 所在处。
- **Adapter**：在 seam 处满足 interface 的具体实现。
- **Leverage**：调用方学习少量 interface 后获得更多能力。
- **Locality**：变化、bug、知识和验证集中在一处。

## 判断原则

- **Deep module**：小 interface + 大量 implementation。
- **Shallow module**：大 interface + 少量 implementation，通常只是转发复杂度。
- **删除测试**：删掉一个 module，如果复杂度消失，它只是转发；如果复杂度散回多个调用方，它有价值。
- **Interface 是测试表面**：测试应通过 interface 断言可观察行为；经常绕过 interface 测内部，说明 module 形状可能不对。
- **一个 adapter 是假想 seam，两个 adapter 才是真 seam**：不要为了测试或抽象癖引入只有一个实现的间接层。

设计 interface 时优先问：

- 能不能减少入口数量？
- 能不能简化参数？
- 能不能把更多规则、顺序、错误处理和依赖细节藏进 implementation？

## Deepening 依赖分类

评估候选项时，先判断依赖类型；依赖类型决定 seam 和测试策略。

- **In-process**：纯计算、内存状态、无 I/O。可以直接合并 shallow modules，通过新 interface 测试；通常不需要 adapter。
- **Local-substitutable**：有本地替身的依赖，例如内存文件系统、本地数据库替身。可以用替身测试 deep module，seam 留在内部，不暴露到外部 interface。
- **Remote but owned**：自有远程服务。用 ports and adapters：deep module 拥有逻辑，transport 是 adapter；测试用 in-memory adapter，生产用 HTTP / RPC / queue adapter。
- **True external**：第三方服务。把外部依赖作为注入 port，测试用 mock adapter。

测试策略：替换，不叠加。deep module interface 测试建立后，旧 shallow modules 的重复单测通常应该删除或降级，避免同时维护两套测试表面。

## 流程

1. **读上下文**：读取 `CONTEXT.md`、`docs/adr/`、相关任务说明、目录结构和关键代码。
2. **找摩擦**：记录理解成本高、逻辑散落、调用方重复、测试困难、interface 泄漏、跨层耦合的位置。
3. **做删除测试**：对疑似 shallow module 判断它是在集中复杂度，还是只在转发复杂度。
4. **分类依赖**：判断候选 deep module 涉及的依赖属于哪类，并据此决定 seam、adapter 和测试方式。
5. **形成候选项**：每个候选项描述当前问题、deepening 方向、涉及文件、预期收益、风险和验证方式。
6. **排序推荐**：按 locality、leverage、测试收益、改动面、ADR 冲突排序，给出最值得先做的一项。
7. **探索 interface**：当用户选中候选项且 interface 影响较大时，提出至少 2-3 个不同 interface 方案，比较 depth、locality、seam placement；复杂任务可让 subagent 并行设计不同方案，主 agent 汇总判断。
8. **沉淀长期信息**：发现新的稳定领域术语写入或建议写入 `CONTEXT.md`；需要长期解释的架构取舍写入或建议写入 ADR。

## 候选项格式

```md
## Candidate: <名称>

Files:
Problem:
Deepening proposal:
Dependency category:
Interface / seam direction:
Benefits:
Risks:
Validation:
Strength: Strong / Worth exploring / Speculative
```

## Interface 方案格式

```md
## Interface option: <名称>

Interface:
Usage example:
Hidden implementation:
Dependency strategy:
Trade-offs:
Recommendation:
```

## 完成标准

- 候选项来自已读代码和文档中的真实摩擦，不是泛泛建议。
- 每个候选项都能说明为什么能提升 locality、leverage 或测试性。
- 每个候选项都判断了依赖类型，并给出 seam / adapter / 测试策略。
- 推荐顺序明确，且说明为什么先做它。
- 与现有 ADR 冲突的建议已标注，不把旧决策当成普通偏好推翻。
- 如果进入 interface 设计，至少比较多个方案，而不是只给第一个想法。
- 不直接进入实现，除非用户明确要求并且需求已经足够清楚。
