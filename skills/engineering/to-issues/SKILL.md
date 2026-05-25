---
name: to-issues
description: 把计划、spec 或 PRD 拆成 issue tracker 上可独立领取的 issue，使用 tracer-bullet 垂直切片。当用户想把计划转成 issue、创建实现 ticket、拆解工作时使用。
---

# To Issues

用垂直切片（tracer bullets）把计划拆成可独立领取的 issue。

issue tracker 和 triage 标签应已配置；没有就运行 `/setup-matt-pocock-skills`。

## 流程

### 1. 收集上下文

优先使用当前对话上下文。若用户传入 issue 编号、URL 或路径，去 issue tracker 拉取完整正文和评论。

如果存在 SDD / 设计文档，必须读取并作为拆分依据：

- 用户给了 SDD 或设计文档路径：读取该文件。
- 当前对话刚生成了 SDD：使用当前对话中的 SDD 内容。
- 仓库有 `docs/design/`：读取与当前计划、PRD 或 issue 最相关的 SDD；无法判断时先列候选并问用户。

issue 拆分必须尊重 SDD 中的「需求映射」「模块设计」「详细设计」「数据设计」「API / 事件契约」「发布与迁移」「测试策略」。

### 2. 探索代码库（可选）

如果尚未探索，先了解当前代码状态。issue 标题和描述使用项目领域词汇，并尊重相关 ADR。

### 3. 起草垂直切片

每个 issue 是一条薄的端到端垂直切片，穿过所有集成层；不是某一层的水平切片。

切片可为：

- HITL：需要人类交互，例如架构决策或设计 review。
- AFK：可无人工上下文实现并合并。

尽量偏向 AFK。

规则：

- 每个切片交付窄但完整的路径：schema、API、UI、测试等。
- 完成后可独立 demo 或验证。
- 多个薄切片优于少数厚切片。

### 4. 追问用户

以编号列表展示拆分：

- Title：短描述。
- Type：HITL / AFK。
- Blocked by：依赖哪些切片。
- User stories covered：覆盖哪些用户故事。

询问：

- 粒度是否合适。
- 依赖关系是否正确。
- 是否需要合并或拆分。
- HITL / AFK 标注是否正确。

迭代到用户批准。

### 5. 发布 issue

按依赖顺序发布，先 blocker，方便引用真实 issue id。默认为 AFK-ready issue 加正确 triage 标签，除非用户另说。

模板：

```markdown
## Parent

父 issue 引用；若没有则省略。

## What to build

简述该垂直切片的端到端行为，不按层描述实现。

避免具体文件路径和代码片段，它们会过期。例外：prototype 产生了能精确表达决策的状态机、reducer、schema、type shape，可剪裁后内联，并说明来自 prototype。

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Blocked by

- blocking ticket 引用

或：None - can start immediately
```

不要关闭或修改 parent issue。
