# Migration Plan — Session Resume (2025‑08‑14)

**Generated:** 2025-08-14 22:25 UTC  
**Repo:** `rickballard/CoCivium`  
**Default branch:** `main`  
**Baseline tag:** `baseline-20250814_1817` (older `baseline-20250814_1745` deleted)  
**Key PR:** **#90** _“Seed growth pack v0”_ — **merged** on 2025‑08‑14T21:06:44Z

---

## DO‑A — Completed in this session

- **CI configs tamed + dispatchable**
  - `markdownlint` — advisory (`continue-on-error: true`), `workflow_dispatch` enabled. Uses repo-level `.markdownlint.yml` + `.markdownlintignore`.
  - `codespell` — advisory + dispatchable. Uses `docs/lexicon/codespell-ignore.txt` and skips legacy/noisy paths.
  - `linkcheck` (Lychee) — advisory + dispatchable. Repo `.lychee.toml` with excludes and tolerant status codes (`200, 204, 301, 302, 403, 429`).
  - `yamllint` — **added** with repo `.yamllint.yaml`, advisory + dispatchable.
- **Domain lexicon** — `docs/lexicon/codespell-ignore.txt` seeded with: `CoCivium, Civium, Noname, Cognocarta, Consenti, CoCivSecOps, ODT, OG`.
- **Line endings normalized** — `.gitattributes` committed:
  ```gitattributes
  *       text=auto
  *.md    text eol=lf
  *.yml   text eol=lf
  *.yaml  text eol=lf
  *.py    text eol=lf
  *.ps1   text eol=crlf
  ```
- **Branch/PR housekeeping**
  - Feature branch `feat/seed-growth-pack-v0-20250814` merged via PR **#90** and then deleted locally & on remote.
  - Repo subscription verified (“watching”: `subscribed: true`).
- **Baseline tags**
  - Created: `baseline-20250814_1817` (kept).
  - Removed: `baseline-20250814_1745` (redundant on same commit).
- **Tracking issues opened**
  - **#94** *Grand migration: plan & execute* — label: `migration`.
  - **#95** *CI hardening: remove advisory, enforce failures* — label: `ci`.
  - **#96** *Lychee tuning after migration* — label: `ci`.
  - **#97** *Add desktop project repos to watch/automation* — label: `ops`.

---

## DO‑B — Current state (fast glance)

- `main` is up‑to‑date with `origin/main`.
- CI workflows exist for: **markdownlint**, **codespell**, **linkcheck**, **yamllint**.  
  All are **advisory** for now and **manually dispatchable**.
- Repo labels present: `migration`, `ci`, `ops` (plus any existing).

---

## DO‑C — Open follow‑ups (shortlist)

- [ ] **#94** Finalize repo list for grand migration (what moves, what archives, what stays).  
      Produce runbook: **dry‑run → cutover → verification → comms**.
- [ ] **#96** Tune Lychee: trim excludes, lower noise, then **re‑enable failure**.
- [ ] **#95** Flip **markdownlint/codespell/yamllint/linkcheck** back to **blocking** after tidy.
- [ ] **#97** Expand watch/automation to desktop project repos.  
      Bootstrap minimal CI, labels, and (optional) `CODEOWNERS`.

---

## DO‑D — Ready‑to‑run commands (reference)

### Dispatch CI on `main`
```bash
gh workflow run ".github/workflows/markdownlint.yml" -r main
gh workflow run ".github/workflows/codespell.yml"     -r main
gh workflow run ".github/workflows/linkcheck.yml"     -r main
gh workflow run ".github/workflows/yamllint.yml"      -r main
```

### Quick CI pulse for recent runs on `main`
```bash
gh run list --branch main --limit 10
```

### Verify watching/subscription
```bash
gh api repos/rickballard/CoCivium/subscription --jq "{subscribed,ignored}"
```

### Rollback (if ever needed)
```bash
# Inspect the saved baseline
git show --no-patch baseline-20250814_1817

# Reset local working tree to baseline (hard reset – destructive to local changes)
git reset --hard baseline-20250814_1817
```

---

## Notes / Rationale

- **Advisory CI**: kept temporary to avoid blocking during high‑churn migration; each workflow can be flipped to blocking by removing `continue-on-error: true` when stability returns.
- **`.gitattributes`** ensures LF in repo for source/markdown while keeping PowerShell scripts CRLF for Windows convenience.
- **Lychee config** temp‑excludes legacy/noisy trees and tolerates rate‑limits/403s to keep linkcheck signal usable during reorg.

---

## Parking Lot (nice‑to‑have after cutover)

- Add `CODEOWNERS` for critical directories (optional).
- Add per‑repo CI “smoke tests” (e.g., YAML validation across `/notes`, Markdown link anchor check on docs).
- Create a simple **migration dashboard** issue comment that auto‑updates via workflow (optional).

---

*End of session resume.*