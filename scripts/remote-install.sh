#!/usr/bin/env bash
# 远程一行装：不用 git clone，直接从 GitHub 拉 tarball、解压、跑 install.sh
#
# 用法：
#   curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | bash
#   curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | TO=codex bash
#   curl -fsSL https://raw.githubusercontent.com/initxy/initxy-skills/main/scripts/remote-install.sh | BUNDLE=engineering PROJECT=1 bash
#
# 环境变量（可选）：
#   REPO=initxy/initxy-skills   覆盖仓库（用于 fork）
#   REF=main                    分支/tag/commit，可锁版本
#   TO=claude|codex             安装目标，默认 claude
#   BUNDLE=engineering|productivity|writing|all  安装范围，默认 all
#   PROJECT=1                   安装到当前项目的 ./.<agent>/skills/
#   KEEP_TMP=1                  不清理临时目录（调试用）

set -euo pipefail

REPO="${REPO:-initxy/initxy-skills}"
REF="${REF:-main}"

need() {
  command -v "$1" >/dev/null 2>&1 || { echo "需要先安装 $1" >&2; exit 1; }
}
need curl
need tar
need jq

tmp="$(mktemp -d -t initxy-skills.XXXXXX)"
if [[ -z "${KEEP_TMP:-}" ]]; then
  trap 'rm -rf "$tmp"' EXIT
else
  echo "KEEP_TMP=1 设置；临时目录保留：$tmp" >&2
fi

tarball="https://codeload.github.com/${REPO}/tar.gz/${REF}"
echo "下载 ${REPO}@${REF} ..."
if ! curl -fsSL "$tarball" | tar -xz -C "$tmp"; then
  echo "下载或解压失败：$tarball" >&2
  exit 1
fi

root="$(find "$tmp" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
if [[ -z "$root" || ! -f "$root/scripts/install.sh" ]]; then
  echo "解压后找不到 scripts/install.sh，仓库结构异常" >&2
  exit 1
fi

bash "$root/scripts/install.sh" "$@"
