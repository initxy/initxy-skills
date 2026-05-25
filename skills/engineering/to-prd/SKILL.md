---
name: to-prd
description: 把当前对话上下文整理成 PRD，并发布到项目 issue tracker。当用户想从当前上下文创建 PRD 时使用。
---

本 skill 根据当前对话和代码库理解生成 PRD。不要采访用户，只综合已有信息。

issue tracker 和 triage 标签应已配置；没有就运行 `/setup-matt-pocock-skills`。

## 流程

1. 如还没探索仓库，先了解当前代码状态。PRD 全文使用项目领域词汇，并尊重相关 ADR。
2. 草拟需要构建或修改的主要 module。主动寻找可提取为 deep module、可独立测试的机会。
3. 与用户确认 module 是否符合预期，并确认哪些 module 需要测试。
4. 按模板写 PRD，发布到 issue tracker，并加 `ready-for-agent` 标签，无需额外 triage。

deep module：用简单、稳定、可测试的 interface 封装大量功能。相对的是 shallow module。

## PRD 模板

```markdown
## Problem Statement

从用户角度描述问题。

## Solution

从用户角度描述方案。

## User Stories

长编号列表，格式：

1. As an <actor>, I want a <feature>, so that <benefit>

覆盖功能各方面。

## Implementation Decisions

记录已做实现决策：

- 要构建 / 修改的 module。
- interface 变化。
- 技术澄清。
- 架构决策。
- schema 变化。
- API contract。
- 具体交互。

不要写具体文件路径或代码片段，容易过期。例外：prototype 产生了能精确表达决策的状态机、reducer、schema、type shape，可剪裁后内联，并说明来自 prototype。

## Testing Decisions

- 好测试的定义：只测外部行为，不测实现细节。
- 哪些 module 要测试。
- 代码库里类似测试的先例。

## Out of Scope

明确不在本 PRD 范围内的内容。

## Further Notes

其他补充。
```
