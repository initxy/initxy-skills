---
name: review
description: 审查 diff、PR 或实现代码，找正确性风险、回归、缺失测试和安全问题。触发词：review、代码审查、PR 审查、发布前检查、自审、看下我这段代码、合并前过一眼。
---

# Review

## 铁律

1. 先找真实风险，风格问题靠后。P0/P1 不解决前不放行。
2. 自审不可信——你已知道为什么这么写，**优先**走 `grill` / skeptic subagent 消除盲点。降级路径：subagent 不可用 → 外部 `codex` → 主 agent 自审 fallback（按 `grill` 步骤 4b，**报告顶部强制打偏见警告**）。
3. 没有具体 `file:line` 的 finding 不算 finding，不得写入报告。

## 何时不用我

- diff < 20 行且改的是测试或文档——直接看，无需走流程。
- 用户只想跑 lint / formatter——执行工具，不用我。
- 只是想理解代码意图，不是找 bug——用 `clarify` 或直接解释。

## 何时使用

- 用户说 "review"、"帮我看看"、"PR 审查"、"发布前 review"。
- 进入 `ship` 流程前的质量闸门。
- 自己刚写完代码要自审，防止带着理解盲点上线。

## 自审 vs PR 审

| 模式 | 触发 | 关键差异 |
|---|---|---|
| **自审** | 你刚写的代码 | 优先 spawn skeptic subagent；无 subagent 平台按 `grill` 的降级路径走 codex / 自审 fallback，并打偏见警告 |
| **PR 审** | 别人的代码 | 不需要 subagent；先读 plan/spec/issue 理解意图，再直接审 |

自审时调用 `grill` skill，把 diff 作为产物传入。skeptic subagent 的 prompt 模板与 fallback 流程**单一来源**在 `grill/SKILL.md`，本 skill 不内嵌副本，避免两份漂移。

## 流程

1. **查看变更**：`git diff HEAD` 或 `gh pr diff <PR>`，列出所有变更文件。
2. **理解意图**：读 plan/spec/issue，明确这段代码要解决什么问题、预期行为是什么。
3. **自审模式**：按 `grill` 降级路径取 skeptic 反馈（subagent → codex → 主 agent 自审 fallback），等待攻击结果后纳入报告；若走到自审 fallback，**报告顶部必须打偏见警告**。
4. **逐项检查**：
   - 正确性：逻辑、边界条件、类型断言。
   - 数据流：输入来源、变换、输出目标，有无数据被静默丢弃。
   - 错误处理：所有 error path 是否被捕获并正确传播。
   - 安全：输入校验、权限检查、敏感数据泄露风险。
   - 迁移风险：schema 变更、API 不兼容、依赖升级副作用。
   - 并发：锁、race condition、幂等性。
5. **测试覆盖**：变更的核心行为是否有对应测试；新分支/边界是否被覆盖。
6. **输出报告**：按 P0-P3 严重度排列 findings，每条带 `file:line`。

## 优先级

| 级别 | 定义 |
|---|---|
| P0 | 数据丢失、安全破坏、生产事故 |
| P1 | 高概率 bug 或严重回归 |
| P2 | 边界 bug、重要测试缺失 |
| P3 | 可维护性 / 清晰度 |

## 输出

```markdown
## Findings
- [P1] <问题描述> — `<file:line>`

## Open Questions
- <需要作者澄清的疑问>

## Test Gaps
- <缺口描述，或 none>

## 自审 skeptic 反馈
<skeptic subagent 的攻击点摘要，如有>
```

无阻塞问题时：
```
未发现阻塞问题。剩余风险：<简述>
```

## 停止条件

- 没有 diff 或审查目标——先问清楚目标再继续。
- 不理解预期行为——先读 plan/issue，或向用户提问，不猜测。
- 需要更深的 adversarial 评估——转 `grill`。
- 发现 P0/P1——block 发布，回到 `diagnose` 修复或 `tdd` 补测试，修完再走 `ship`。
