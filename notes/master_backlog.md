# CoCivium — Master Backlog & Operating Plan
_Date: 2025-08-14 • Owner: @rickballard • Source of truth for work planning_

This backlog replaces scattered TODOs/notes as we converge. New work should be added here (and linked to issues/PRs).

---

## 0) How to use this file
- Treat this as the **single backlog**. When we pull tasks from older TODOs, **delete or link back** here.
- Every line item should become a **GitHub issue** (labels: `content`, `refactor`, `funding`, `product`, `domain`, `wiki`, `ci`, `ops`).
- **Cadence:** weekly review → update priorities → close won’t-do items quickly.

---

## P0 — Now (next 7–14 days)
- [ ] **Merge PRs**: #69 (Consenti c2 uplift), #67 (structure & hygiene) after a quick read-through on mobile/desktop.
- [ ] **Enable GitHub Wiki** and publish: Home, Getting Started, Decision Flow, Roles, Domains (index), FAQ, Links.
- [ ] **Vision page polish** (`docs/vision/CoCivium_Vision.md`): add 1-page overview (“Why now / How it works / What’s different”) + embed a simple flow diagram.
- [ ] **Consenti landing polish** (`scroll/Cognocarta_Consenti.md`): add mermaid decision diagram + “Adopt this charter” snippet.
- [ ] **Create `docs/sources/`** with `annotated-bibliography.md` (seed 10 credible references) and `comparable-initiatives.md`.
- [ ] **Domains: draft first 3 briefs** (`domains/finance.md`, `domains/identity_privacy.md`, `domains/public_records.md`) with “practices / risks / experiments / measures”.
- [ ] **Open Collective setup** (see `docs/funding/OPEN_COLLECTIVE.md`): choose fiscal host, create **cocivium**, test $1 donation.  
      _When live_: switch `.github/FUNDING.yml` → `open_collective: cocivium`, remove temporary DogsnHomes callouts/badge.
- [ ] **Monthly transparency note scaffold**: create `notes/finances/2025-08.md` (inflow / outflow / cash on hand).
- [ ] **Stub hygiene**: run `scripts/stubscan.ps1` → bring any canonical doc < 500 bytes to minimum content (≥4 concrete ideas or 150–300 words).
- [ ] **README mobile pass**: ensure CTA image + Consenti blurb read well on small screens; add one-sentence value prop.

---

## P1 — Next (this month)

### Narrative & UX
- [ ] Add a clean **OG image** and small section icons (consistent, subtle).
- [ ] **Slides/one-pager** in `docs/` for Vision + Consenti highlights (exportable to PDF).

### Domains (more briefs)
- [ ] Social safety, health, taxation & redistribution, wealth inequality, education/credentials, civic tech.
- [ ] For each brief: context → harms/risks → practices worth copying → experiments → citations.

### Products (revenue-adjacent pilots)
- [ ] **Decision Log** (plain-file → static viewer) MVP — proposals, objections, decisions, obligations, review dates.
- [ ] **Consent Clinic** (advisory pilot): fixed-fee, 3-hour “governance tune-up”; checklist + template deliverable.
- [ ] **Templates Pack**: reusable markdown templates (proposal, decision record, role charter, review meeting).
- [ ] **Workshops** (2–3 hrs): “Consent before coercion” for teams; recording + slides.
- [ ] **Annual field report** (pay-what-you-want PDF): “What worked in consentful governance this year”.

### Funding & Ops
- [ ] Publish **Funding & Gifts** policy from README; set up OC tiers (supporter, steward sponsor, project grant).
- [ ] Start monthly finance notes and reconcile to OC ledger.

### CI & Quality
- [ ] Add **markdownlint** Action (house style).
- [ ] Add **spell-check** with custom lexicon.
- [ ] Tune **Lychee** timeouts/accept list if it reports noisy false positives.

---

## P2 — Later (nice, not urgent)
- [ ] Interactive **Decision Flow** page (mermaid → lightweight site) with copy-paste snippets.
- [ ] **Case studies**: 2–3 short stories showing consent-first decision making.
- [ ] **Translations** scaffolding (start with i18n plan in `docs/i18n/`).

---

## Wiki Backlog (initial pages)
- [ ] **Home**: what CoCivium is; link to Vision + Consenti; 5-step “how to contribute”.
- [ ] **Getting Started**: repo layout; “promote → canonicalize → delete draft” pipeline.
- [ ] **Decision Flow**: consent, when to vote, objection standard, timers/defaults.
- [ ] **Roles**: Contributor • Steward • Resolver • Auditor (time-boxed, recallable).
- [ ] **Domains Index**: map of briefs with TL;DR lines.
- [ ] **FAQ**: skeptics’ questions; practical answers.
- [ ] **Links**: sources, comparable initiatives (neutral, cited).

---

## Consenti (deepening)
- [ ] Add **review cadence** (e.g., quarterly rule reviews with changelog).
- [ ] “**Adopt this Charter**” block projects can paste (with provenance).
- [ ] **Remedy ladder** details: clarify → boundary → pilot → escalate → external mediation.

---

## Vision (deepening)
- [ ] **Why now**: failures of command-and-control; coordination costs; open tooling.
- [ ] **Federation over centralization**: brief contrast.
- [ ] **From internet to real-world**: friendly vs unfriendly jurisdictions; portable records; conservative compliance.

---

## Domains — pipeline (living map)
- [ ] **Finance & budgeting**: open ledgers, ring-fenced grants, budget caps, audit trails, role separation.
- [ ] **Identity & privacy**: portable claims, minimal disclosure, safety defaults, consent logging.
- [ ] **Public records & oversight**: reviewability, traceability, hashable artifacts, time-boxed stewards.
- [ ] **Social safety**: dignity-first aid, consentful outreach, minimizing stigma.
- [ ] **Health**: privacy & triage fairness; evidence standards; proportional remedies.
- [ ] **Tax & redistribution**: equity lenses, proportionality, governance of funds.
- [ ] **Wealth inequality**: structural drivers and mitigations.
- [ ] **Education & credentials**: verifiable stewardship, open ladders, mentoring.

Each brief ends with: **Experiments we’ll run** + **How we’ll measure**.

---

## External sources & citations
- [ ] `docs/sources/annotated-bibliography.md` — 10+ references (governance, co-ops, DAOs, civic tech, public admin) with 1–2 line annotations.
- [ ] `docs/sources/comparable-initiatives.md` — adjacent projects; lessons to copy (not marketing).
- [ ] Add short quotes sparingly; prefer paraphrase + link.

---

## Editorial & Design
- [ ] Add tasteful **section icons/banners**; consistent style.
- [ ] **Figure captions** and alt-text for accessibility.
- [ ] Standardize **frontmatter** across canon (source, original_path, version/date, supersedes).

---

## Engineering & CI
- [ ] `markdownlint` + `codespell` Actions; custom dictionary in `docs/lexicon/`.
- [ ] Keep Lychee pragmatic and exclude `legacy/**`, `staging/_imported/**`.
- [ ] Optional: tiny script to **rebuild section indexes** from file headers.

---

## Funding & Finance
- [ ] OC: choose host (Foundation vs OSC) and go live (`cocivium` slug).
- [ ] Switch Sponsor button to OC; remove DogsnHomes temporary notes and badge.
- [ ] Start monthly finance notes (`notes/finances/YYYY-MM.md`).
- [ ] Keep **Gift Policy** linked from README → `docs/FUNDING.md`.

---

## Migration & Cleanup
- [ ] Keep triaging `staging/_imported` via `notes/migration_status.md` buckets.
- [ ] Promote relevant drafts; list `supersedes` in frontmatter; delete drafts.
- [ ] Avoid empty folders; every folder has a short README (except `/legacy`).

---

## Artistic work safeguards
- [ ] Verify CODEOWNERS protects **Being Noname** and other story/poem content.
- [ ] Add rubric for artistic edits (voice/cadence/where AI stops).

---

## Cross-repo consolidation (Civium / CoCache / GIBindex)
- [ ] `notes/cross-repo-index.md`: what to migrate vs archive.
- [ ] Open issues in those repos marking artifacts **migrated** with links back.
- [ ] Pull high-signal docs into `insights/` or `docs/` with provenance.

---

## Tracking & Metrics
- [ ] Signals: #adoptions of charter, #decisions recorded, #objections resolved, #reviewed decisions/month.
- [ ] `notes/metrics.md` updated monthly.

---

## Review Cadence
- Weekly: backlog groom + priorities (10 min).
- Monthly: finance note + metrics.
- Quarterly: rule/charter review; publish changelog.

---

## Deprecating scattered TODOs
When this file merges:
- Replace TODOs inside **notes/**, **docs/**, or other repos with links to issues or to this file.
- Close stale PRs/issues where work is superseded by this plan.

---

## Changelog
- _2025-08-14 — initial master backlog._
