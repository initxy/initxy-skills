#!/usr/bin/env bash
set -euo pipefail

bundle="${BUNDLE:-all}"
to="${TO:-claude}"
scope="${SCOPE:-user}"

if [[ "${PROJECT:-}" == "1" || "${PROJECT:-}" == "true" ]]; then
  scope="project"
fi

usage() {
  cat <<'EOF'
用法:
  scripts/install.sh [--to claude|codex] [--project] [--bundle <name>]

环境变量:
  TO=codex BUNDLE=engineering PROJECT=1 scripts/install.sh

Flags:
  --to        目标 agent：claude 或 codex                （默认 claude）
  --project   装到当前项目（./.<agent>/skills/），不带则装到用户目录
  --bundle    要装的 bundle，见 manifests/bundles.json   （默认 all）

可用 bundle：engineering / productivity / writing / all

Examples:
  scripts/install.sh                          # 全量装到 ~/.claude/skills/
  scripts/install.sh --to codex               # 全量装到 ~/.codex/skills/
  scripts/install.sh --to claude --project    # 全量装到 ./.claude/skills/
  scripts/install.sh --bundle engineering     # 只装工程类 skill 到 ~/.claude/skills/
  scripts/install.sh --to codex --bundle productivity --project
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --bundle)
      bundle="${2:-}"
      shift 2
      ;;
    --to)
      to="${2:-}"
      shift 2
      ;;
    --project)
      scope="project"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "未知参数: $1" >&2
      echo >&2
      usage >&2
      exit 1
      ;;
  esac
done

case "$to" in
  claude|codex) ;;
  *)
    echo "未知 --to: ${to}（仅支持 claude 或 codex）" >&2
    exit 1
    ;;
esac

case "$scope" in
  user) dest="$HOME/.$to/skills" ;;
  project) dest="$PWD/.$to/skills" ;;
esac

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
manifest="$root/manifests/bundles.json"

if ! command -v jq >/dev/null 2>&1; then
  echo "需要先安装 jq（macOS: brew install jq）" >&2
  exit 1
fi

skills_raw="$(jq -r --arg b "$bundle" '.[$b][]?' "$manifest")"
if [[ -z "$skills_raw" ]]; then
  echo "未知或空 bundle: $bundle" >&2
  exit 1
fi

mkdir -p "$dest"

while IFS= read -r path; do
  [[ -z "$path" ]] && continue
  src="$root/skills/$path"
  name="$(basename "$path")"
  if [[ ! -d "$src" ]]; then
    echo "缺少 skill: $path" >&2
    exit 1
  fi
  rm -rf "$dest/$name"
  cp -R "$src" "$dest/$name"
  echo "已安装 $name -> $dest/$name"
done <<< "$skills_raw"

echo "完成: --to=$to scope=$scope bundle=$bundle dest=$dest"
