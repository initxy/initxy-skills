# Issue tracker: Local Markdown

本仓库的 issue 和 PRD 放在 `.scratch/` 的 markdown 文件中。

## 约定

- 每个 feature 一个目录：`.scratch/<feature-slug>/`
- PRD：`.scratch/<feature-slug>/PRD.md`
- 实现 issue：`.scratch/<feature-slug>/issues/<NN>-<slug>.md`，从 `01` 编号。
- triage 状态写在文件顶部附近的 `Status:` 行，角色名见 `triage-labels.md`。
- 评论和历史追加到文件底部 `## Comments`。

当 skill 说“publish to the issue tracker”，在 `.scratch/<feature-slug>/` 下创建文件。

当 skill 说“fetch the relevant ticket”，读取用户给出的路径或编号对应文件。
