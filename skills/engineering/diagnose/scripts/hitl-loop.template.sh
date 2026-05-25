#!/usr/bin/env bash
# 人参与的复现循环。
# 复制本文件，编辑下方步骤，然后运行。
# agent 运行脚本；用户按终端提示操作。
#
# Usage:
#   bash hitl-loop.template.sh
#
# 两个 helper：
#   step "<instruction>"          → 显示操作说明，等待回车
#   capture VAR "<question>"      → 显示问题，把回答读入 VAR
#
# 结尾会以 KEY=VALUE 打印捕获值，供 agent 解析。

set -euo pipefail

step() {
  printf '\n>>> %s\n' "$1"
  read -r -p "    [Enter when done] " _
}

capture() {
  local var="$1" question="$2" answer
  printf '\n>>> %s\n' "$question"
  read -r -p "    > " answer
  printf -v "$var" '%s' "$answer"
}

# --- edit below ---------------------------------------------------------

step "打开 http://localhost:3000 并登录。"

capture ERRORED "点击 'Export' 按钮。是否报错？(y/n)"

capture ERROR_MSG "粘贴错误信息；没有则填 'none'："

# --- edit above ---------------------------------------------------------

printf '\n--- Captured ---\n'
printf 'ERRORED=%s\n' "$ERRORED"
printf 'ERROR_MSG=%s\n' "$ERROR_MSG"
