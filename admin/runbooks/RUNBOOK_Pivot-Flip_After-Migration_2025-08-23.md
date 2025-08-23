# RUNBOOK — Pivot Flip After Migration (v0.1, Internal / Do Not Link)

Purpose: Exact steps to pivot after the Grand Migration exit checklist is green (Issue #149).
Outcomes:
1) New CoModules repo created and seeded (Apache-2.0).
2) CoCivium converted to umbrella/landing + archive (minimal README).
3) Optional repos prepared: GIBindex, CoCache.
4) Backups mirrored to CoCiviumBackup.

---
Preconditions (Gate-0)
- [ ] Issue #149 “Grand Migration — Exit Checklist” ✅
- [ ] PR #148 (advisory) merged or left open as reference (ok either way).
- [ ] CI/Pages green on CoCivium; root README archived under docs/archive/ (per advisory).

---
Step 1 — Create the clean pivot repo (CoModules)
Why: Keep live modules separate; preserve CoCivium for brand/provenance.

Commands (run locally with GitHub CLI):
- gh repo create rickballard/CoModules --public --disable-wiki --confirm
- git clone https://github.com/rickballard/CoModules.git
- cd CoModules

Seed structure (minimum):
- LICENSE (Apache-2.0)
- README.md (short: standards-anchored, evidence-first)
- .github/CODEOWNERS
- .github/pull_request_template.md
- docs/cbpp/modules/{emergency_guardrails,open_gov_transparency}/
- docs/cbpp/{crosswalks,tests,evidence}/
- docs/_internal/ (temporary staging; do not link)
Copy from CoCivium (branch: pivot/protoplan-internal):
- CC_Core_Principles_DRAFT.md
- Evidence_Table_Template.md
- Conformance_Checklist_template.yml
- Crosswalk_template.yml

Repo settings:
- Protect main: require PR review; dismiss stale approvals on push.
- Labels: migration, housekeeping, no-polish, pre-pivot.
- Actions enabled.

---
Step 2 — Freeze CoCivium to umbrella/landing
Branch: readme/pivot-landing (from origin/main)

Changes:
- Replace root README.md with short landing:
  - “Less manifesto, more conformance and proof.”
  - Big link to CoModules.
  - Pointer to docs/archive/ for pre-pivot materials.
- Keep admin/advisories/.
- Do not link to any _internal/ paths.

PR: Draft — docs(readme): pivot landing → CoModules

---
Step 3 — Mirrors (disaster recovery)
In BOTH repos (CoCivium & CoModules) add .github/workflows/mirror.yml:

name: Mirror to Backup
on:
  push:
    branches: ["**"]
jobs:
  mirror:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - name: Push mirror
        run: |
          git remote add backup https://github.com/rickballard/CoCiviumBackup.git || true
          git push --mirror backup
---
Step 4 — Optional repos (create only when needed)
- GIBindex: public vocabulary & symbol sets; docs CC BY 4.0; code Apache-2.0.
- CoCache: public ETL/normalizers/adapters; Apache-2.0.
Create only when a module/validator imports them.

---
Step 5 — Public messaging (copy)
- Umbrella (CoCivium): “Crowd power, expert discipline. We funnel community input into testable, standards-anchored civic modules.”
- CoModules: “Open-source governance modules with pass/fail validators and public evidence—AI-assisted, human-approved.”
- InSeed (services): “Delivery, assurance, and hosted validators with SLAs and attestations.”

---
Step 6 — Promotion rules (from _internal to public)
A clause enters the CoConstitution Showcase only when:
- Matching module has passing validators in CI, and
- Evidence Table is filled with public links.
Then:
1) Move _internal files into public module paths,
2) Update Showcase links,
3) Announce in release notes.

---
Step 7 — Rollback plan
If CoModules seeding fails or CI breaks:
- Revert CoCivium README PR; keep CoCivium as is.
- Keep CoModules private until CI passes.
- No public announcement until Step 6 is satisfied.

---
Owners
- CODEOWNERS: @rickballard (required review on all PRs).
- Services & assurance: InSeed.com (commercial ToS/SLA separate from code licenses).

End runbook.
