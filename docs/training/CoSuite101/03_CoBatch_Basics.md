# 03 — CoBatch Basics

- Manifest: `scripts/batch.manifest.json` has `tasks[]` with `name, script, args, cwd, timeout, mutex, needs, env`.
- Quiet rules:
  - No bare `$running` or table formatting to the success stream.
  - Any `$running +=` must be wrapped in `$null = (...)`.
  - `foreach` that could yield should be assigned (`$null = foreach (...) { ... }`).
- Violet receipt:
  - We clamp width to ~68 `=` and print exactly 3 lines.
  - Always ensure `if (-not $compact) { $compact = "# CoPONG: (no summary produced)" }` before printing.
