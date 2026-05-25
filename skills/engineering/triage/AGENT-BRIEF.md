# Writing Agent Briefs

agent brief 是 issue 移到 `ready-for-agent` 时发布的结构化评论。它是 AFK agent 的权威规格；原 issue 和讨论只是上下文。

## 原则

### 持久性优先于精确路径

issue 可能放几天或几周，代码会变。brief 要在文件重命名、移动、重构后仍有用。

- 描述 interface、type、行为 contract。
- 可以命名具体 type、函数签名、config shape。
- 不引用文件路径。
- 不引用行号。
- 不假设当前实现结构会保持。

### 描述行为，不描述步骤

说系统应该做什么，不说怎么实现。

好：`SkillConfig` type 应接受可选 `schedule: CronExpression`。

差：打开某文件第 42 行加字段。

### 验收标准完整

每条标准都应可独立验证。

好：`gh issue list --label needs-triage` 返回经过初步分类的 issue。

差：triage should work correctly。

### 范围边界明确

写清 out of scope，防止 agent 镀金或改相邻功能。

## 模板

```markdown
## Agent Brief

**Category:** bug / enhancement
**Summary:** 一句话说明要发生什么

**Current behavior:**
现在发生什么。bug 写坏行为；enhancement 写现状。

**Desired behavior:**
完成后应该发生什么。具体写边界 case 和错误条件。

**Key interfaces:**
- `TypeName` — 需要怎样变化及原因
- `functionName()` return type — 当前返回什么、应返回什么
- Config shape — 需要的新配置

**Acceptance criteria:**
- [ ] 具体、可测试标准 1
- [ ] 具体、可测试标准 2
- [ ] 具体、可测试标准 3

**Out of scope:**
- 不应改变的内容
- 相邻但独立的功能
```

## 反例

```markdown
## Agent Brief

**Summary:** Fix the triage bug

**What to do:**
The triage thing is broken. Look at the main file and fix it.
The function around line 150 has the issue.

**Files to change:**
- src/triage/handler.ts (line 150)
- src/types.ts (line 42)
```

问题：无 category、描述含糊、引用会过期的路径和行号、无验收标准、无范围边界。
