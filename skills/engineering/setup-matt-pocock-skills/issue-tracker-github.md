# Issue tracker: GitHub

本仓库的 issue 和 PRD 放在 GitHub Issues。所有操作使用 `gh` CLI。

## 约定

- 创建：`gh issue create --title "..." --body "..."`，多行 body 用 heredoc。
- 读取：`gh issue view <number> --comments`，同时获取 labels。
- 列表：`gh issue list --state open --json number,title,body,labels,comments --jq '[.[] | {number, title, body, labels: [.labels[].name], comments: [.comments[].body]}]'`，按需加 `--label` / `--state`。
- 评论：`gh issue comment <number> --body "..."`。
- 加 / 移除标签：`gh issue edit <number> --add-label "..."` / `--remove-label "..."`。
- 关闭：`gh issue close <number> --comment "..."`。

在 clone 内运行时，`gh` 会从 `git remote -v` 推断 repo。

当 skill 说“publish to the issue tracker”，创建 GitHub issue。

当 skill 说“fetch the relevant ticket”，运行 `gh issue view <number> --comments`。
