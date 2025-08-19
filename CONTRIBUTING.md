# Contributing to CoCivium

Welcome! This project enforces a few guardrails so our README and assets never break.

## Quick Setup
```powershell
git clone https://github.com/<owner>/CoCivium.git
cd CoCivium
git config core.hooksPath .githooks   # enable versioned hooks
pwsh ./scripts/smoke.ps1 -Path README.md
```

## Commit Rules
- UTF‑8 (no BOM), LF line endings, final newline.
- No mojibake tokens (`Ã`, `Â`, `�`) in diffs.
- Image paths must resolve locally under `assets/**`.

## Before You Push
```powershell
pwsh ./scripts/smoke.ps1 -Path README.md
```

## Where to Start
- Read `WORKFLOW.md` for the BPOE overview.
- See `docs/ERROR_PLAYBOOK.md` for troubleshooting.
