#!/usr/bin/env bash
set -euo pipefail

bundle="all"
target="codex-user"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --bundle)
      bundle="${2:-}"
      shift 2
      ;;
    --target)
      target="${2:-}"
      shift 2
      ;;
    -h|--help)
      cat <<'EOF'
Usage:
  scripts/install.sh [--bundle control|triage|define|design|build|ship|learn|all] [--target codex-user|claude-user|codex-project|claude-project]

Defaults:
  --bundle all
  --target codex-user

Examples:
  scripts/install.sh --bundle all --target claude-user
  scripts/install.sh --bundle ship --target claude-project
EOF
      exit 0
      ;;
    *)
    echo "未知参数: $1" >&2
      exit 1
      ;;
  esac
done

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="$root/manifests/bundles.json"

case "$target" in
  codex-user) dest="$HOME/.codex/skills" ;;
  claude-user) dest="$HOME/.claude/skills" ;;
  codex-project) dest="$PWD/.codex/skills" ;;
  claude-project) dest="$PWD/.claude/skills" ;;
  *)
    echo "未知 target: $target" >&2
    exit 1
    ;;
esac

if ! command -v jq >/dev/null 2>&1; then
  echo "需要先安装 jq" >&2
  exit 1
fi

skills="$(jq -r --arg b "$bundle" '.[$b][]?' "$manifest")"
if [[ -z "$skills" ]]; then
  echo "未知或空 bundle: $bundle" >&2
  exit 1
fi

mkdir -p "$dest"

for skill in $skills; do
  src="$root/$skill"
  if [[ ! -d "$src" ]]; then
    echo "缺少 skill: $skill" >&2
    exit 1
  fi
  rm -rf "$dest/$skill"
  cp -R "$src" "$dest/$skill"
  echo "已安装 $skill -> $dest/$skill"
done

echo "完成: bundle=$bundle target=$target dest=$dest"
