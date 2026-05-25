# initxy-skills

> 个人 agent 操作系统 skill 包：从**立项**到**沉淀**，覆盖软件工程全流程。

**20 个 skill，6 个阶段，3 层架构**。专为重视**详细技术评审**、**对抗式审查**、**数字自我沉淀**的工作流而生。

借鉴 [superpower](https://github.com/obra) / [mattpocock](https://github.com/mattpocock) / get-shit-done / gstack / everything-claude-code 等社区 skill 的优秀思想，但**不是温柔的协助式 skill 包**——它默认会挑战你的假设、要求新鲜验证证据、拒绝沉淀 LLM 能直接回答的知识。

> 借鉴明细见 [来源对照表](#来源对照表)：每个来源借了哪些点、落到哪个 skill、和原作的差异。

---

## 架构

```
┌─────────────────────────────────────────────────────────────┐
│  控制面（3）                                                  │
│   os ─────────── 路由总线，把意图映射到具体 skill              │
│   setup-os ───── repo 首次初始化（单文件 AGENTS.md）           │
│   handoff ────── 跨 session 接力，写持久化交接文档            │
└─────────────────────────────────────────────────────────────┘
              ↓
┌──────────┬──────────┬──────────┬──────────┬──────────┬──────────┐
│ 1. 立项  │ 2. 定义  │ 3. 设计  │ 4. 构建  │ 5. 发布  │ 6. 沉淀  │
│ Triage   │ Define   │ Design   │ Build    │ Ship     │ Learn    │
├──────────┼──────────┼──────────┼──────────┼──────────┼──────────┤
│ assess   │ clarify  │ design   │ plan     │ verify   │ scan     │
│ (yc/roi) │ decide   │ rfc      │ tdd      │ review   │ learn    │
│          │          │ refactor │ diagnose │ ship     │ capture  │
│ grill ◄──┴─────────cross-cutting─────────┘          │ sediment │
└──────────┴──────────┴──────────┴──────────┴──────────┴──────────┘
```

## 仓库目录

skill 文件按 6 阶段分组放在 `skills/<category>/<skill>/`：

```
skills/
  control/    os, setup-os, handoff
  triage/     assess, grill
  define/     clarify, decide
  design/     design, rfc, refactor
  build/      plan, tdd, diagnose
  ship/       verify, review, ship
  learn/      scan, learn, capture, sediment
```

安装时**不会**在目标目录保留这层 `category/` 前缀——Claude/Codex 都会拿到平铺的 `~/.<agent>/skills/<skill>/`。分组只用于源仓库阅读。

## 20 个 skill 清单

### 控制面
| Skill | 职责 |
|---|---|
| **os** | 路由总线；把用户意图映射到具体 skill 序列 |
| **setup-os** | 新 repo 首次初始化 Karpathy 风格 AGENTS.md（带 `disable-model-invocation`；该字段 Claude Code 识别，其它平台不识别，但首句已用「手动运行」做跨平台兜底） |
| **handoff** | 上下文耗尽 / 切换 agent 时写持久化交接文档 |

### 立项 Triage
| Skill | 职责 |
|---|---|
| **assess** | 判断值不值得做。模式：`yc`（产品方向）/ `roi`（工程内决策） |
| **grill** | **对抗式追问 / 红队攻击**。spawn skeptic subagent 或调外部 codex；只攻不守 |

### 定义 Define
| Skill | 职责 |
|---|---|
| **clarify** | 把模糊请求变成清晰问题定义（问题 / 目标 / 用户 / 范围 / 验收） |
| **decide** | A vs B 决策。内置 Bezos 一向门 / 双向门，可逆决策低 bar，不可逆高 bar + ADR |

### 设计 Design
| Skill | 职责 |
|---|---|
| **design** | 轻型方案草图（1-3 模块、几天能完成、私下探索） |
| **rfc** | **重型技术评审**：模块 / 技术栈 / 数据模型 / 数据流 / API 契约 / NFR / 失败模式 / 可观测性 / 安全 / 成本。完整模板见 [`skills/design/rfc/templates/full-rfc.md`](skills/design/rfc/templates/full-rfc.md)。**未被 grill 不算定稿** |
| **refactor** | 存量代码结构改造（深浅模块 / 删除测试 / 接缝） |

### 构建 Build
| Skill | 职责 |
|---|---|
| **plan** | 把方案拆成垂直切片步骤表（依赖 / 并行 / 验证 / 第一刀） |
| **tdd** | 红绿重构循环；走 public interface，写不出测试 = 没想清楚问题 |
| **diagnose** | bug / 失败 / 回归排查（最快反馈环 / 可证伪假设 / 一次一个变量） |

### 发布 Ship
| Skill | 职责 |
|---|---|
| **verify** | **强制验证闸门**。不接受"应该"、"看起来"、子 agent 报告；要求新鲜命令输出 |
| **review** | diff/PR 审查。自审强制走 grill 的 skeptic subagent；按 P0-P3 分级 |
| **ship** | PR / release / deploy 包装；强制走 verify + review；含 changelog + 回滚预案 |

### 沉淀 Learn
| Skill | 职责 |
|---|---|
| **scan** | 外部信息（链接 / release / 帖子）过滤成 act / watch / drop |
| **learn** | 建心智模型 + 检验题（mattpocock 风格）+ 唯一性判定 |
| **capture** | **项目向**沉淀：ADR / SOP / 诊断经验（写 repo 内 docs/，按需建目录） |
| **sediment** | **个人向数字自我沉淀**（写 `~/notes/`）。**铁律**：LLM 能直接答的不存；网上能搜到的不存；只存「为什么是我才能写出这个」的独特内容 |

## 6 条设计原则

| # | 原则 | 借鉴 |
|---|---|---|
| 1 | 对抗优于协助 | superpower |
| 2 | 能不写就不写（每个 skill 有「何时不用我」逃生口） | GSD |
| 3 | 意见优于框架（默认栈、默认推荐） | gstack |
| 4 | 教会胜过给答案 | mattpocock |
| 5 | 验证是闸门（拒绝"应该""看起来"） | superpower |
| 6 | 元递归（sediment / capture 能回写约定） | everything-claude-code |

## 来源对照表

只列**实际落地**的借鉴点，不列"理念上类似"。当前借鉴扎实度：superpower 高 · GSD 中 · mattpocock 中 · gstack 低（默认栈未填写） · everything-claude-code 低（无完整 hooks/commands 闭环）。

| 来源 | 借鉴点 | 落到的 skill | 与原作的差异 |
|---|---|---|---|
| **superpower**（[obra/superpowers](https://github.com/obra)） | 新鲜验证证据 / 拒绝"应该""看起来" | `verify` | 中文重写、绑定 `ship` 闸门 |
| superpower | 红绿先于代码 | `tdd` | 没硬卡"必须先写测试"，留用户跳过口 |
| superpower | 根因定位、最快反馈环、一次一个变量 | `diagnose` | 强调"可证伪假设"措辞 |
| superpower | subagent-driven review | `grill` / `review` | 已加 codex / 主 agent 自审 fallback 应对无 subagent 平台 |
| **GSD**（get-shit-done） | 「能直接做就别流程化」每个 skill 留逃生口 | 全部 20 个 skill 的「何时不用我」 | 把"逃生口"显式作为模板字段 |
| **gstack** | opinionated default stack | `skills/design/rfc/SKILL.md` 默认栈表 | **当前为空占位**，未真正落地，详见 rfc skill 中的状态说明 |
| gstack | 外部 codex 调用思路 | `grill` 的 `--external` 模式 | 仅伪流程示意，未做完整集成 |
| **mattpocock** | 心智模型 + 检验题 + 练习 | `learn` | 检验题用"自答 + 一刀切"格式，未直接复用 mattpocock 课程结构 |
| **everything-claude-code** | 元递归：skill 能回写约定 | `capture`（项目向） / `sediment`（个人向） | **未实现完整 hooks/commands/rules 闭环**，仅写约定文件 |
| everything-claude-code | description 字段即触发器 | `setup-os` 不复制 skill 路由表的设计 | 借了"description 优先"，没借自动注入机制 |

仍是**理念借鉴**而非可执行复刻的部分：mattpocock 的具体课程对照、gstack 的实际栈、everything-claude-code 的 hooks 自动化。这些位置已在对应 skill 文件中标注 `<待填>` 或"未实现"。

## 安装

四种方式，按你的使用场景选。**首次试用推荐方式 A**；边用边改推荐方式 C。

### 方式 A：远程一行装（不用 clone，**首次试用推荐**）

```bash
# 全量装到 ~/.claude/skills/（默认）
curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | bash

# 带参数：参数走 `bash -s --` 透传给 install.sh
curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | bash -s -- --to codex
curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | bash -s -- --bundle ship --project

# 锁版本（任意 branch / tag / commit sha）
REF=v0.2.0 curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | bash
```

依赖：`curl` / `tar` / `jq`（macOS：`brew install jq`）。原理：拉 GitHub tarball → 解压到 `mktemp` 临时目录 → 调用包里的 `scripts/install.sh` → 退出时清理。所有 `install.sh` 的参数（`--to` / `--project` / `--bundle`）都能透传。

### 方式 B：clone + 脚本批量拷贝（**装到 claude 或 codex 都行**）

```bash
git clone git@github.com:initxy/initxy-skills.git
cd initxy-skills

# 需要 jq
brew install jq  # macOS

# 全量装到 Claude 用户目录（默认）
./scripts/install.sh

# 装到 Codex 用户目录
./scripts/install.sh --to codex

# 只装 ship 阶段到当前项目的 .claude/skills
./scripts/install.sh --bundle ship --project

# 完整组合
./scripts/install.sh --to codex --bundle learn --project
```

参数说明：

| 参数 | 默认值 | 说明 |
|---|---|---|
| `--to claude\|codex` | `claude` | 目标 agent |
| `--project` | 关闭 | 装到当前项目 `./.<agent>/skills/`，不带则装到用户目录 |
| `--bundle <name>` | `all` | 见 `manifests/bundles.json`：control / triage / define / design / build / ship / learn / all |

不论 `--to` 选哪个，目标目录里的 skill 都是**平铺**的（`~/.<agent>/skills/os/`、`~/.<agent>/skills/grill/` ...），源仓库的 `skills/<category>/` 分组只用于阅读。

### 方式 C：symlink（**自己用 + 边用边改 推荐**）

```bash
git clone git@github.com:initxy/initxy-skills.git ~/dev/initxy-skills
mkdir -p ~/.claude/skills
ln -s ~/dev/initxy-skills/skills ~/.claude/skills/initxy-skills
```

好处：`git pull` 一下，Claude 立刻看到最新版本；改 skill 即时生效。

> 注：这种装法目标目录下会多一层 `initxy-skills/<category>/<skill>/` 路径。Claude/Codex 都支持递归扫描 `skills/` 找 `SKILL.md`，所以照样能加载。换成 codex 把 `~/.claude` 改成 `~/.codex` 即可。

### 方式 D：Claude Code Plugin marketplace（计划中，尚未发布）

> ⚠️ 本仓库尚未发布为 Claude Code marketplace（`.claude-plugin/marketplace.json` 等元数据未建立）。下面的命令是**目标形态**，照抄当前会失败。等发布后会移除本警告。

```bash
/plugin marketplace add initxy/initxy-skills
/plugin install initxy-skills@initxy-skills
```

发布后 Claude Code 自动管理；后续 `/plugin update` 即可升级。仅对 Claude Code 生效，Codex 用户继续用方式 A/B。

## 快速开始

装好后，下次跟 Claude Code 说：

- 「这个想法值不值得做？」→ 触发 `assess`
- 「帮我质疑一下这个方案」→ 触发 `grill`
- 「写个 RFC」→ 触发 `rfc`
- 「我有个跨项目的判断」→ 触发 `sediment`
- 「不知道用哪个 skill」→ 触发 `os` 路由

或者在新 repo 里初始化：

```bash
# 在你的 repo 根目录
cd ~/your-project
# 在 Claude Code 里说："跑 setup-os 初始化项目约定"
```

会创建/补齐一个 Karpathy 风格 `AGENTS.md`（若已存在 `CLAUDE.md` 则就地补齐），追加一段指向 initxy-skills 的引用。**不预建** `docs/` 子目录——等真的写第一份 ADR/SOP 时再 `mkdir`。

## 工作流示例

```
新想法
   ↓
[assess --yc] ──── 不值得 ──→ STOP
   ↓
[grill] ──── 假设被攻破 ──→ 改方案 / 弃方案
   ↓
[clarify] ──→ 明确目标 / 范围 / 验收
   ↓
[decide]? ──── A vs B 真 trade-off 时
   ↓
[design] 或 [rfc] ── 看复杂度
   ↓
[grill] ──── 设计被攻击
   ↓
[plan] ──→ 垂直切片步骤
   ↓
[tdd] ──→ 红绿重构
   ↓
[verify] ←── 闸门（不接受"应该"）
   ↓
[review] ──→ P0/P1 阻塞
   ↓
[ship] ──→ 准备 PR / release
   ↓
[learn] + [sediment] ── 把独特知识写入数字自我
```

Bug 链路：`diagnose → verify → capture?`
学习链路：`scan? → learn → sediment?（个人）或 capture?（项目）`

## 自我使用建议

1. **首次接入**：在第一个项目里跑 `setup-os` 创建 AGENTS.md。
2. **填默认栈**：打开 `skills/design/rfc/SKILL.md`，把「默认栈」表的 7 个 `<待填>` 替换成你跨项目都好使的栈。
3. **建数字自我仓库**：`~/notes/` 强烈建议作为私有 git repo 单独维护——这是你跨项目的长期资产。
4. **边用边改**：用 symlink 安装方式，发现 skill 不顺手就直接改文件，下次立即生效。

## License

MIT
