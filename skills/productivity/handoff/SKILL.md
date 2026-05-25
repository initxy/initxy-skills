---
name: handoff
description: 把当前对话压缩成交接文档，供另一个 agent 继续。
argument-hint: "下一段 session 要做什么？"
---

写一份交接文档，总结当前对话，让新 agent 能继续工作。保存到用户系统临时目录，不保存到当前 workspace。

包含 “suggested skills” 章节，建议下一位 agent 调用哪些 skills。

不要复制已在其他 artifact 中捕获的内容，如 PRD、计划、ADR、issue、commit、diff；用路径或 URL 引用。

隐藏敏感信息，如 API key、密码、个人身份信息。

如果用户传了参数，把它当作下一段 session 的重点，并据此调整交接文档。
