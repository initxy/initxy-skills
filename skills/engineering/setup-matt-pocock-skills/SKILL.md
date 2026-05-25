---
name: setup-matt-pocock-skills
description: 在 AGENTS.md/CLAUDE.md 中写入 `## Agent skills` 区块，并生成 `docs/agents/`，让工程类 skill 知道本仓库的 issue tracker、triage 标签和领域文档布局。首次使用 `to-issues`、`to-prd`、`triage`、`diagnose`、`tdd`、`improve-codebase-architecture`、`zoom-out` 前运行；这些 skill 缺少上下文时也运行。
disable-model-invocation: true
---

# Setup Matt Pocock's Skills

为工程类 skill 初始化每仓库配置：

- Issue tracker：工作项在哪里，默认 GitHub，也支持 GitLab 和本地 markdown。
- Triage labels：五个标准 triage 角色对应的真实标签。
- Domain docs：`CONTEXT.md` 和 ADR 的位置及读取规则。

这是 prompt 驱动的 skill，不是确定性脚本。先探索，展示发现，逐项确认，再写文件。

## 流程

### 1. 探索

读取现状，不要假设：

- `git remote -v` 和 `.git/config`：是否 GitHub / GitLab 仓库。
- 根目录 `AGENTS.md` / `CLAUDE.md`：是否已有 `## Agent skills`。
- 根目录 `CONTEXT.md` / `CONTEXT-MAP.md`。
- `docs/adr/` 与 `src/*/docs/adr/`。
- `docs/agents/`：是否已有本 skill 输出。
- `.scratch/`：是否已有本地 markdown issue 约定。

### 2. 展示发现并逐项询问

简述已有和缺失内容。然后一次只问一个决策。

#### A. Issue tracker

解释：issue tracker 是本仓库工作项所在位置。`to-issues`、`triage`、`to-prd`、`qa` 会读写它，因此需要知道该用 `gh issue create`、`.scratch/` 文件，还是其他流程。

默认：GitHub remote 用 GitHub；GitLab remote 用 GitLab；否则提供：

- GitHub：用 `gh` CLI。
- GitLab：用 `glab` CLI。
- Local markdown：写到 `.scratch/<feature>/`。
- Other：请用户用一段话描述流程，原样记录。

#### B. Triage 标签词汇

解释：`triage` 需要把 issue 移动到几个状态：待评估、等报告人、可交给 AFK agent、需要人类、不会做。真实标签可能不是默认名，需要映射。

五个标准角色：

- `needs-triage`
- `needs-info`
- `ready-for-agent`
- `ready-for-human`
- `wontfix`

默认标签名等于角色名。问用户是否覆盖。

#### C. Domain docs

解释：`improve-codebase-architecture`、`diagnose`、`tdd` 会读 `CONTEXT.md` 获取领域语言，读 `docs/adr/` 获取架构决策。

确认布局：

- Single-context：根目录一个 `CONTEXT.md` 和 `docs/adr/`。
- Multi-context：根目录 `CONTEXT-MAP.md` 指向各上下文。

### 3. 确认草稿

展示：

- 将写入 `CLAUDE.md` / `AGENTS.md` 的 `## Agent skills` 区块。
- `docs/agents/issue-tracker.md`
- `docs/agents/triage-labels.md`
- `docs/agents/domain.md`

让用户确认或修改后再写。

### 4. 写入

选择文件：

- 有 `CLAUDE.md` 就改它。
- 否则有 `AGENTS.md` 就改它。
- 两者都没有时，问用户创建哪个。

已有 `## Agent skills` 就原地更新，不追加重复块，不覆盖周边用户内容。

区块：

```markdown
## Agent skills

### Issue tracker

[一句话说明工作项在哪里]。See `docs/agents/issue-tracker.md`.

### Triage labels

[一句话说明标签词汇]。See `docs/agents/triage-labels.md`.

### Domain docs

[一句话说明 single-context 或 multi-context]。See `docs/agents/domain.md`.
```

三个 docs 文件以本目录模板为起点：

- [issue-tracker-github.md](./issue-tracker-github.md)
- [issue-tracker-gitlab.md](./issue-tracker-gitlab.md)
- [issue-tracker-local.md](./issue-tracker-local.md)
- [triage-labels.md](./triage-labels.md)
- [domain.md](./domain.md)

其他 tracker 则按用户描述写 `docs/agents/issue-tracker.md`。

### 5. 完成

告诉用户 setup 完成，并列出哪些工程 skill 会读取这些文件。以后可直接编辑 `docs/agents/*.md`；只有切换 tracker 或重做配置才需要重跑。
