# CoCivium — BPOE & Workflow (Keeper Doc)

This doc is the **single source of truth** for our “Best Path of Execution (BPOE)”, workflow guardrails, and error‑avoidance playbook. Keep it updated whenever the process evolves. New contributors should read this first.

## Golden Rules
- **UTF‑8 (no BOM), LF line endings, final newline.** Enforced locally by `.githooks/pre-commit` and in CI by `.github/workflows/quality.yml`.
- **No mojibake ever.** If you see `Ã`, `Â`, or `�` in diffs/README, stop and run `./scripts/smoke.ps1`.
- **Relative assets only.** Images live under `assets/**`. Keep paths small and stable (e.g., `assets/hero/hero.jpg`).
- **Regenerate, don’t hand‑massage,** when reconstructing README from a canonical source. Use the steps below.

## Standard README Refresh (BPOE)
1. **Edit the canonical source** (e.g., the text the README is derived from).
2. **Render/assemble the README** (no “smart quotes”, no clipboard tools that change encodings).
3. **Place assets** in `assets/**`:
   - `assets/hero/hero.jpg` (hero image)
   - `assets/status/two-eyes.png` (status visual)
4. **Run local guard**:
   ```powershell
   pwsh ./scripts/smoke.ps1 -Path README.md
   ```
5. **Commit** (hooks will re-check):
   ```powershell
   git add README.md assets
   git commit -m "Update README + assets"
   git push
   ```

## Local Guard (pre-commit)
- We version a pre-commit hook in `.githooks/pre-commit` which runs `scripts/smoke.ps1`.
- Ensure your clone uses it:
  ```powershell
  git config core.hooksPath .githooks
  ```

## CI Guard
GitHub Actions re-runs the same smoke checks on every push/PR (`.github/workflows/quality.yml`). Nothing merges with bad encodings or missing assets.

## Common Tasks
- **Add a new image:** put it under `assets/<area>/name.ext`, reference it with a relative path `assets/...` in Markdown/HTML.
- **Recover from mojibake:** prefer `git show <good_commit>:README.md > README.md`, then run the smoke script.
- **Placeholders:** It’s OK to land placeholder assets, but they must exist so the README renders and CI passes.

## Error Playbook (short)
- **Encoding failures:** Re-save as UTF‑8 (no BOM), normalize line endings to LF, and remove any `Ã`, `Â`, or `�` tokens.
- **Missing images:** Ensure the referenced relative path exists; GitHub caches—hard refresh after push.
- **Pre-commit not running:** Set `git config core.hooksPath .githooks`.

Full details live in `docs/ERROR_PLAYBOOK.md`.
