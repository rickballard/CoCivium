#!/usr/bin/env bash
set -euo pipefail
echo "Hello from cached task on $(hostname)"
uname -a || ver
echo "Repo at: $(pwd)"
ls -la | head -20
