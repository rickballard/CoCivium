# Workflow Norms (v0)
**Branches:**  
- mig/* migration; ix/* quick surgical fixes; rand/* brand assets; docs/* docs only; ops/* ops/meta.

**Commits/PRs:**  
- Conventional subject, ≤72 chars; body with context + verification steps.  
- Cache-bust images in README when pixels change: append ?v=<short-sha>.

**Camo/GitHub caching:**  
- If new pixels don’t show: bump ?v= to latest origin/main short SHA; hard refresh.

**‘No commits between’ PR error:**  
- Check diff first: git -C <repo> diff --name-status origin/main..HEAD  
  - If empty: your branch equals main (nothing staged) or files matched .gitignore. Stage intended files or adjust ignore.  
- Confirm branch ahead: git -C <repo> log --oneline origin/main..HEAD

**Admin bypass:**  
- Allowed within Preauth. If GH settings just changed, wait a beat then retry merge if necessary.

**Link hygiene:**  
- Prefer relative links inside CoCivium; replace stale ickballard/Civium links with ickballard/CoCivium or relative paths.
