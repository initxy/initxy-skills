#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"

rg -n --hidden --glob '!node_modules' --glob '!.git' \
  '\[DEBUG-[A-Za-z0-9_-]+\]|console\.log|debugger;|print\(|println\(|fmt\.Print' \
  "$root" || true
