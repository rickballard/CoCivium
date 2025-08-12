#!/usr/bin/env bash
set -euo pipefail
TASK="${1:-}"; shift || true
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/../.. && pwd)"
TASK_SCRIPT="$ROOT/scripts/tasks/${TASK}.sh"
[[ -n "${TASK:-}" ]] || { echo "Usage: bash scripts/issueops/run-task.sh <task> [args...]"; ls "$ROOT/scripts/tasks"/*.sh 2>/dev/null | sed 's#.*/##;s#\.sh$##' || true; exit 64; }
[[ -f "$TASK_SCRIPT" ]] || { echo "Unknown task: $TASK"; exit 64; }
exec bash "$TASK_SCRIPT" "$@"
