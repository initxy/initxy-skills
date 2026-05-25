---
name: handoff
description: 为新 session 或 agent 写简洁交接文档，让接收方冷启动不靠对话历史。上下文过长、切换 agent、暂停工作时使用。触发词：交接、接力、新 session、切换 agent、handoff、cold start、记一下进度交给下一个 agent。
---

# Handoff

## 铁律

1. 不复制已有产物（plan、ADR、issue、commit）——只引用路径或 URL。接收方看不见你的对话，但能访问文件系统。
2. 删除敏感信息：token、密钥、个人账号、内部 URL 写成占位符 `<REDACTED>`。
3. 输出写到 repo 外、可持久化路径（`~/notes/handoffs/`）——重启不丢、跨 session 可恢复，避免污染代码库。

## 何时不用我

- Session 很短（< 30 分钟），对话历史完全可复用。
- 没有需要传递的中间状态，直接复用现有 `STATE.md` 或 `CONTEXT.md` 就够。
- 接收方是同一 session 的下一条消息——不需要跨 session 传递。

## 何时使用

- 上下文窗口即将耗尽，需要 fresh context 继续。
- 暂停工作超过数小时，需要留下可恢复的状态快照。
- 把任务移交给另一个 agent 或人类协作者。
- 准备让新会话或协作者冷启动执行某阶段。

## 流程

1. **扫描必要文件**：只读当前任务直接相关的变更文件、未关闭 issue、最近 commit——不读整个 repo。
2. **收集引用**：记录 plan 路径、ADR 路径、PR/issue URL、关键 commit hash——不复制原文。
3. **删敏感信息**：检查收集到的内容，token、密钥、内部域名替换为 `<REDACTED>`。
4. **生成文档**：按下方模板写到 `~/notes/handoffs/handoff-<slug>-<timestamp>.md`（timestamp 格式：`YYYYMMDD-HHMM`，避免多 session 撞名）。
5. **验证可读性**：假设接收方对话历史为空，重读一遍——能否冷启动？若不能，补充缺失上下文。
6. **回报路径**：输出绝对路径，告知用户文件已就绪。

## 输出

输出位置：`~/notes/handoffs/handoff-<slug>-<timestamp>.md`

```markdown
# Handoff: <主题 slug>

> 生成时间：<ISO 8601>  接收方：新 session / agent

## 目标
<一句话说清楚这个任务要达成什么结果>

## 当前状态
- 已完成：<列举>
- 进行中：<列举，注明卡在哪>
- 未开始：<列举>

## 关键产物（路径 / URL）
- plan：`<绝对路径>`
- ADR：`<绝对路径>`
- PR / issue：`<URL>`
- 其他：`<路径或 URL>`

## 决策
| 决策 | 选择 | 来源 |
|------|------|------|
| <问题> | <结论> | <ADR 路径 / 对话摘要> |

## 下一步（按优先级）
1. <具体动作，不写"继续"或"完成">
2. <具体动作>

## 建议使用的 Skill
- `<skill>`：<原因一句话>

## 风险 / 注意
- <风险或坑，接收方需要知道的>
```

## 停止条件

- 文档写完并回报绝对路径后停止。
- 若发现任务实际已完成，转 `verify` 而不是写交接文档。
- 若任务尚未开始（无状态可传递），转 `plan` 先拆步骤再交接。
