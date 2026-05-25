---
name: grill-with-docs
description: 结合现有领域模型追问方案、收紧术语，并在决策明确时即时更新 CONTEXT.md 和 ADR。当用户想用项目语言与已有决策压力测试计划时使用。
---

<what-to-do>

围绕计划逐问追问，直到双方理解一致。沿设计树逐个解决依赖决策。每个问题都给出你的推荐答案。

一次只问一个问题，等用户回答后再继续。

能通过读代码回答的问题，就去读代码，不问用户。

</what-to-do>

<supporting-info>

## 领域感知

探索代码时同时查文档。

常见单上下文仓库：

```text
/
├── CONTEXT.md
├── docs/
│   └── adr/
└── src/
```

如果根目录有 `CONTEXT-MAP.md`，说明有多个上下文：

```text
/
├── CONTEXT-MAP.md
├── docs/adr/              # 系统级决策
└── src/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/
```

懒创建文件：只有术语或决策真的明确后才写。没有 `CONTEXT.md` 就在第一个术语确定时创建；没有 `docs/adr/` 就在第一个 ADR 需要时创建。

## 会话规则

### 对照词汇表挑战

用户用词与 `CONTEXT.md` 冲突时立即指出：例如“词汇表里 cancellation 是 X，但你现在像是在说 Y，哪个才对？”

### 收紧模糊语言

用户使用含糊或重载词时，提出标准术语：例如“你说 account，是 Customer 还是 User？这是两个概念。”

### 用具体场景压测

讨论领域关系时，构造边界案例，让用户明确概念边界。

### 与代码交叉验证

用户说某行为如何工作时，检查代码是否一致。不一致就指出：“代码取消的是整个 Order，但你刚说可以部分取消，哪个对？”

### 即时更新 CONTEXT.md

术语一旦明确，立即更新 `CONTEXT.md`，不要攒到最后。格式见 [CONTEXT-FORMAT.md](./CONTEXT-FORMAT.md)。

`CONTEXT.md` 只放领域词汇表，不放实现细节、spec、草稿或实现决策。

### 谨慎提出 ADR

只有同时满足三点才建议 ADR：

1. 难逆转：以后改主意成本明显。
2. 没上下文会意外：未来读者会问“为什么这样做？”
3. 真有取舍：存在合理替代方案，并明确选择了一个。

格式见 [ADR-FORMAT.md](./ADR-FORMAT.md)。

</supporting-info>
