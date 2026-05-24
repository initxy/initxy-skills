---
name: ship
description: 准备 PR、release 或部署的发布闸门。触发词：ship、发布、创建 PR、release、deploy、push、代码准备好了吗、可以发布了吗、写 changelog、回滚预案。
---

# Ship

## 铁律

1. **能发布 = 已 review、已 verify、可回滚**。三者缺一，状态为 blocked。
2. **破坏性动作（push --force / 创建 release / deploy）必须用户明确要求**，你只输出"下一步"，不擅自执行。
3. **不碰无关 dirty 文件**。工作区有未提交的无关改动，记录在报告里，不自动 stash 或丢弃。

## 何时不用我

- **本地小提交不发布** — 只是 commit 一个小改动，直接 commit，不用我。
- **还在开发中** — 功能未完成、测试还没跑绿，先用 `tdd` / `verify`，不用我。
- **只是想看 diff** — 直接 `git diff`，不用走发布流程。

## 何时使用

- 用户说 ship / 发布 / push / 准备 PR / create release / deploy
- 用户问"代码准备好了吗"、"可以合了吗"、"发版前要检查什么"
- CI 通过后想正式打包发布
- 需要写 changelog / release notes

## 流程

**Step 1 — 检查工作区和分支**
```bash
git status          # 列出 dirty 文件，区分相关 / 无关
git branch -v       # 当前分支
git fetch && git log HEAD..@{u} --oneline   # 是否落后 main/upstream
```
无关 dirty 文件：列出，不碰，继续。落后 main 超过 N 个 commit：blocked，提示先 rebase。

**Step 2 — 读取发布意图**
按顺序查找：`plan.md` > open issue > PR description > `rfc` 产物。提取预期变更范围，作为后续 diff 对照基准。

**Step 3 — 跑验证 gate（强制）**
走 `verify` 作为必经闸门，获取实测结果。不接受推断或"应该"。verify 失败 = blocked，输出具体命令和错误。

**Step 4 — 对 diff 跑 review**
走 `review` 作为必经闸门，获取 review 结论。P0/P1 问题 = blocked；P2 列入风险项，由用户决策。

**Step 5 — 总结变更（用户视角）**
按 user-facing 价值排序：新功能 > 修复 > 性能 > 内部改进。不写实现细节，不写文件名。

**Step 6 — 写风险和回滚预案**
每个风险项给出：触发条件、影响范围、回滚命令或步骤。没有明确回滚方案的破坏性发布 = blocked。

**Step 7 — 等待用户确认**
输出"下一步"动作清单，等用户明确说"执行"才操作。

## 输出

```markdown
## 发布状态
ready | blocked

## 验证
- `<cmd>` -> pass / fail
- `<cmd>` -> pass / fail

## Diff 摘要
- <user-facing 变更，按 impact 排序>

## 风险 / 回滚
- 风险：<描述>
- 回滚：`<命令或步骤>`

## Changelog
<一段简洁的用户视角变更说明，标注 breaking change（如有），关联 issue/PR 编号>

## 下一步
<PR/release/deploy 动作 — 待用户明确确认后执行>
```

## Changelog 纪律

- 用户视角，不写实现细节（不写"重构了 X 模块"，写"X 功能响应速度提升 30%"）。
- 排序：新功能 > 修复 > 性能 > 内部改进。
- Breaking change 必须加 `[BREAKING]` 前缀并单独列出。
- 关联 issue/PR 编号（如 `#42`）。

## 版本号规则（SemVer）

| 场景 | 版本号 |
|---|---|
| 有 breaking change | major++ |
| 新功能，无 breaking | minor++ |
| 仅 bugfix / 性能 | patch++ |
| 0.x.y 阶段：breaking | minor++ |
| 0.x.y 阶段：其他 | patch++ |

## 停止条件

- **verify 失败** — 列出具体命令和错误，状态 blocked，转 `tdd` / `diagnose`。
- **review 有 P0/P1** — 状态 blocked，转 `review` 追踪修复。
- **工作区脏（无关文件）** — 报告，不自动处理，等用户决策。
- **落后 main** — 提示先 rebase/merge，状态 blocked。
- **无回滚方案的破坏性发布** — 状态 blocked，要求先写回滚步骤。
