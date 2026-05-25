# Issue tracker: GitLab

本仓库的 issue 和 PRD 放在 GitLab Issues。所有操作使用 [`glab`](https://gitlab.com/gitlab-org/cli) CLI。

## 约定

- 创建：`glab issue create --title "..." --description "..."`。多行描述用 heredoc；`--description -` 会打开编辑器。
- 读取：`glab issue view <number> --comments`；机器可读输出用 `-F json`。
- 列表：`glab issue list -F json`，按需加 `--label`。
- 评论：`glab issue note <number> --message "..."`。GitLab 把评论叫 note。
- 加 / 移除标签：`glab issue update <number> --label "..."` / `--unlabel "..."`。
- 关闭：先 `glab issue note <number> --message "..."` 写解释，再 `glab issue close <number>`。
- Merge Request：GitLab 的 PR 叫 MR；使用 `glab mr create/view/note`。

在 clone 内运行时，`glab` 会从 `git remote -v` 推断 repo。

当 skill 说“publish to the issue tracker”，创建 GitLab issue。

当 skill 说“fetch the relevant ticket”，运行 `glab issue view <number> --comments`。
