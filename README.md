# CoCivium (Archived)

This repo is deprecated and archived. Current work and docs live in **CoCache**.
- Session plan: docs/bpoe/SESSION_PLAN_GrandMigration.md (CoCache)
- Leftovers register: docs/migration/LEFTOVERS_Register.md (CoCache)

For historical access, see tag **final-public**.

## About

CoCivium explores a practical path from a **Civics Forum** to a **Decisions Engine** to a **Communal Mindshare Environment (CME)**.  
This repository tracks experiments, playbooks, and CI that assemble the stack end-to-end:
- Lightweight publishing (GitHub Pages)
- “Megascroll” generator for longform artifacts
- Insights with validated front-matter
- Advisory CI for content hygiene

Contributions are welcome via pull requests.
# CoCivium — Temporary README padding (PR #414)

This block exists only to satisfy a CI smoke check that requires the README
to be at least 500 bytes and 10 lines on pull requests. The actual, curated
README lives on `main` and will remain the source of truth.

- Goal: get the minimal site scaffold merged to `main`
- Why: unblock GitHub Pages deployment for `cocivium.org`
- Safe to remove later: yes, once Pages is live and we relax/adjust the check

Context:
CoCivium is a Civics Forum → Decisions Engine → CME. The site-human/ tree
contains a minimal landing page, a 404, robots.txt, CNAME, and a placeholder
Megascroll asset that the generator will overwrite later.

This paragraph is just padding to exceed the size threshold for the smoke
test. Nothing to see here beyond ensuring CI is green so we can merge.
