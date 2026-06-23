---
name: handoff
description: 把当前对话和工作进度压缩成交接说明。用于 handoff、交接、续接、总结进度，或让后续 session 继续。
---

# Handoff

写一份交接说明，让下一段 session 能从当前状态继续，不重新考古。

## 流程

1. **确定接手目标**：如果用户指定下一段要做什么，把它放在最前面；没有指定就按当前未完成任务整理。
2. **收集状态**：梳理目标、已经完成的改动、关键决策、验证结果、未完成事项、阻塞和风险。
3. **引用而非复制**：已有实现说明、ADR、提交、diff、文档、报告只给路径或 URL，不重复全文。
4. **保护敏感信息**：不要写 API key、密码、token、个人身份信息；必要时只说明“需要重新获取凭证”。
5. **给下一步**：列出建议使用的 skill、优先动作、需要先看的文件和注意事项。
6. **保存位置**：用户没指定位置时，把交接说明写到系统临时目录，并在回复中给绝对路径；不要默认写入当前 repo。

## 交接说明格式

```md
# Handoff

## Next Objective

## Current State

## Completed

## Key Decisions

## Important Files / Links

## Validation

## Open Items

## Risks / Blockers

## Suggested Skills

## Suggested Next Steps
```

## 完成标准

- 下一位 agent 能看懂当前目标、状态和最优下一步。
- 已完成内容和未完成内容分开，不混在一起。
- 关键决策说明原因，并引用相关 `CONTEXT.md`、ADR、实现说明或代码位置。
- 没有复制大段已有 artifact；只引用路径、URL 或提交。
- 没有泄漏敏感信息。
