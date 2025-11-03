# RepoAccelerator / CoAgent Kit  -  Backlog: Workflow Stability and DX

Last updated: 2025-08-26 04:57 UTC

DX guardrails (must-haves)
- Avoid here-strings in instructions. No @' or @" or triple backticks in paste blocks. Users paste whole blocks and PS7 enters the >> continuation prompt.
- Never include shell prompts in code blocks. If users paste lines with [ or ] they get parse errors.
- Prefer one-liner file writes: [IO.File]::WriteAllBytes($path,[Convert]::FromBase64String($b64)).
- Always preflight before any git operation: abort rebase or merge and fetch origin.
- Enforce LF-only in .gitattributes for .md and .ps1.
- Manage README quick-nav via <!-- QUICK-NAV:BEGIN ... END --> markers; replace not duplicate.

Stall or failure UX
- Treat PS7 >> as failure. Show STOP banner: press Ctrl+C, then use bootstrap one-liner.
- When PowerShell prints red parse errors, stop and switch to the bootstrap flow.
- Provide a single recovery macro to clear rebase or merge debris and fetch origin.
- Scripts must echo status banners with check or cross and the next step.

Branching and PR hygiene
- Branch name: docs/repo-map-workflows-YYMMDD-HHMMZ.
- Keep linear history. Relax briefly only to unblock, then tighten again.
- Keep PR scope small. Example: README quick link separate from other changes.
- Auto-create PR with body that explains quick-nav, diagrams as placeholders, and how to recover if PS shows red.

Docs generation (safe mode)
- Use Mermaid as placeholders only. Keep real links in nearby markdown.
- Maintain these files: docs/REPO-MAP.md, docs/WORKFLOWS.md, docs/ideas/INDEX.md.
- Pointers not duplicates. Canonical modules live in CoModules; CoCivium™ holds pointer cards.

Bootstrap pattern (paste once, safe)
- Write any file from Base64 with WriteAllBytes and then normalize to LF with Set-Content.

Measurement (lightweight)
- Log start or stop banners and final outcome code.
- Count recoveries (number of Ctrl+C guidance events).
- Add a short what changed section in PR body.

Next actions (automatable)
- Publish tools/safe-bootstrap.ps1 that preflights, writes quick-nav and docs, commits, and opens PR with recovery instructions.
- Add CI check: README must contain QUICK-NAV block.
- Pre-commit hook to forbid here-strings in instruction snippets.
- Helper to rebase a docs branch automatically or hard-reset then reapply a tiny patch.


