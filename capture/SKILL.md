---
name: capture
description: 把项目层面可复用的上下文、ADR、SOP、诊断经验或学习产物沉淀进 repo 内 docs/。触发词：记住这个、更新 context、写个 ADR、写 SOP、以后默认这样、项目踩坑、架构决策、规范文档。个人视角/跨项目原则请转 `sediment`。
---

# Capture

## 铁律

1. 只沉淀未来在**本项目**会被复用的东西——新人或新 agent 接手时需要读到它。
2. 已有同主题文件 — 更新，不重复创建。
3. 没有未来复用场景 — 不写，任何形式都不写。

## 何时不用我

- 是个人独特视角或跨项目原则 → 转 `sediment`（~/notes/）。
- LLM 能直接答的通用知识（框架文档、语言特性）→ 不写，docs/ 不是教程库。
- 一次性临时笔记、会议记录、实验草稿 → 不写。

## 何时使用

- "记住这个"、"以后默认这样"
- "更新 context"、"写进 CLAUDE.md"
- "写个 ADR"、"写 SOP"
- 重要项目踩坑或架构规则需要固化
- 诊断结论值得下次复用（错误根因 + 修复路径）
- `learn` 产物中有项目特有部分需沉淀

## 目标位置

| 内容类型 | 目标路径 |
|---|---|
| 项目词汇 / glossary | `CONTEXT.md` |
| 当前进度 / 任务状态 | `STATE.md` |
| 架构决策 | `docs/adr/YYYY-MM-DD-<slug>.md` |
| 流程 SOP | `docs/sop/<slug>.md` |
| 诊断经验 | `docs/diag/<slug>.md` |
| 学习产物（项目相关） | `docs/learn/<slug>.md` |
| clarify 产物 | `docs/clarify/<slug>.md` |
| 项目约定 / 规范 | `CLAUDE.md` 或 `AGENTS.md` |

规则：只选**一个**目标位置，不分散。

## ADR 门槛

三条全满足才写 ADR，缺一不可：

1. **难回滚** — 改变技术路线或依赖成本高。
2. **没上下文会觉得奇怪** — 读代码会疑惑"为什么这样？"。
3. **有真实 trade-off** — 有明确放弃的备选方案。

## capture vs sediment

| 维度 | capture（本 skill） | sediment |
|---|---|---|
| 归属 | 项目 repo 内 docs/ | 个人 ~/notes/ |
| 生命周期 | 与代码共生，随项目归档 | 跨项目，塑造数字自我 |
| 读者 | 新人 / 新 agent 接手项目 | 未来的自己 |
| 典型内容 | ADR、SOP、踩坑、项目约定 | 原则、跨项目研究、认知模型 |

同一条知识若 LLM 能直接答且非项目特有 → 既不 capture 也不 sediment，直接不写。

## 元递归

capture 可以回写：
- `CLAUDE.md` / `AGENTS.md` — 把反复出现的项目决策升级为约定。
- `CONTEXT.md` — 追加新词汇或修正定义。
- 决策在 ADR 里反复引用 → 考虑提升为 `CLAUDE.md` 顶层约定。

## 输出（ADR 模板，Michael Nygard 风格）

```markdown
# ADR-<编号>: <标题>

**Date**: <YYYY-MM-DD>
**Status**: proposed | accepted | superseded by ADR-<N> | deprecated

## 背景
<一段，为什么需要做这个决策；引用 RFC / issue / commit>

## 决策
<选了什么，怎么做>

## 放弃的备选
- <备选 A>：<放弃原因>

## 后果
- 好处：
- 坏处 / 风险：

## 复评触发
<什么信号出现时应该重新评估这个决策>
```

> **重要**：Status 变更（如 accepted → superseded）不新建文件，原地更新；并在新 ADR 里 `Status: superseded by ADR-<N>` 反向引用。

## 流程

1. 先问："以后在本项目哪个场景会复用？"——答不上来则不写。
2. 拒绝泛化教程知识，判断：是项目特有还是通用？通用不写。
3. 查是否已有同主题文件（`find docs/ -name "*.md" | xargs grep -l "<topic>"`）。
4. 按目标位置表选唯一路径，创建或更新。
5. 写短产物：reference 优于 recopy，结论优于过程叙事。
6. 回报绝对路径。

## 停止条件

- 没有未来复用场景 → 不写，直接告知用户。
- 已有同主题文件 → 更新，不另起文件。
- 是个人原则 / 跨项目规律 → 转 `sediment`。
- 个人原则没有反例 → 先问用户反例，再决定是否沉淀。
- 内容是 LLM 通用知识 → 不写。
