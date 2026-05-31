---
name: product-shaping
description: 将模糊产品想法系统收敛成 PRD 前置 Product Brief。Use when 用户想设计功能、梳理产品方案、从 idea 推导用户问题、价值、范围、指标、体验和风险；不要用于已有 PRD 后的技术设计，也不要用于单纯压力测试。
---

# Product Shaping

把模糊想法收敛成可写 PRD 的 Product Brief。

PRD 是协作契约，不是需求堆砌。它只需要先说清楚：为什么做、给谁做、做什么、不做什么、怎么验证。

## 边界

- 模糊想法 -> `product-shaping`
- 已有方案，想找漏洞 -> `grill-me`
- 已经清楚要做什么 -> `to-prd`
- 已有 PRD，做技术设计 -> `to-sdd`

推荐链路：

```text
idea -> product-shaping -> grill-me -> to-prd -> to-sdd -> to-issues
```

## 原则

- 从问题推导方案，不从模板倒填。
- 一次只问一个最高杠杆问题，并给推荐答案。
- 只问会改变产品方向、范围或验证方式的问题。
- 产品方向未定前，不追技术实现细节。

## 流程

按顺序补齐，缺哪层问哪层：

1. Problem：真实问题是什么？不做会怎样？
2. User / Scene：谁在什么场景下遇到？
3. Job：用户想完成什么任务？
4. Value：用户收益和业务收益是什么？
5. Metrics：成功指标和守护指标是什么？
6. Scope：P0、P1、非目标是什么？
7. Experience：核心路径和关键异常是什么？
8. Risk：最大假设是什么？怎么验证？

## 提问格式

```markdown
问题：...
推荐：...
原因：这个答案会决定 ...
```

不要一次列问题清单。除非用户要求“快速完整梳理”。

## 输出

信息足够时输出：

```markdown
# Product Brief: <名称>

## Problem Framing

- 用户：
- 场景：
- 问题：
- 不解决的代价：

## Value

- 用户收益：
- 业务收益：
- 成功指标：
- 守护指标：

## Scope

- P0：
- P1：
- 非目标：

## Experience

- 核心路径：
- 异常与失败：

## Risks

- 核心假设：
- 验证方式：

## Handoff

- 下一步：`grill-me` / `to-prd`
- 仍未决的问题：
```
