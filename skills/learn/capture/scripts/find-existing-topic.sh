#!/usr/bin/env bash
set -euo pipefail

topic="${1:?topic required}"
root="${2:-docs}"

if [[ ! -d "$root" ]]; then
  exit 0
fi

rg -l --hidden --glob '!.git' --glob '!node_modules' "$topic" "$root" 2>/dev/null || true
