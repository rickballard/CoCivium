# Preauthorization (v0)
**Green-lit for admin merge (no review):**
1. Additive **missing-only** imports from Civium (no overwrites).
2. **Cache-busting** README image query params (?v=<short-sha>).
3. **Hero/brand asset swaps** ≤ 100KB diff total; filename stable; README updated if referenced there.
4. **Docs-only edits** (typos, TOC, link fixes, relative path repairs).
5. **CI hygiene**: disable/adjust noisy labelers/yamllint in a way that doesn’t block main; add repo metadata/badges.
6. **Issue/Project admin**: labels, milestones, boards, tracking docs in CoCache.

**Requires your explicit review:**
- Licensing, trademark/registration, governance changes.
- Repo renames, default-branch changes, force-push, history rewrites.
- New dependencies/toolchains; publishing a site (Pages) or package.
- Brand system changes (color/typography/logo), external comms/PR.

**Guardrails:**
- Always link PR to the relevant item in DIVERSION_LOG.md or ROADMAP.
- PR body includes **“Verification steps”** and **“Roll-back”**.
- Use --admin only within green-lit categories above.
