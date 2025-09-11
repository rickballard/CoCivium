<!-- status: stub; target: 150+ words -->
# Idea Card: Silent Fail Diagnostics & File Visibility Checker

## Summary
During recent CoCivium work, a file placed under `docs/outreach/partners/` appeared to be committed locally but failed to render on GitHub. Multiple rounds of verification failed due to GitHub cache, broken links, or session bloat.

## Problems
- Files show as committed but 404 on GitHub.
- `git add` vs `git mv` vs file rename edge cases caused mismatch.
- No automated check for broken folder links in recent PRs.

## Proposal
1. **GitHub Action: File Presence Validator**
   - On push to any branch, run an action that checks all file paths mentioned in markdown files.
   - Any missing file throws a warning and creates a comment on the PR.

2. **CLI Tool: Local Mirror Checker**
   - PowerShell helper: `Check-GitRenderConsistency.ps1`
   - Verifies `git ls-files` vs `Get-ChildItem` for divergence.

3. **Session Tagging**
   - All uploaded `.odt` files should be tagged with SHA hash of the session dump + branch name.
   - Mark PRs that were attempted during failed file reference as needing audit.

4. **Documentation**
   - Add “File Visibility Debugging” section to BPOE docs.
   - Include common GitHub web cache bugs, rename edge cases, and UTF BOM issues.

## Status
✅ Approved  
🗂 Repo placement: `CoCivium/docs/ideas/diagnostics`

