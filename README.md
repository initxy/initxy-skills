# initxy-skills

这是 initxy 自己的 agent skill 集合。

它融合了 [Matt Pocock skills](https://github.com/mattpocock/skills) 等优秀 skill 的工程实践，新增了一些 initxy 自用 skill，并重新组织了说明、安装方式和阶段化调用路径。

## 怎么安装

```bash
# 安装到 Claude: ~/.claude/skills/
./scripts/install.sh

# 安装到 Codex: ~/.codex/skills/
./scripts/install.sh --to codex

# 只安装工程类 skill
./scripts/install.sh --bundle engineering
```

可用 bundle：

- `engineering`：工程研发主流程。
- `productivity`：沟通、交接、写 skill。
- `writing`：文章写作、编辑和 Obsidian。
- `all`：全部安装，默认推荐。

远程安装：

```bash
# 默认安装到 Claude，安装 all bundle
curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | bash

# 安装到 Codex
curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | bash -s -- --to codex

# 只安装工程类 skill
curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | bash -s -- --bundle engineering

# 安装到 Codex，并只安装 productivity bundle
curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | bash -s -- --to codex --bundle productivity
```

## 怎么使用

安装后，在 Codex / Claude 对话里直接点名 skill 即可：

```text
用 to-prd 帮我把这个需求整理成 PRD
用 to-sdd 基于 PRD 做技术设计
用 diagnose 排查这个测试失败
用 handoff 生成交接说明
```

如果不确定该用哪个，就按下面的阶段选。

## 各阶段用什么

| 阶段 | 目标 | 推荐 skill |
| --- | --- | --- |
| 项目初始化 | 建 issue tracker、triage 标签、领域文档约定 | `setup-matt-pocock-skills` |
| 理解现状 | 看清局部代码和整体系统关系 | `zoom-out` |
| 澄清问题 | 追问需求、方案、边界和风险 | `grill-me` / `grill-with-docs` |
| 需求定义 | 把上下文整理成 PRD | `to-prd` |
| 技术设计 | 在 PRD 后产出 SDD | `to-sdd` |
| 拆分任务 | 把方案拆成可独立领取的垂直切片 issue | `to-issues` |
| 原型验证 | 快速验证 UI、交互或技术可行性 | `prototype` |
| 实现功能 | 用红绿重构推进代码 | `tdd` |
| 排查问题 | 结构化诊断 bug、失败测试、性能回归 | `diagnose` |
| 整理 issue | 按状态机分类、推进、关闭 issue | `triage` |
| 架构改进 | 识别浅模块，合并成更清晰的深模块 | `improve-codebase-architecture` |
| 沟通压缩 | 把表达压到最短但保留技术准确性 | `caveman` |
| 工作交接 | 让另一个 agent 或人类继续接手 | `handoff` |
| 创建 skill | 写一个结构正确的新 skill | `write-a-skill` |

## 推荐主线

新需求从 0 到交付：

```text
grill-me -> to-prd -> to-sdd -> to-issues -> tdd -> handoff
```

已有代码需要理解或改造：

```text
zoom-out -> grill-with-docs -> improve-codebase-architecture -> to-issues -> tdd
```

线上问题或测试失败：

```text
diagnose -> tdd -> handoff
```

## Skill 分类

### Engineering

- `diagnose`：结构化排查 bug / 性能回归。
- `grill-with-docs`：结合 `CONTEXT.md` 与 ADR 追问方案，并即时沉淀术语和决策。
- `triage`：按状态机整理 issue。
- `improve-codebase-architecture`：寻找浅模块合并为深模块的架构机会。
- `setup-matt-pocock-skills`：为仓库初始化 issue tracker、triage 标签、领域文档约定。
- `tdd`：红绿重构循环。
- `to-issues`：把计划拆成可独立领取的垂直切片 issue。
- `to-prd`：把当前上下文整理成 PRD 并发布到 issue tracker。
- `to-sdd`：在 PRD 后、拆 issue 前生成软件设计文档。
- `zoom-out`：从局部代码上升一层看模块地图。
- `prototype`：构建一次性原型验证逻辑或 UI。
- `review`：从固定点 review diff，检查仓库标准和原始 spec。

### Productivity

- `caveman`：极简沟通模式。
- `grill-me`：对计划或设计做逐问追问。
- `handoff`：生成交接文档。
- `write-a-skill`：创建新 skill。

### Writing

- `edit-article`：编辑文章。
- `initxy-writer`：按 initxy 的务实、第一性原理、逻辑推导风格写作和改写。
- `obsidian-vault`：处理 Obsidian vault。
- `writing-beats`：以 beat 旅程方式塑造文章。
- `writing-fragments`：追问并收集写作 fragments。
- `writing-shape`：把原始材料塑造成可发布文章。

## 参考仓库

- [mattpocock/skills](https://github.com/mattpocock/skills)
