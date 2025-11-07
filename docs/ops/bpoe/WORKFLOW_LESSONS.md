## 20251107T162925Z — PR tension table automation
- Added **tools/Format-Tension.ps1** (tension.json → Markdown table).
- Workflow now **renders & comments** tension on PRs (post-artifact step) with **permissions:** contents:read, pull-requests:write.
- Escaping for \${{ }}\ handled via placeholder+swap; inserted safely after anchor step.
- Captured **branch-protection 404** + **gh api no -R** in frictions.
## 20251107T155409Z — CoHarmony v5.x CI hardening (authz & UX)
- Snapshotted **Actions perms**, **branch protection**, **recent runs** (for Co1 mining).
- Documented **authz model** + **frictions** (PR labeler, PR comments, PS -replace, linkcheck).
- Reinforced artifact-only PR discipline; badge guidance.
- Next: composite action for PR tension table; DOI allow-list.
## 20251107T152945Z — CoHarmony v5.x CI hardening

- **PR trail:** #516 (quality & signals), #517 (v5.1 hardening).
- **Labeler config:** added .github/pr-labeler.yml to satisfy **PR labeler** check.
- **Linkcheck hardening:** switched to HEAD → GET fallback, accept **2xx/3xx**, set UA, tolerant timeouts.
- **CI comment perms:** added workflow permissions: pull-requests: write for PR comments.
- **Posting JSON artifacts:** added “Post tension summary” step; echo JSON into gh pr comment.
- **PowerShell replace pitfall:** -replace chokes when replacement includes ${{ … }}; use a **placeholder → swap** or a **MatchEvaluator** (see Recipes).
- **Badges:** added Quality badge to MEGASCROLL header for at-a-glance CI.
- **PR checks cadence:** ok to merge when required checks are green and advisories pass tolerances.

**Next:** consolidate comment-poster as reusable script, consider allow-list for bot-blocked DOI hosts, promote “tension” JSON to a small PR summary table.
# BPOE — Workflow Lessons (Cumulative)

Source of truth for CI/BPOE learnings. Append newest entries at the top.




