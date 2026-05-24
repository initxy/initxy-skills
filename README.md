# initxy-skills

> 个人 agent 操作系统 skill 包：从**立项**到**沉淀**，覆盖软件工程全流程。

**20 个 skill，6 个阶段，3 层架构**。专为重视**详细技术评审**、**对抗式审查**、**数字自我沉淀**的工作流而生。

借鉴 [superpower](https://github.com/obra) / [mattpocock](https://github.com/mattpocock) / get-shit-done / gstack / everything-claude-code 等社区 skill 的优秀思想，但**不是温柔的协助式 skill 包**——它默认会挑战你的假设、要求新鲜验证证据、拒绝沉淀 LLM 能直接回答的知识。

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

## 20 个 skill 清单

### 控制面
| Skill | 职责 |
|---|---|
| **os** | 路由总线；把用户意图映射到具体 skill 序列 |
| **setup-os** | 新 repo 首次初始化 Karpathy 风格 AGENTS.md（`disable-model-invocation`） |
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
| **rfc** | **重型技术评审**：模块 / 技术栈 / 数据模型 / 数据流 / API 契约 / NFR / 失败模式 / 可观测性 / 安全 / 成本。完整模板见 [`rfc/templates/full-rfc.md`](rfc/templates/full-rfc.md)。**未被 grill 不算定稿** |
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

## 安装

三种方式，按你的使用场景选。

### 方式 A：Claude Code Plugin（最优雅）

```bash
# 把本仓库注册为 marketplace
/plugin marketplace add initxy/initxy-skills

# 安装
/plugin install initxy-skills@initxy-skills
```

Claude Code 自动管理；后续 `/plugin update` 即可升级。

### 方式 B：脚本批量拷贝（适合需要 codex 兼容）

```bash
git clone git@github.com:initxy/initxy-skills.git
cd initxy-skills

# 需要 jq
brew install jq  # macOS

# 装到 Claude 用户目录
./scripts/install.sh --bundle all --target claude-user
```

支持的 bundle：见 `manifests/bundles.json`（按 6 阶段分组：control / triage / define / design / build / ship / learn / all）。

支持的 target：
- `claude-user` → `~/.claude/skills/`（推荐）
- `claude-project` → `./.claude/skills/`（仅当前项目）
- `codex-user` → `~/.codex/skills/`
- `codex-project` → `./.codex/skills/`

### 方式 C：symlink（**自己用 + 边用边改 推荐**）

```bash
git clone git@github.com:initxy/initxy-skills.git ~/dev/initxy-skills
mkdir -p ~/.claude/skills
ln -s ~/dev/initxy-skills ~/.claude/skills/initxy-skills
```

好处：`git pull` 一下，Claude 立刻看到最新版本；改 skill 即时生效。

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
2. **填默认栈**：打开 `rfc/SKILL.md`，把「默认栈」表的 7 个 `<待填>` 替换成你跨项目都好使的栈。
3. **建数字自我仓库**：`~/notes/` 强烈建议作为私有 git repo 单独维护——这是你跨项目的长期资产。
4. **边用边改**：用 symlink 安装方式，发现 skill 不顺手就直接改文件，下次立即生效。

## License

MIT
