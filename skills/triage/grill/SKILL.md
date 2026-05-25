---
name: grill
description: 对齐式追问或红队攻击。需求/方案还没说透时用 align 模式逐问对齐；已有 idea/spec/plan/design/rfc 需要找漏洞时用 redteam 模式。触发词：grill me、追问我、帮我想清楚、质疑一下、挑刺、找漏洞、红队、攻击方案、这个假设站得住脚吗、压力测试方案。
---

# Grill

## 铁律

1. 先选模式，不混用：
   - `align`：Matt Pocock 式逐问对齐，目标是消除歧义；每次只问一个问题，并给推荐答案。
   - `redteam`：superpowers 式独立 skeptic，只攻击，不给替代方案。
2. `align` 不批量提问；问一个，等用户回答，再继续。能从代码/文档查到的问题，先查，不问用户。
3. `redteam` 优先用独立怀疑者：主 agent 已知作者思路，容易手软。按下面顺序降级，每一步失败才走下一步：
   1) 派发怀疑者子 agent（如 Claude Code 的 Agent / general-purpose）；
   2) 调外部 `codex` CLI；
   3) **fallback：主 agent 自审**——但必须在输出顶部加 `> ⚠️ 本次 grill 在无独立怀疑者环境运行，作者偏见未消除，建议补一轮人工独立 review。`，且每条攻击都要附「自我反驳点」说明自己最可能漏掉什么。
4. `redteam` 不给结论：呈现 attack points 后停下，不替用户决定改/弃/推进。

## 何时不用我

- 用户要快速决策，不想被追问或挑战 → 转 `decide` 或 `assess`。
- 只是缺目标/范围/验收，不需要压力测试 → 转 `clarify`。
- 时间紧、结果可逆（GSD 原则：grill 是奢侈，不是必须）→ 直接推进，接受风险。

## 何时使用

- 用户说 "grill me"、"追问我"、"帮我想清楚" → `align`。
- 产物还只是想法，需要把每个分支问清楚 → `align`。
- `assess` 之后：立项假设需要被第三方挑战。
- `design` 或 `rfc` 之后：技术方案需要被红队攻击。
- `plan` 之后：检验计划是否过度乐观、遗漏依赖。
- 用户明确说：质疑一下 / 挑刺 / 红队 / 找漏洞 / 这个假设站得住脚吗。

## 模式选择

| 模式 | 触发 | 目标 | 输出 |
|---|---|---|---|
| `align` | 没有稳定产物、用户要被追问 | 达成共享理解 | 一个问题 + 推荐答案 |
| `redteam` | 已有产物、用户要找漏洞 | 暴露最弱假设 | 3 个 attack points |

默认规则：没有明确产物时走 `align`；有文件/文本产物且用户说"质疑/红队/找漏洞"时走 `redteam`。

参考资料：
- `align` 问题模式：[`references/align-question-patterns.md`](references/align-question-patterns.md)
- `redteam` 提示词：[`references/redteam-prompts.md`](references/redteam-prompts.md)

## 流程

### align 流程

1. 复述当前理解（一句话），指出最模糊的一个分支。
2. 问一个问题。问题必须能推动决策树收敛，不问背景闲聊。
3. 同时给推荐答案：`我的推荐：<答案>，因为 <一句理由>`。
4. 等用户回答；根据回答更新理解，再问下一个问题。
5. 当目标、用户/场景、范围、非目标、验收、关键风险都清楚时停止，并输出对齐摘要。

align 输出：

```markdown
## 当前理解
<一句话>

## 问题
<一个具体问题>

## 我的推荐
<推荐答案 + 一句理由>
```

align 停止输出：

```markdown
## 对齐摘要
- 目标：
- 范围：
- 不做：
- 验收：
- 最大风险：

## 下一步
clarify | assess | decide | design | rfc | plan | redteam
```

### redteam 流程

**步骤 1：拿到产物**

让用户提供文件路径或直接粘贴产物文本。如果用户没给，问一句：「请提供要 redteam 的产物（文件路径或文本）。」

**步骤 2：选择 skeptic 路径**

| 模式 | 触发方式 | 说明 |
|---|---|---|
| 默认 / `--redteam` | 无参数或用户指定 | 派发 general-purpose 子 agent 作为怀疑者；如平台无 Agent 工具，降级到 codex；再不行则主 agent 自审并打偏见警告 |
| `--align` | 用户指定或无稳定产物 | 逐问对齐，不 spawn skeptic |
| `--external` | 用户指定 | 探测 codex CLI，调外部 review；不可用则静默回退 subagent，再不行回退主 agent 自审 |
| `--both` | 用户指定 | subagent + codex 都跑，合并输出；任一不可用则记录原因并继续另一路 |
| `--self` | 用户指定 | 直接走主 agent 自审 fallback（用户明知偏见、只需结构化结果时） |

**步骤 3：派发怀疑者子 agent（借鉴 superpower）**

提示词详见 [`references/redteam-prompts.md`](references/redteam-prompts.md)。需要完整提示词时读取该文件，不在主 skill 中重复维护。

**步骤 4：codex 外部路径（借鉴 gstack）**

仅在 `--external` 或 `--both` 时执行：

```bash
if command -v codex >/dev/null 2>&1; then
  codex -p "你是怀疑论者，只攻击以下产物的最弱 3 个假设，给出每个的弱假设概括和最小反驳依据需求，不写正面评价，不给修改建议。" < artifact.md
else
  # codex 不可用，静默回退到子 agent 路径
  echo "[grill] codex not found, falling back to subagent"
fi
```

**步骤 4b：主 agent 自审 fallback**

仅在 subagent 与 codex 都不可用，或显式 `--self` 时执行。主 agent 必须：

1. 强制输出顶部加一行警告：`> ⚠️ 本次 grill 在无独立怀疑者环境运行，作者偏见未消除，建议补一轮人工独立 review。`
2. 每条攻击额外加 `- 自我反驳点：<我作为作者最可能漏掉什么——具体到原因>`，逼自己跳出作者视角。
3. 检查清单：① 时间/成本估计是否过度乐观；② 是否存在「这不就是 XX 吗」的简化反例；③ 用户/场景假设是否需要数据支撑；④ 失败模式与回滚是否有空缺；⑤ 是否在偷换名词（同名不同义）。

**步骤 5：结构化呈现**

拿到 skeptic 反馈后，按输出模板呈现，不加自己的评论和建议。

**步骤 6：停下，等用户决定**

不给结论。用户选择：改方案 / 收集证据 / 弃方案 / 推进（接受风险）。

## 输出

```markdown
## 攻击 1: <一句话>
- 弱假设：<怀疑者认为产物依赖的未经验证的假设>
- 反驳需求：<作者需要拿什么具体证据才能说服怀疑者>

## 攻击 2: <一句话>
- 弱假设：
- 反驳需求：

## 攻击 3: <一句话>
- 弱假设：
- 反驳需求：

## 没被攻破的部分
<列出怀疑者没找到漏洞的地方——但不等于这些一定正确>

## 下一步
选择：改方案 / 收集证据 / 弃方案 / 推进（接受风险）
```

## 停止条件

- 产物还太初步且用户要追问 → 走 `align`，不要硬做 redteam。
- 只缺结构化问题定义 → 转 `clarify`。
- 用户要正面建议或替代方案 → 转 `design` 或 `decide`。
- 用户要知道值不值得做 → 转 `assess`。
