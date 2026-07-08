---
name: init-harness
description: 把仓库初始化成 AI native 项目：铺 harness（AGENTS.md、标准动词、门禁、spec 目录），新仓库和存量仓库同一入口。用于项目初始化、接入 agent 工作约定、迁移旧版 setup 产物。
---

# Init Harness

把仓库初始化成 AI native 项目。新旧项目同一入口，产出相同：槽位齐、动词通、门禁明。

开始前先读同目录 `references/harness.md`（规范）和 `references/templates.md`（模板）。

## 判定路径

仓库近乎空白 → 新项目；已有代码 → 存量改造。

## 新项目

1. 问清技术栈和工具链偏好。
2. 按模板铺 `AGENTS.md` 和 `docs/specs/`（含 spec 模板 `docs/specs/TEMPLATE.md`）；`CLAUDE.md` 只引用 `AGENTS.md`。
3. 门禁写实际命令；工具链尚未搭好的动词，在 `AGENTS.md` 里标注「待补」而不是硬造。
4. 不预创建空的 `CONTEXT.md` / ADR；有真实内容时才建。

## 存量项目

1. **探测**：识别技术栈、已有 test / build / lint 命令、CI 配置、旧约定（`AGENTS.md` / `CLAUDE.md` / cursor rules 等）和旧文档、开发日志。
2. **包装动词**：把已有命令包成标准动词统一入口；只求统一入口，不要求换工具。没有的动词如实缺席。
3. **挖上下文**：从代码结构、git history、旧文档里挖 `CONTEXT.md` 和 ADR 的初稿，**交人确认后再写入**。旧约定融合进新 `AGENTS.md`；有冲突、过时或不确定的内容先问。
4. **评估验证缺口，如实报告**：估计现有测试对行为的回归保护程度，说清「agent 能安全自主的范围是 X，扩大范围需要先补 Y」。这一步不能跳过、不能粉饰——它决定门禁的严格程度。
5. **按缺口定门禁**：覆盖弱则门禁从严、审批点多，随覆盖补齐逐步放权；把「补验证」列为第一批 `proposed` spec 写入 `docs/specs/`。
6. **迁移旧产物**：旧版 `docs/implementation-specs/` 迁到 `docs/specs/`（已完成的直接进 `archive/`，未完成的补 status）。不直接删除旧材料；迁移、归档或替换先得到确认。

## 追问规则

- 先展示发现和建议，再写文件。
- 一次最多问 3 个问题，只问会影响初始化结果的问题。
- 能从仓库现有文件判断的，不要问。

## 完成标准

- `AGENTS.md` 存在且薄，含任务流、门禁（实际命令）、审批点、语言约定。
- `docs/specs/` 与 spec 模板 `docs/specs/TEMPLATE.md` 已就位（新项目和存量项目都要有）。
- 标准动词一条命令可跑通，或如实标注了缺失和补齐计划。
- 存量项目：验证缺口已如实报告；旧约定已融合或明确留待处理。
- 收尾说明：融合了哪些旧内容、转换了哪些上下文、第一批 `proposed` spec 是什么、还有哪些未处理。
