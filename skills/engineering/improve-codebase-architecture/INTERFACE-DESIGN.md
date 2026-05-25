# Interface Design

当用户想为某个 deepening candidate 探索替代 interface 时，使用并行子 agent 模式。基于 Ousterhout 的 “Design It Twice”：第一想法通常不是最好。

使用 [LANGUAGE.md](LANGUAGE.md) 的词：module、interface、seam、adapter、leverage。

## 流程

### 1. 框定问题空间

启动子 agent 前，先向用户解释该候选项的问题空间：

- 新 interface 必须满足哪些约束。
- 依赖有哪些，分别属于 [DEEPENING.md](DEEPENING.md) 的哪类。
- 粗略代码草图，只用于让约束具体，不是方案。

展示后立即进入第 2 步，让用户边读边等子 agent 并行工作。

### 2. 启动子 agent

并行启动 3 个以上子 agent。每个都必须给出明显不同的 deep module interface。

每个 brief 包含：文件路径、耦合细节、依赖分类、seam 后面是什么。给每个 agent 不同设计约束：

- Agent 1：最小化 interface，目标 1-3 个入口，最大化每入口 leverage。
- Agent 2：最大化灵活性，支持更多扩展。
- Agent 3：优化最常见调用方，让默认 case 最简单。
- Agent 4：适用时围绕 ports & adapters 设计。

brief 中同时加入 [LANGUAGE.md](LANGUAGE.md) 词汇和 `CONTEXT.md` 领域词汇。

每个输出：

1. Interface：类型、方法、参数、invariant、调用顺序、错误模式。
2. 调用方使用示例。
3. Implementation 在 seam 后隐藏什么。
4. 依赖策略和 adapters。
5. 取舍：哪里 leverage 高，哪里薄。

### 3. 展示与比较

逐个展示设计，再用 prose 比较。按 depth、locality、seam placement 对比。

最后给明确推荐；如果适合混合方案，提出 hybrid。用户要的是判断，不是菜单。
