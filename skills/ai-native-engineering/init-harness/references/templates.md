# 模板

`init-harness` 写入目标仓库的文件模板。按仓库实际情况裁剪：填入真实命令、增删审批点，不保留用不上的空栏目。

## AGENTS.md

```md
## 沟通

- 回答简洁直接，优先给结论和下一步。
- 不写无关解释；不确定时说明假设和风险。

## 语言

- 文档（`CONTEXT.md`、ADR、`docs/specs/`）和对话都用中文。
- 技术术语保留英文原词，且全程统一写法：code 标识符（函数 / 类 / 文件 / 变量名）、API / 库 / 工具 / 命令名、文件路径，以及固定架构词（module、interface、seam、adapter、deep module 等）。不要临时编中文译名，也不要在英文和中文译名之间来回切。
- 其余解释性文字用干净中文，不逐词直译英文句式。
- 一个术语认准一种写法用到底；需要中文译名时也只固定一个，不混用。

## 上下文

- 涉及领域概念、系统边界、稳定约定时，先读 `CONTEXT.md`。
- 涉及长期架构取舍时，先读 `docs/adr/`；status 为 `superseded` 的不要再当依据。
- 代码是「现状」的唯一事实源；文档与代码冲突时以代码为准，并修文档。
- 代码注释只引用 `CONTEXT.md` 和 ADR，不引用 `docs/specs/`（一次性产物，归档后引用会失效）。

## 任务流

- 需求含糊 → 先 shape 出 spec；目标明确的小改动可以直接做。
- 按 spec 实现：开工把状态改 `active`；进度、决策变更、摩擦（重试 / 困惑 / 慢测试）随手记进 spec 的 Progress log。
- done = spec 验收标准逐条满足 + 自动门禁全绿，缺一不可；合入前过 review。
- 跨 session 续接只看 spec，不写交接文档。

## 门禁

- 自动门禁（done 的必要条件）：`<test 命令>`、`<lint 命令>`、`<build 命令>`。
- 审批门禁（必须人放行才能执行）：release、数据迁移、删除数据、对外发布。

## 工程约束

- 功能任务改行为，维护任务改结构，不混在一个 diff。
- 优先沿用仓库已有模式，保持改动聚焦，不做无关重构。
- 架构上偏好 deep module：小 interface 后隐藏足够多实现。
- interface 是测试表面；没有真实替换需求时不要引入 seam。
- 修改后运行与风险匹配的验证；无法验证要说明原因。

## 维护

- 大功能合入后，对改动区域跑一次 scoped gc。
- 定期（建议每周）跑一次 global gc：文档对账、摩擦扫描、架构提案。
```

## CLAUDE.md（如需新建，内容只有引用）

```md
@AGENTS.md
```

## Spec 模板（原样写入 docs/specs/TEMPLATE.md）

每份 spec 按此模板建为 `docs/specs/<YYYY-MM-DD>-<slug>.md`；`shape` 成稿时以仓库里的 `TEMPLATE.md` 为准。

```md
---
status: proposed | active | done
created: YYYY-MM-DD
---

# <标题>

## Goal

## Non-goals

## Context

## Decisions

## Plan
<!-- 任务拆分、依赖顺序、需要动的区域 -->

## Acceptance criteria

## Risks

## Progress log
<!-- 实现中随手记：进度、决策变更、摩擦（重试 / 困惑 / 慢测试）。带日期。 -->
```

## ADR（docs/adr/NNN-<slug>.md）

```md
# ADR-NNN: <标题>

- Status: accepted | superseded by ADR-MMM
- Date: YYYY-MM-DD

## Context

## Decision

## Consequences
```
