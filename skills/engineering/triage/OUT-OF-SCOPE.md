# Out-of-Scope Knowledge Base

`.out-of-scope/` 存储被拒绝 feature request 的持久记录。

作用：

1. 机构记忆：记录为什么拒绝，避免 issue 关闭后丢失理由。
2. 去重：新 issue 与旧拒绝相似时，直接浮现之前决策。

## 目录结构

```text
.out-of-scope/
├── dark-mode.md
├── plugin-system.md
└── graphql-api.md
```

每个概念一个文件，不是每个 issue 一个文件。多个相同请求归到同一文件。

## 文件格式

写成短设计文档，解释清楚理由。

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope

...

## Prior requests

- #42 — "Add dark mode support"
- #87 — "Night theme for accessibility"
```

文件名用短 kebab-case：`dark-mode.md`、`plugin-system.md`。

理由要实质化，不要写“我们不想做”。好理由可以引用：

- 项目范围或哲学。
- 技术约束。
- 战略决策。

避免临时原因，如“现在太忙”；那是延期，不是拒绝。

## 何时检查

triage 收集上下文时读取 `.out-of-scope/*.md`。评估新 issue：

- 判断请求是否匹配旧 out-of-scope 概念。
- 按概念相似度，不按关键词。
- 匹配时告诉 maintainer：“This is similar to `.out-of-scope/dark-mode.md` — we rejected this before because... Do you still feel the same way?”

maintainer 可：

- Confirm：把新 issue 加到 Prior requests，关闭。
- Reconsider：删除或更新 out-of-scope 文件，让 issue 正常 triage。
- Disagree：相关但不同，继续正常 triage。

## 何时写入

只有 enhancement 被拒绝为 `wontfix` 时写入；bug 不写。

流程：

1. maintainer 决定某 feature out of scope。
2. 检查是否已有匹配文件。
3. 有则追加 Prior requests。
4. 无则创建文件，写概念、决策、理由和第一个请求。
5. 在 issue 评论解释并提到 `.out-of-scope/` 文件。
6. 加 `wontfix` 并关闭。

## 更新或移除

maintainer 改主意时：

- 删除 `.out-of-scope/` 文件。
- 不需要重开历史 issue。
- 触发重新考虑的新 issue 继续正常 triage。
