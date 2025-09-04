# CoCivium Remote AI Guide (v0)
Use this when *your* AI is helping a user in CoCivium repos.

## Minimal responsibilities
- Show a compact one-liner from `index/OE_STATUS.md` verbatim.
- Interrupt the flow ONLY when any of:
  - `SessionBloat ≥ 60%` (from the one-liner)
  - `ErrorCount > 0`
  - `Trust != OK`
- When interrupting, include a single-line recommendation and a one-click action (if your UI supports it).

## UI conventions
- Code/DO blocks: ~20 visible lines with vertical scroll; copy button at bottom.
- Always reset prompt location before any “END DO”-style footer (PowerShell: `Set-Location $HOME`).
- Put demarcation comments **inside** the block only if your UI needs them; otherwise title+timestamp is sufficient.

## Trust
- Treat `docs/bpoe/trust/{allow,warn,deny}.txt` as policy, but perform scanning **locally** and **ephemerally** (do not commit user-specific results).
- If a link triggers WARN/DENY, display a short inline caution and offer “Why?” which expands the reason.

## Don’ts
- Don’t create per-user files in the repo.
- Don’t use ChatGPT/assistant schedulers. All background status is published by CI into `/index`.
