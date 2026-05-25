---
name: review
description: 从一个固定点（commit、branch、tag、merge-base）review 当前变更，分 Standards（是否符合仓库编码标准）和 Spec（是否符合原 issue/PRD）两轴并行报告。当用户想 review branch、PR、WIP 或说 “review since X” 时使用。
---

# Review

review `HEAD` 与用户指定固定点之间的 diff：

- Standards：代码是否符合仓库文档化标准。
- Spec：是否忠实实现原 issue / PRD / spec。

两条轴应由并行 sub-agent 分别运行，避免上下文污染，然后汇总结果。

issue tracker 应已配置；若缺 `docs/agents/issue-tracker.md`，运行 `/setup-matt-pocock-skills`。

## 流程

### 1. 固定比较点

用户给的 commit、branch、tag、`main`、`HEAD~5` 等就是固定点。不要替用户改。如果没给，问：“Review against what — a branch, a commit, or `main`?”

记录：

- 固定点。
- `git diff --stat <fixed>...HEAD`
- `git diff --name-only <fixed>...HEAD`

### 2. 收集 spec

从 issue tracker、PRD、对话或用户指定路径读取原始目标。没有 spec 时明确说 Standards-only review。

### 3. 并行 review

启动两个独立 review：

**Standards brief**

- 读仓库编码标准、AGENTS/CLAUDE 指令、相关 ADR。
- review diff 是否违反标准、测试模式、架构语言。
- 找正确性风险、维护性风险、缺失测试。

**Spec brief**

- 读 spec / issue / PRD。
- review diff 是否满足需求、验收标准、out-of-scope。
- 找漏做、做偏、行为不一致。

### 4. 汇总

按严重程度输出 findings，带文件/行引用。格式：

```text
P1 — 标题
文件:行
问题说明。为什么会错。建议怎么修。
```

分组：

- Standards findings
- Spec findings
- Open questions

无问题时明确说没有发现，并说明剩余风险。
