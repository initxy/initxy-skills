# 架构决策记录（ADR）格式

`capture` 写 ADR 时读取本文件。

```markdown
# ADR-<编号>: <标题>

**Date**: <YYYY-MM-DD>
**状态**：proposed | accepted | superseded by ADR-<N> | deprecated

## 背景

<为什么需要这个决策。能引用 RFC、issue、commit、事故记录就引用。>

## 决策

<选择了什么。>

## 放弃的备选

- <备选方案>：<为什么不选>

## 后果

- 好处：
- 代价 / 风险：

## 复评触发

<什么信号出现时应该重新评估这个决策。>
```

## 架构决策记录门槛

三条都满足才写 ADR：

- 难回滚。
- 没上下文会觉得奇怪。
- 有真实 trade-off。
