#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
repo="${1:-.}"
target="$repo/AGENTS.md"
status=""

if [[ -f "$repo/AGENTS.md" ]]; then
  target="$repo/AGENTS.md"
elif [[ -f "$repo/CLAUDE.md" ]]; then
  target="$repo/CLAUDE.md"
else
  cp "$skill_dir/templates/AGENTS.md" "$target"
  status="CREATE"
fi

ref_file="$skill_dir/templates/skills-reference.md"

if grep -q '^## Agent skills$' "$target"; then
  tmp="$(mktemp)"
  awk -v ref="$ref_file" '
    BEGIN {
      while ((getline line < ref) > 0) repl = repl line "\n"
      close(ref)
      in_section = 0
    }
    /^## Agent skills$/ {
      printf "%s", repl
      in_section = 1
      next
    }
    /^## / && in_section {
      in_section = 0
    }
    !in_section { print }
  ' "$target" > "$tmp"
  mv "$tmp" "$target"
  [[ -z "$status" ]] && status="REPLACE"
else
  printf '\n' >> "$target"
  cat "$ref_file" >> "$target"
  [[ -z "$status" ]] && status="APPEND"
fi

echo "$status $target"
