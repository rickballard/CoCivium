# CoCivium Master Plan (v0)

**Source of truth:** this file (CoCache repo). Subordinate plans must link back here.

## Repos & Roles
- **CoCache** — planning, intake, indices, BPOE, CI status (OE/Trust).
- **CoCivium** — product docs & implementation (active).
- **Civium** — deprecated; migrate useful docs then archive.

## Operating Model
1) Intake zips → `scripts/normalize_cardswraps.ps1` → front-matter MD + attachments.
2) Indexes under `/index` (TSV + MD); CI publishes `OE_STATUS.md` and `TRUST_STATUS.md`.
3) Per-session CoWrap summarizes state & decisions.
4) CI validates intake map & file existence.

## Milestones
- M1: Intake pipeline stable (✅).
- M2: CI guards in place (✅ map + status).
- M3: IdeaCards triaged → streams (Product, Infra, BizDev, Ops).
- M4: Civium deprecation plan executed.

## Workstreams (seed)
- **Session Stability** — SessionBloat*, Session Resilience, Silent Fail Diagnostics.
- **Contribution Model** — Contributor Merge Policy, Merge Rights & Reputation.
- **Monetization** — Monetization Optioning (CoCivium).
- **Partnering** — KickOpenAI partnership req & workflow issues.
- **Tooling** — CoParser, PMDS Plan.

## Next Actions
- Create `docs/streams/` folders and link each IdeaCard (add `triage:` and `stream:` fields).
- Keep PR (#19) updated with OE/Trust one-liner and links to indexes.
