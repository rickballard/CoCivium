
## MegaWave-specific frictions (added)
- **Chat garbling of `${{ }}` / here-strings:** Prefer repo files; avoid pasting templated YAML into consoles.
- **Authority ambiguity for PR comments:** Require `permissions: pull-requests: write` at top-level or job-level.
- **`gh api` flags confusion:** `gh api` does **not** accept `-R`; include `repos/$Repo/...` or set `GH_REPO`.
- **Branch protection visibility:** 404 on `branches/main/protection` can mean “not configured”; snapshot but don’t fail.
- **Composite vs inline:** Inline YAML steps drift; use `.github/actions/*` composites for reuse.
