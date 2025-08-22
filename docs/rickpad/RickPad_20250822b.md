# RickPad — Consolidated Idea Cards & Ops Notes
_Prepared: 2025-08-22 20:16 UTC_
_Prepared: 2025-08-22 00:08 UTC · Purpose: readable backlog for later inclusion in CoCivium Discussions (not an action list)._

## How to use
- Keep a **single** RickPad (this file). When a card is ready for Discussions, mark `status=READY` and we’ll prep the port text in your voice.
- We iterate here until a card is **APPROVED FOR DISCUSSION**; then we export to GitHub Discussions and remove it from RickPad.
- Each Idea Card uses: **Lead · Context · Proposal · Risks · Dependencies · Ask**.

---

## Summary Index (priority‑ordered)
1. **P1 — Guardrails Badge (CoCivGuard)** — lightweight contributor shield & signals · `status=draft`
2. **P1 — Matrix → GitHub Discussions Relay** (one‑way, human gate) · `status=pilot`
3. **P1 — Safety Gate on PRs** (labels: `risk:high` requires `safety-approved`) · `status=live`
4. **P1 — Runtime Sanity** (smoke tests + watchdog) · `status=todo`
5. **P1 — Succession Manifest + Heartbeat Guardian** · `status=live`
6. **P2 — Community Objectives & Ethics Charter (public)** · `status=live`
7. **P2 — Discussions Voice** (Left/Right/Whole Brain personas) · `status=pilot`
8. **P2 — Brand/Security Watch** (digest + urgent spikes) · `status=pilot`
9. **P2 — Glossary → GIBindex promotion flow** · `status=pilot`
10. **P3 — CivicOpsEng** (first hire/contract profile + checklist) · `status=draft`
11. **P3 — L4 Orchestrator** (staged, permissioned) · `status=plan`
12. **P3 — Contributor Onboarding funnel** (qualification & purpose gate) · `status=draft`
13. **P1 — Master Influence Flow Diagram (MIFD / “Flownoodle”)** — new card · `status=ideation`

---

## Idea Cards

---------------------------------
## Idea Card — AI‑Club (Prelaunch) Adversarial Seeding

**Purpose.** Run multi‑model, dissent‑driven seeding of GitHub Discussions to harden CoCivium policy/docs before launch. Use a *switchboard* to orchestrate 3–4 models per topic. Post under one account with explicit provenance so it never looks like sockpuppeting.

---

## One‑liner

Create a **prelaunch/ai-club** track that spins up *evidence‑anchored*, *principled*, and *persona* critiques for priority backlog items, each thread labeled and fully attributed to its model+persona, then merge only the best syntheses into main after a rationality sweep.

---

## Why (problem)

* We need rigorous counters before first‑impression traffic hits the repo.
* Avoid single‑vendor bias.  Compare families of models.
* Build a public trail of how positions evolved, without drowning humans in noise.

---

## Scope (MVP)

* **Targets:** top 5–10 policies/docs (README, Governance, Decision Log method, Identity/Privacy, Public Records).
* **Models:** 3–4 distinct families via a router (e.g., Perplexity, Claude, Llama‑hosted, Gemini).
* **Outputs:** GitHub Discussions threads with TL;DR + citations + persona memos.  Additive docs only; no code.

---

## Naming & Labels

* **Program name:** **AI‑Club (Prelaunch)**.
* **Branch:** `prelaunch/ai-club` (docs/ only; additive).
* **Discussions category:** *AI‑Club Seeds*.
* **Labels:** `ai-seeded`, `prelaunch`, `persona:<id>`, `model:<id>`, `needs-citation` (if applicable), `rfc`, `decision-proposal`.

---

## Posting Rules (hard guardrails)

1. **Provenance required.** Every post begins with a header block and ends with a provenance footer (see templates).  No anonymous AI.
2. **Citations for facts.** Mark uncited sentences as *contestable*.
3. **Quota.** ≤ 1 thread per priority item; ≤ 4 model takes/thread; ≤ 1 persona per model.
4. **Human synthesis required.** A maintainer adds the first comment: TL;DR + “What would change our mind?”.
5. **No simulated stakeholders we can invite.** If humans exist, invite them.
6. **Close the loop.** Convert stabilized threads to RFCs and log a Decision Record.

---

## Workflow (3‑pass pattern)

1. **Evidence pass** — sources‑first critique (e.g., Perplexity).  Deliver: counter‑claims + links.
2. **Principled pass** — values/ethics trade‑offs (e.g., Claude).  Deliver: liberty/fairness/stability analysis.
3. **Persona pass** — one memo each from two ideological frames (e.g., Llama open‑weights).  Deliver: structured argument + fallacy check.
4. **Optional ingest** — summarization or doc‑linking (e.g., Gemini) feeding 1–3.

Artifacts for each pass are saved under `docs/ai-club/artifacts/<topic>/<YYYY-MM-DD>/`.

---

## Discussion Template (header)

```
[AI‑Club Seed] Topic: <short name>
Scope: <doc/PR/policy link>
Models: <list>
Frames: <liberty | fairness | stability | other>
Claims Table: <key claims vs counters>
TL;DR: <3–6 bullets>
```

## Provenance Footer (required)

```
— AI‑seeded post —
Model: <name@version>  |  Persona: <id>  |  Router: <id>
Date: <ISO8601>  |  Run: temp=<x> top_p=<y>  |  Seed: <n>
Prompt‑Hash: <sha256>  |  Artifacts: docs/ai-club/artifacts/<topic>/<date>/
Notes: Uncited statements are contestable by policy.
```

---

## Branch & Merge Strategy

* Work happens on **`prelaunch/ai-club`**.  Only new docs/threads/indices; no edits to existing canonical files.
* Periodic **Rationality Sweep** PR to `main` that merges:

  * Synthesized “Positions Ledger” updates.
  * Matured RFCs.
  * Links from Discussions to Decisions.
* Conflicts handled by **Positions Ledger** (source of truth): `docs/positions/ledger.md` with fields: Claim → Strongest Counter → Current Stance → Rationale → Last Updated.

---

## Moderation SOP (checklist)

* [ ] Verify header + footer present.
* [ ] Verify labels applied (`ai-seeded`, `model:*`, `persona:*`).
* [ ] Quick source check; tag `needs-citation` where weak.
* [ ] Add human TL;DR + change‑my‑mind test.
* [ ] If thread drifts, freeze until citations improve.
* [ ] Decision reached?  Link to Decision Record and close.

---

## Tooling (router/switchboard)

* Use a model‑router so one script can call multiple providers.
* Keep per‑provider keys in local env; never commit.
* Emit a small JSON manifest per run: prompt, system prompt, parameters, model id, persona id, prompt‑hash.

---

## Metrics (success & kill criteria)

**Success:**

* ≥ 60% of seeded threads upgraded by humans (edits/citations).
* ≥ 50% converted to RFCs within 14 days.
* Mean time to decision ≤ 21 days on targeted topics.

**Kill/Adjust:**

* > 30% threads stale (>14 days) without steward.
* Complaints about legitimacy or confusion in first‑time contributors.
* Maintainer time > 4h/week on moderation.

---

## Risks & Mitigations

* **Astroturf optics** → Bold provenance + single Discussion category (AI‑Club Seeds).
* **Noise creep** → Strict quotas; human synopsis requirement.
* **Bias import** → Cross‑family model mix; favor evidence pass.
* **Policy drift** → Positions Ledger and time‑boxed RFCs.

---

## Timeline (suggested)

* **Week 0:** Create labels, category, ledger, SOP, router script stub; pick 5 topics.
* **Week 1:** Seed 2 topics end‑to‑end; review moderation load.
* **Week 2:** Seed 3 more; open first Rationality Sweep PR.

---

## Owners / Roles

* **Program Steward:** Rick (until delegated).
* **Moderators:** TBD (2–3 people; time‑boxed).
* **Synthesis Editor:** TBD (finalizes Positions Ledger & sweep PRs).

---

## Open Questions

* Should we stand up a **GitHub App** for posting, or keep single‑account provenance with headers?
* Do we want community *red‑team bounties* for tightening citations?
* What’s the right ceiling on concurrent threads (3? 5?) to avoid overload?

------------------------------------
## Idea Card
Make www.CoCivium.org, a long read website that pulls in chunks from the repo every time it builds a document, and uses cached chunks if those chunks seem to be incumbered or messed up.  We could perhaps use zero-build Docsify pages set in small chunks.

--------------------------------------
## Idea Card — My github repos all seem to be owned by RickBallard, because the show up with this address: https://github.com/rickballard yet they likely should look less owned by a single person and more by an open source community, or at least they should look like they are held in trust by me, right?  So, can or should we try to change that address, perhaps the CoCivium repo address should not be https://github.com/rickballard/CoCivium but should instead be https://github.com/opename/CoCivium or https://github.com/trustholding/CoCivium or some such?  And if we do change this address somehow, should I then create another github account using my rballard@inseed.com for current/future projects that should remain independent of CoCivium, yet also public so you can help me manage any overlaps or reuse CoCivium BPOE/Workflow ideas, etc?

----------------------------------------
## Idea Card — CoCivium Civic Imagination Awards
Purpose: Incentivize and spotlight works (articles, videos, episodes, podcasts, OSS explainers) that model or interrogate CoCivium principles: consent before coercion, transparency with accountability, federated self-governance, restorative over punitive justice, data dignity, and open standards. The award legitimizes cultural artifacts that help people see and stress-test a consentful digital society.

Working Name: Civic Imagination Awards.

Why Now (blunt)
A. Culture moves opinion faster than whitepapers. Those shaping narratives today will shape policy and product defaults tomorrow.
B. If we don’t name and reward “good patterns,” the engagement economy will continue to reward outrage and centralizing power.
C. Awards are cheap leverage. Done right, they produce outsized signal and partnerships.

Scope & Categories (pilot set)
A. Long-Form Essay / Book Chapter.
B. Investigative Reporting on Digital Power.
C. Video Episode / Film Segment (e.g., satire like South Park when it illuminates consent dynamics).
D. Explanatory Piece on OSS/Open Standards for Civic Use.
E. “Reality Check” Award for works that critique us constructively.

Eligibility (clear rules)
A. Published in the last 24 months. Publicly viewable.
B. English or subtitled/captioned English.
C. Discloses funding and conflicts.
D. Not primarily an ad or sponsored content disguised as editorial.

Non-Eligibility / Red Flags
A. Hidden funding, astroturfing, or undisclosed affiliate schemes.
B. Factual fraud or pattern of retractions.
C. Advocacy that normalizes coercion or surveillance without consent-preserving safeguards.

Nomination Workflow (v0.1, low friction)
A. 2-page web form: link, summary, relevance to principles, disclosures, creator consent to be considered.
B. Anyone can nominate. Creators can self-nominate.
C. Nomination window: rolling; quarterly cutoffs for judging.

Judging & Rubric (weights total 100%)

Consent-First Design Insight — 20%

Epistemic Rigor (sources, accuracy, steel-manning) — 20%

Civic Impact Potential (audience reach + institutional relevance) — 15%

Clarity & Accessibility (teaches a non-expert) — 15%

Novelty/Originality (adds new angles) — 10%

Openness Alignment (open standards/commons literacy) — 10%

Safety & Ethics (harms considered, tradeoffs surfaced) — 10%
Scoring: each 1–5, multiply by weight, sum. Require ≥70/100 and no criterion <2.

Anti-Capture & COI Controls (non-negotiable)
A. Diverse 7-person jury: governance, journalism, OSS, civil society, creator, policy, layperson.
B. Juror COI disclosure per item. Recusal when any financial, editorial, or familial tie exists.
C. Publish short justification for each winner + anonymized rubric scores. Appeals window 14 days for factual error only.

Deliverables
A. Standards-based verifiable digital badge + page explaining why it won, with citations.
B. Small stipend per winner (even $500 is meaningful).
C. Media kit: press note, 60-sec clip, shareable quote cards.
D. Annual “anthology” page that stays online, versioned.

Pilot Timeline (90-day)
Month 1: finalize name, rubric, tiny jury, and nomination form. Announce.
Month 2: collect nominations, pre-screen, shortlist.
Month 3: jury scoring, winner write-ups, badges issued, public debrief.

Budget (pilot, lean)

Stipends: 5 winners × $500 = $2,500.

Jury honoraria: 7 × $200 = $1,400.

Design & web micro-site: $1,000.

Ops/contingency: $1,100.
Total: ~$6,000. Fund via small donor pool + sponsor who accepts zero editorial control.

Metrics That Matter (not vanity)
A. % of winners adopted in syllabi, policy memos, or internal briefings.
B. Post-award traffic lift and time-on-page for winners.
C. Number of open communities citing our rubric.
D. Diversity of creators and audiences reached.

Risks & Mitigations
A. Awards drift into brand theater. Mitigation: publish scoring + dissenting juror notes.
B. Ideological monoculture. Mitigation: require steel-manning of opposing views in write-ups.
C. Sponsor pressure. Mitigation: no sponsor veto, cap % of budget from any single funder.
D. Low trust in judging. Mitigation: transparent rubric, COI log, appeal on factual grounds.

Example Candidates (for rubric testing, not endorsements)
A. Satirical TV that surfaces consent vs coercion dynamics in tech governance.
B. Investigations into opaque algorithmic decision-making affecting citizens.
C. Explanations of open protocols that reduce platform lock-in.
D. Works that responsibly critique “open-wash” or performative decentralization.

Comms Plan (tight loop)
A. Single “call for nominations” post with concise criteria and examples.
B. Two milestone updates (shortlist, winners) with quotable pull-lines.
C. Encourage derivative explainers and classroom use. Provide educator notes.

License & Reuse
A. Winner write-ups under CC BY 4.0. Badges usable by winners with link-back.
B. No exclusive rights. We celebrate, not appropriate.

Nomination Form Fields (v0.1)
Title; link; creator name(s); publication date; category; 150-word summary; 150-word “how it advances consent-first governance”; funding & COI disclosures; languages; contact email; optional supporting links.

Governance Hooks
A. HumanGate: Rick approves initial jury and rubric v0.1 before launch.
B. Annual rubric review with public change-log.
C. Sunset clause: if KPIs unmet for two cycles, pause and reassess.

Name/Badge Copy (draft)
“CoCivium Civic Imagination Award — For advancing consent-first, federated, and transparent digital society.”

--------------------------------------

## Idea Card
## Idea Card — Pro-bono SVG Spinning Globe Hero (Outreach Sequence)

Purpose. Secure a smooth, lightweight, attribution-worthy SVG spinning globe hero for CoCivium, ideally via a small pro-bono contribution from a civic-minded dataviz/cartography expert. Fallback: micro-budget for the same scope.
Timebox. 2–4 hours contributor effort. Internal prep ≤60 minutes.
Success Criteria. 1) Delivered SVG ≤80 KB, low-CPU, smooth rotation, accessible. 2) Attribution line merged in README/site. 3) Optional “flags fill” variant scaffolded.

Outreach Sequence (serial, one at a time)

Prep (once). Confirm brief, assets, and attribution slot (see checklists).

Target #1: Philippe “Fil” Rivière — Contact: [public email on file].

Target #2: Jason Davies — Contact: [public email on file].

Target #3: Ian “enjalot” Johnson — Contact: [public email on file].

Target #4 (paid-leaning): Nadieh Bremer — Contact: [public email on file].

Target #5 (inputs focus): Matthew Bloch (map/topology prep) — Contact: [public email on file].

If all pass or no reply, post the brief to Open Source Design + DVS Slack (#help-wanted) and Code for All.

Cadence. One email at a time. Wait 3 business days for a response before moving to the next. If “busy now,” offer the micro-budget or ask for a short consult to bless the approach.

Deliverable (tight scope)

Format: Single SVG (512–1024 px square), CSS-driven slow rotation (orthographic).

Data: Natural Earth landmasses via TopoJSON, pre-simplified (we provide).

Perf: Smooth rotation, no jerkiness. No heavy JS. Respect prefers-reduced-motion.

Style: Grayscale default; class-toggle hook for optional “flags fill” on selected countries.

Budget: Target ≤80 KB SVG.

License: CC-BY-4.0 (or contributor’s OSS-compatible preference).

What We Provide (to de-risk the ask)

Clean TopoJSON + country IDs.

Tiny demo page and class hooks.

Single decision-maker (Rick). One revision pass. No bike-shedding.

Prominent attribution at top of README/site with link + one-line bio.

Email Draft (ready to send)

Subject: 2–4h pro bono ask — SVG spinning globe hero for open-governance project (CoCivium)

Hi <FirstName>,

I’m Rick, stewarding an open-source, consent-first governance project called CoCivium. We need a small but high-impact asset: a smooth, low-CPU, SVG-based spinning globe for our repo/site hero. Your work on maps/geo projection is the gold standard, so I’m asking if you’d consider a 2–4 hour, attribution-forward contribution.

Why it’s worth your time.

Public good: we’re building open civic infrastructure (no VC, no ads).

Your credit, link, and a short blurb at the top of our README/site.

Scope is tiny, decisions are fast, and we’ll release under a permissive license.

Deliverable (tight scope).

1 SVG hero (512–1024 px) with CSS slow rotation (orthographic).

Landmasses from Natural Earth (TopoJSON, pre-simplified). No heavy JS.

Grayscale default, with a class toggle for an optional “flags fill” variant.

File budget: ~50–80 KB. Respect prefers-reduced-motion.

License: CC-BY-4.0 (or your OSS-compatible choice).

What we’ll hand you.
Clean TopoJSON, country IDs, and a tiny demo page. I’m the single approver and won’t bike-shed your craft.

If “gratis” is a non-starter, tell me the micro-budget you’d accept for this exact scope. Either way, I’d value your guidance so we don’t ship trash.

If you’re open, I’ll send a one-pager brief and the assets. Thanks for considering.

— Rick
Steward, CoCivium
<your email> · <repo/site link>

------------------------------------------------

## Idea Card — Productize Issue-Resolution Chat Format

Concept: Develop a structured chat format for AI-assisted issue resolution.

Functionality: Users discuss issues verbally with their AI, which generates an evolving position paper alongside the dialogue.

Collaboration: Enables contributions from other users and their AIs to refine the position paper.

Outcome: The finalized position paper is converted into a PR for GitHub and sent to CoCivium or similar platforms.

## Idea Card — CoCivium's Long-Term Purpose

Platform Concept: CoCivium as a policy creation and action center.

Possible Labels:

Crowdsourced Democracy Platform

Digital Augmented Society Enabler

Record of Last Resort for Civic Frameworks

Blockchain Voting and Anonymous Voting Vector

## Idea Card — Refine Mission Statement

Mission Statement: Enable the regulation of an agentic, meritocratic, democratic digital society.

Purpose: Clarify CoCivium’s core objectives.

Challenges Addressed: Assist in defining CoCivium’s identity, branding, and taglines.

Let me know if this captures it.

## Idea Card — CoCivium Master Plan

Purpose: Create a comprehensive document outlining CoCivium’s vision, principles, and objectives.

Components:

Vision and mission statements.

Phases and objectives.

Performance tracking criteria.

Success criteria.

Assumptions.

SWOT analysis.

Distributed leadership model.

Scope:

Define what CoCivium does not do (e.g., coerce, enforce laws, align politically or commercially, endorse hatred, claim exclusive ownership, operate opaquely, harm humanity).

Highlight assumptions and acknowledge weaknesses.

### Card — Guardrails Badge (CoCivGuard) [P1]
**Lead.** Give newcomers a warm, positive badge to signal our guardrails (consent, reversibility, tone).
**Context.** Early channels will get noisy; we want a human‑feeling space with clear safety commitments.
**Proposal.**
- Draft badge copy & criteria (human‑first, reversible‑by‑default, least‑privilege).
- Add to README + site; optional badge for Issues/PRs/Discussions.
- Pilot with small group; iterate from feedback.
**Risks.** Badge seen as gatekeeping → frame as invitation; criteria drift.
**Dependencies.** Badge page + FAQ; aligns with Ethics Charter.
**Ask.** Review copy for warmth vs bureaucracy; mark READY when language feels right.

### Card — Matrix → GitHub Discussions Relay (one‑way, gated) [P1]
**Lead.** Let folks ideate in Matrix using a simple **card‑md** format, then relay to Discussions once approved.
**Context.** GitHub UI can be intimidating; we reduce friction without losing human gates.
**Proposal.**
- Keep minimal relay script (dry‑run by default); require front‑matter `status=approved`.
- Publish to `category=Ideas`; maintain human edit pass for tone.
- Keep `kill-switch` and `relay:live` flagging.
**Risks.** Accidental auto‑posting (mitigate via dry‑run + flag); source room spam (add qual. statement + rate‑limit).
**Dependencies.** Matrix token, gh CLI auth, `ops/policy.yml`.
**Ask.** Pilot one more card; if the tone reads human, flip to READY.

### Card — Safety Gate on PRs (labels) [P1]
**Lead.** Block merges of high‑risk changes unless explicitly `safety-approved`.
**Proposal.**
- Keep `.github/workflows/safety-gate.yml` active; scope to `risk:high` or `safety-review`.
- Add a one‑paragraph explainer in `CONTRIBUTING.md` and the PR template.
**Ask.** Nominate interim safety approver (Rick) and confirm label taxonomy.

### Card — Runtime Sanity (smoke + watchdog) [P1]
**Lead.** Minimal run tests to catch rot beyond lint.
**Proposal.** Create `tests/smoke` with 3–5 tiny checks; add `sanity.yml` to run on push/PR; gate merges later.

### Card — Succession Manifest & Heartbeat [P1]
**Lead.** Year‑and‑a‑day continuity via manual weekly heartbeat and a scheduled guardian.
**Proposal.** Keep a `user-heartbeat`; configure a “Successor” workflow to raise an activation issue after >366d of silence.
**Metrics (90‑day post‑activation).**
- Two tagged releases without founder reviews.
- ≥5 external PRs merged; median PR merge time <7 days.
- CI green ≥95%; security fix lead time <14 days.
- Maintainer pulse ≥7/10; no single maintainer >40% of merges.
**Files to add (later).** `docs/policies/STEPBACK.md`, `TRANSITION-NOTICE.md`, `CONSULTING.md`, `GOVERNANCE.md` (v2), `CODEOWNERS`, `SECURITY.md`, `.github/ISSUE_TEMPLATE/fst-activation.md`.
**Ask.** Adopt “Community‑Led • Founder‑Emeritus • Rotation Enforced” badge and maintain neutral `PROVIDERS.md` (opt‑in, alphabetical, no endorsements).

### Card — Persona Tags (Left/Right/Whole Brain) [P2]
**Lead.** Use in Discussion posts to expose trade‑offs transparently; single human author.
**Proposal.** Tag `(left)/(right)/(whole)`; keep voice humane; avoid sock‑puppeting.

### Card — Ops Policy & Kill Switch [P2]
**Lead.** Central `ops/policy.yml` and `ops/kill-switch` respected by relays/integrations.
**Proposal.** All automations consult policy; document permissions and uninstall steps.

### Card — BPOE / Workflow Record [P2]
**Lead.** Append‑only log of material decisions, guardrails, and ops changes (**Book of Process & Evidence**).
**Proposal.** Session blocks with links to issues/PRs; mirrors critical choices.

### Card — Incident & Pause Protocol [P3]
**Lead.** Define red flags, auto‑pause conditions, comms template, and recovery checklist.
**Proposal.** Ship triggers, comms template, and recovery steps; keep opt‑out kill switch visible.

### Card — Contributor Onboarding Lite [P3]
**Lead.** “Two‑click” newcomer path: read‑first → idea template → expectations.
**Proposal.** Read‑first page, idea template, Matrix staging submission.

---

## New Card — Master Influence Flow Diagram (MIFD / “Flownoodle”) [P1]
**Status.** Ideation → Ready to stage after Grand Migration.
**Problem.** There’s no neutral, global, person‑first map showing how ideas travel across venues (public/private/hybrid) to become policy/standards/guidance; newcomers can’t see where to intervene.
**Category + Naming.**
- **Category (public, generic):** “Democracy Crowdsourcer” — platform that turns citizen ideas into adoptable policy/standards (non‑proprietary to encourage forks).
- **Artifact name (public):** **Master Influence Flow Diagram (MIFD)**; short form **Master Influence Flowchart (MIF)**.
- **Internal nickname:** “Flownoodle” (optional, not public‑facing).
**Fork‑Friendliness & Competitor Signaling.**
- Invite forks and parallel implementations.
- Publish a **Compatibility Spec** (open license) + a **Compatible Implementations Directory**.
- Keep category generic; CoCivium is one implementation.
**README Category Block (paste‑ready).**
> **Category:** *Democracy Crowdsourcer.*
> CoCivium is one implementation of an open pattern where individuals convert ideas into adoptable policy/standards packs. We invite compatible forks and independent competitors. Shared goal: interoperable tooling and datasets so multiple projects can converge as society learns what works. Organizations do not govern CoCivium; they are recipients and venues to be influenced. One person, one voice.
**Patriotism & Localization.**
- Never US‑centric in base art; provide localization layers (banner zone, RTL support, local accents, emblem slot).
- Ship a **country‑neutral default**; overlays document local reality and deviations.
**“Ideal vs. Is.”** Default MIFD is **normative** (target form). Overlays capture **reality** (fast paths, blockers, practical routes).
**Next Actions.**
- Draft v0 of the poster (neutral default) + overlay spec.
- Create the compatibility spec scaffold and directory.
- Add the README category block under the lede.

---

## Outreach — Dream Team Pack (ops block)
**Purpose.** Ultra‑brief, tailored notes to ~20 “dream team” contributors; simple reply requested (“is CoCivium needed; how would you reframe?”).
**Action plan.**
1) **Source contacts** via official org pages/role‑based mailboxes; log address + source + status.
2) **One‑by‑one sends** (no BCC); personalize salutation and one sentence on their work; paste the matching page; include repo URL; sign “Rick — CoCivium (open, noncommercial).”
3) **Sequencing:** Core Framers → Model Governance → DPI/Cities → Rights/Safety → Conveners → Polycentric/Co‑ops.
4) **Subject lines:** use the per‑page subject; keep under ~60 chars; no emojis/ALL CAPS.
5) **Tracking:** SentAt, AddressUsed, SourceOfAddress, Auto‑Reply, ReplyReceived, NextStep (color replies that propose reframes).
6) **Follow‑ups:** 7 business days; one two‑line bump max.
7) **Safety/ethics:** only clearly public/role‑based addresses; if contact form only, submit there and log it.
8) **Attachments:** none in first note; **link** to repo and minimal 1‑pager when ready; keep total size <50 KB.
**Note.** Insert your repo URL into `{REPO_URL}` before sending.

---

## Glossary — Staging
- **CoCivGuard** — human‑first guardrails badge.
- **L4 Orchestrator** — permission‑bounded, gated automation layer.
- **Whole Brain Post** — Rick‑authored post that includes left/right reasoning with a short integration.
- **CivicOpsEng** — ops/process generalist to keep pipelines healthy.
- **Quiet Monitor** — alerting that suppresses “no news” updates; only surfaces actionables.
- **BPOE** — Book of Process & Evidence (append‑only decisions/ops log).

---

## Card Template (copy/paste)
```markdown
### Card — <Title> [P1|P2|P3]
**Lead.** <Single‑sentence purpose.>
**Context.** <One‑paragraph background.>
**Proposal.**
- <Actionable step>
- <Actionable step>
**Risks.** <Top 2–3.>
**Dependencies.** <People/Infra/Policy/Security.>
**Ask.** <What decision or input is needed?>
```
