---
name: ship
description: 检查当前改动、运行验证、提交 commit、push，并在仓库有明确发布流程时执行 publish。Use when 用户说 ship、发布、提交并推送、commit and push、检查后发版；不要用于未完成实现、失败测试、或需要先设计方案的任务。
---

# Ship

把已经完成的工作送出去：检查 -> 验证 -> commit -> push -> publish。

## 原则

- 先看 `git status` 和 diff，只提交本次相关改动。
- 不回滚用户已有改动；不确定归属时先说明并避开。
- 先跑仓库已有验证：lint、test、typecheck、build，按 package scripts 或 README 判断。
- 验证失败就停止，不 commit、不 push。
- commit message 简短具体。
- push 当前分支。没有 upstream 时设置 upstream。
- 只有仓库有明确 publish 命令、release 脚本或用户要求发布时，才 publish。
- publish 前必须确认当前分支、版本、目标 registry / channel 没有明显风险。

## 流程

1. 检查仓库状态：
   - 当前分支。
   - staged / unstaged / untracked。
   - 本次相关 diff。

2. 找验证命令：
   - 优先使用 README、package scripts、Makefile、CI 配置里的命令。
   - 不知道时用最保守的可发现命令。

3. 运行验证：
   - lint / typecheck / test / build，按仓库惯例选择。
   - 失败则报告失败点并停止。

4. stage 相关文件：
   - 只 stage 本次相关文件。
   - 不 stage 密钥、临时文件、无关生成物。

5. commit：
   - 如无 staged diff，说明无需 commit。
   - message 用动词短句，例如 `Add ship skill`。

6. push：
   - 推送当前分支。
   - 如无 upstream，使用 `git push -u origin <branch>`。

7. publish：
   - 只有发现明确发布入口时执行，例如 `npm publish`、`pnpm publish`、`make publish`、`scripts/publish*`、release workflow。
   - 若 publish 会影响公开包、生产环境或不可逆目标，先向用户确认。
   - publish 后报告产物、版本、目标和链接。

## 收尾

报告：

- 验证命令及结果。
- commit hash。
- push 目标。
- 是否 publish；如果没有 publish，说明原因。
