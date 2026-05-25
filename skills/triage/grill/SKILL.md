---
name: grill
description: 对产物（idea/spec/plan/design/rfc）做对抗式追问与红队攻击。触发词：质疑一下、挑刺、找漏洞、红队、攻击方案、这个假设站得住脚吗、压力测试方案。assess/design/rfc/plan 完成后或用户明确要求被挑战时使用。
---

# Grill

## 铁律

1. **只攻不守**：不给修改建议，不给替代方案，只暴露问题。发现漏洞就戳破，不温柔。
2. **优先用独立 skeptic**：主 agent 已知作者思路，容易手软。按下面顺序降级，每一步失败才走下一步：
   1) spawn skeptic subagent（如 Claude Code 的 Agent / general-purpose）；
   2) 调外部 `codex` CLI；
   3) **fallback：主 agent 自审**——但必须在输出顶部加 `> ⚠️ 本次 grill 在无独立 skeptic 环境运行，作者偏见未消除，建议补一轮人工独立 review。`，且每条 attack 都要附「自我反驳点」说明自己最可能漏掉什么。
3. **不给结论**：呈现 attack points 后停下，不替用户决定改/弃/推进。

## 何时不用我

- 用户要快速决策，不想被挑战 → 转 `decide` 或 `assess`。
- 产物太初步，问题还没说清楚 → 先 `clarify`，再来 grill。
- 时间紧、结果可逆（GSD 原则：grill 是奢侈，不是必须）→ 直接推进，接受风险。

## 何时使用

- `assess` 之后：立项假设需要被第三方挑战。
- `design` 或 `rfc` 之后：技术方案需要被红队攻击。
- `plan` 之后：检验计划是否过度乐观、遗漏依赖。
- 用户明确说：质疑一下 / 挑刺 / 红队 / 找漏洞 / 这个假设站得住脚吗。

## 流程

**步骤 1：拿到产物**

让用户提供文件路径或直接粘贴产物文本。如果用户没给，问一句：「请提供要被 grill 的产物（文件路径或文本）。」

**步骤 2：选择 skeptic 路径**

| 模式 | 触发方式 | 说明 |
|---|---|---|
| 默认 | 无参数 | spawn general-purpose subagent 作为 skeptic；如平台无 Agent 工具，降级到 codex；再不行则主 agent 自审并打偏见警告 |
| `--external` | 用户指定 | 探测 codex CLI，调外部 review；不可用则静默回退 subagent，再不行回退主 agent 自审 |
| `--both` | 用户指定 | subagent + codex 都跑，合并输出；任一不可用则记录原因并继续另一路 |
| `--self` | 用户指定 | 直接走主 agent 自审 fallback（用户明知偏见、只需结构化结果时） |

**步骤 3：spawn skeptic subagent（借鉴 superpower）**

```text
Agent(
  subagent_type: "general-purpose",
  description: "Skeptic review of <产物类型>",
  prompt: """
    你是怀疑论者。下面是一份 <类型：idea/spec/plan/design/rfc> 产物。
    你看不到作者的推理过程，只看产物本身。

    任务：
    1. 找出最弱的 3 个假设或漏洞。
    2. 每个给出「弱假设」一句话概括，和「最小反驳依据需求」——作者要拿什么具体证据才能说服你。
    3. 不写正面评价。不给修改建议。只攻击。

    输出格式（严格按此，不加废话）：
    ## Attack 1: <一句话>
    - 弱假设：
    - 反驳需求：
    ## Attack 2: ...
    ## Attack 3: ...
    ---
    <产物原文>
  """
)
```

**步骤 4：codex 外部路径（借鉴 gstack）**

仅在 `--external` 或 `--both` 时执行：

```bash
if command -v codex >/dev/null 2>&1; then
  codex -p "你是怀疑论者，只攻击以下产物的最弱 3 个假设，给出每个的弱假设概括和最小反驳依据需求，不写正面评价，不给修改建议。" < artifact.md
else
  # codex 不可用，静默回退到 subagent 路径
  echo "[grill] codex not found, falling back to subagent"
fi
```

**步骤 4b：主 agent 自审 fallback**

仅在 subagent 与 codex 都不可用，或显式 `--self` 时执行。主 agent 必须：

1. 强制输出顶部加一行警告：`> ⚠️ 本次 grill 在无独立 skeptic 环境运行，作者偏见未消除，建议补一轮人工独立 review。`
2. 每条 Attack 额外加 `- 自我反驳点：<我作为作者最可能漏掉什么——具体到原因>`，逼自己跳出作者视角。
3. 检查清单：① 时间/成本估计是否过度乐观；② 是否存在「这不就是 XX 吗」的简化反例；③ 用户/场景假设是否需要数据支撑；④ 失败模式与回滚是否有空缺；⑤ 是否在偷换名词（同名不同义）。

**步骤 5：结构化呈现**

拿到 skeptic 反馈后，按输出模板呈现，不加自己的评论和建议。

**步骤 6：停下，等用户决定**

不给结论。用户选择：改方案 / 收集证据 / 弃方案 / 推进（接受风险）。

## 输出

```markdown
## Attack 1: <一句话>
- 弱假设：<skeptic 认为产物依赖的未经验证的假设>
- 反驳需求：<作者需要拿什么具体证据才能说服 skeptic>

## Attack 2: <一句话>
- 弱假设：
- 反驳需求：

## Attack 3: <一句话>
- 弱假设：
- 反驳需求：

## 没被攻破的部分
<列出 skeptic 没找到漏洞的地方——但不等于这些一定正确>

## 下一步
选择：改方案 / 收集证据 / 弃方案 / 推进（接受风险）
```

## 停止条件

- 产物还太初步，问题没说清 → 转 `clarify`，grill 之前先把产物写出来。
- 用户要正面建议或替代方案 → 转 `design` 或 `decide`。
- 用户要知道值不值得做 → 转 `assess`。
