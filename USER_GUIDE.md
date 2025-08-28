# CoCivium User Guide (v1 — Complete Draft)

**Purpose.** Give newcomers a fast, accurate on-ramp and give contributors/stewards a single source of truth for how to engage.  Two spaces after periods.  US spelling (UK only for Dogs n Homes).  CLI-first for builders on Windows PowerShell 7.  Everything traceable via issues/PRs/commits.  HumanGate on by default.

**Design principles.** Progressive disclosure • consent not coercion • Minimum friction • Reversible decisions • Plain language • Document once, reuse everywhere.

---

## Contents
1. Choose-Your-Path Landing
2. Start Here (overview)
3. Quickstart Tracks
   - Citizen / Curious
   - Contributor / Builder
   - Steward / Operator
   - Educator / Parent
   - Partner / Funder
   - Youth Player (FTW Game)
4. Core Concepts
   - Cognocarta Consenti (CC)
   - Congruence Layers
   - Decision Trails
   - RepTags & GIBindex
   - HumanGate
5. Tools & Modules (CoModules)
6. Initiatives & Experiments
7. Governance & Safety
8. Contributing Workflow
9. Metrics & Roadmap
10. Reference (FAQ, Glossary, Repo Map, Troubleshooting, Brand)
11. Appendices (Workflow bugs, Educational notes, Templates)

---

## 0) Choose-Your-Path Landing
**Audience tiles.**
- **Citizen / Curious** — What is CoCivium and why it matters.
- **Contributor / Builder** — Ship a tiny improvement in 15 minutes.
- **Steward / Operator** — Run the project safely (reviews, releases, rollbacks).
- **Educator / Parent** — Use our free ethics/game content with kids.
- **Partner / Funder** — Values-aligned collaboration (CoFit + Grant Use Policy).
- **Youth Player (FTW Game)** — Play, learn ethics, and help fix the world.

**Above-the-fold.**  30-second Why/Who/How triad, a live “What exists today” box, and a minimal QS checklist.

**QS checklist.**
- Read the 30-second overview.  
- Pick your path.  
- Star the repo or join Discussions.  
- Builders: install PS7 and GitHub CLI.  

---

## 1) Start Here (overview)
**The idea in one minute.** Democracies are running twenty-first-century societies with nineteenth-century operating systems.  CoCivium is an open, consent-first civic stack that helps communities propose, debate, and adopt better decisions — with transparent trails, reversible changes, and lightweight reputation.  It is free, open source, and built to be co-evolved by humans and AIs.

**What CoCivium is.** A living library of patterns, docs, and small tools (CoModules) for consentful governance.  A place to practice rapid, safe civic iteration.  A neutral, non-commercial commons.

**What CoCivium is not.** A political party.  A surveillance system.  A token-pump.  A substitute for local law.  We augment institutions; we do not bypass them.

**What exists today.** A canonical root README, a CC draft, early CoModules (CoAgent Kit, Repo Accelerator, CoCache, GIBindex), and initial workflows (HumanGate, squash-merge, decision trails).  Demos are simple but real.  More is coming.

**How to participate.** Pick the tile that matches you.  Citizens read and respond.  Builders ship tiny improvements.  Stewards keep the rails safe.  Educators run kid-friendly challenges.  Partners align funding and pilots.  Youth players explore ethics through play.

**Safety & governance.** We follow the Cognocarta Consenti (consent not coercion), a Code of Conduct, and HumanGate (human review before merges).  All changes are traceable to issues/PRs/commits.

**Where to ask for help.** Open a GitHub Discussion or Issue.  Join the read-only Matrix CoCivBus to observe progress.  Use templates.  Keep questions small.

---

## 2) Quickstart Tracks
Each track uses the same scaffold: **At-a-glance → Why it matters → DO → VERIFY → Next actions → FAQ.**

### 2A) Citizen / Curious
**At-a-glance.** Learn what CoCivium is and preview a demo in five minutes.

**Why it matters.** Better civic decisions depend on informed, voluntary participation.  You are the heartbeat of legitimacy.

**DO.**
1. Read the one-minute idea in Start Here.  
2. Skim the CC highlights.  
3. Watch a 60-second demo clip.  
4. Star the repo or drop a 👍 on a proposal.  

**VERIFY.** You can explain CoCivium in one paragraph to a friend.

**Next actions.** Respond to an open question in Discussions.  Share a link with someone who cares about governance.

**FAQ (short).**
- *Is this political?*  It is pro-process, not partisan.  
- *Is there a token?*  No.  Reputation is earned, not bought.  
- *Do I need to code?*  No.  Writing and feedback are valuable.

### 2B) Contributor / Builder
**At-a-glance.** Ship your first improvement in about 15 minutes.

**Why it matters.** Tiny, safe changes compounding over time build trust and capability.

**DO.**
1. Clone the repo.  Run the preflight (UTF-8, LF) and `git fetch --prune`.  
2. Create a branch.  Fix one small thing (typo, broken link, clarity).  
3. Commit with a conventional message.  Open a PR with labels (`docs`, `content`, `ci`).  

**VERIFY.** CI is green.  Your PR shows required checks.  You request review.

**Next actions.** Pick a “good first issue.”  Learn the `Watch-Checks` helper.  Grab a docs polish card.

**FAQ.**
- *Windows friendly?*  Yes.  PS7 is first-class.  
- *Direct commit to main?*  Default is branch + PR + squash.  
- *Style rules?*  Two spaces after periods.  US spelling (except Dogs n Homes).

### 2C) Steward / Operator
**At-a-glance.** Keep merges safe, releases clean, and rollbacks ready.

**Why it matters.** Safety rails create psychological safety for experimentation.

**DO.**
1. Enforce HumanGate and squash-merge policy.  
2. Use labels consistently.  Triage weekly.  
3. Tag releases using the machine-lowercase scheme (e.g., `cocivop-v0.1`).  
4. Keep decision trails reconstructable from issues/PRs + commits.  

**VERIFY.** You can cut a release, revert it, and explain why in three sentences.

**Next actions.** Rotate signing keys per plan.  Post a monthly health note.

**FAQ.**
- *When to hotfix main?*  Only for urgent breakage, with immediate post-hoc PR.  
- *Delete branches?*  Yes, after squash merge.

### 2D) Educator / Parent
**At-a-glance.** Use kid-safe activities that build ethical reasoning.

**Why it matters.** Early practice builds civic muscles and empathy.

**DO.**
1. Download an FTW challenge pack.  
2. Review the privacy & classroom tips.  
3. Run the 20-minute tutorial scenario.  

**VERIFY.** Learners complete the tutorial and write one reflection.

**Next actions.** Issue printed badges.  Send anonymized feedback via the template.

**FAQ.**
- *Age range?*  Designed for ~10+, adjustable.  
- *Religious overtones?*  Avoided.  Ethics, not dogma.

### 2E) Partner / Funder
**At-a-glance.** Align values and support pilots.

**Why it matters.** Funding without alignment corrupts outcomes.  Alignment first.

**DO.**
1. Read the CivicFit Engine (CoFit) overview.  
2. Review the Grant Use Policy and alignment checklist.  
3. Open a “Partner Intake” issue using the template.  

**VERIFY.** Your intent, scope, and guardrails are clear in writing.

**Next actions.** Sponsor a constrained pilot with public metrics.

**FAQ.**
- *Equity ask?*  None.  This is a commons.  
- *Attribution?*  Institutional by default; explicit credit optional.

### 2F) Youth Player (FTW Game)
**At-a-glance.** A playful ethics simulation that can inform real proposals.

**Why it matters.** Practicing choices in low-stakes settings builds wisdom.

**DO.**
1. Complete the tutorial.  Choose your path (constructive or mischievous).  
2. Earn your first badge.  
3. Share a reflection with a parent or mentor.  

**VERIFY.** You can describe what changed based on your choices.

**Next actions.** Try a harder dilemma.  Explore how your ideas map to real policy prototypes.

**FAQ.**
- *Scores?*  Visual badges and “congruence energy,” not numbers.  
- *Privacy?*  Minimal data.  Parental guidance encouraged.

---

## 3) Core Concepts

### 3.1 Cognocarta Consenti (CC)
**At-a-glance.** A living scroll that encodes “consent not coercion” into practice.  Change proposals are transparent and reversible.

**Why it matters.** Governance must be changeable without chaos.  CC is the rulebook for edits to the rulebook.

**Key elements.**  Consent gradients, objection handling, ratification cycles, reversibility windows, and public decision trails.

### 3.2 Congruence Layers
**At-a-glance.** Two layers: operational congruence (does this work safely now?) and deep congruence (does this align with mission and ethics?).

**Use.** We prefer small operational wins that conserve deep congruence.  When in doubt, pause and check both layers.

### 3.3 Decision Trails
**At-a-glance.** Every material change is traceable from issues/PRs to commits and releases.  No private side channels for decisions.

**Benefit.** Audits, reversibility, and onboarding new contributors quickly.

### 3.4 RepTags & GIBindex
**At-a-glance.** RepTags are lightweight acknowledgments of helpful contributions.  GIBindex is our glossary/registry with provenance.

**Benefit.** Shared language reduces confusion.  Reputation remains descriptive, not financialized.

### 3.5 HumanGate
**At-a-glance.** Humans review merges until our guardrails are proven safe.  Exceptions require justification and quick post-hoc review.

**Benefit.** Safety first while enabling AI-accelerated throughput.

---

## 4) Tools & Modules (CoModules)
**CoAgent Kit.** Assisted contributor flows.  Prompts, scripts, and templates for shipping small improvements consistently.

**Repo Accelerator Kit.** Scaffolds for new modules with CI, docs, and release wiring pre-baked.

**CoCache.** Cross-repo sidecar memory and ops notes.  Keeps session context and decisions portable.

**GIBindex.** Registries and terms with provenance.  Powers the glossary.

**CLI helpers (PS7).** `Watch-Checks` for CI, `gpw` for push-and-watch, `CoStage` for WIP snapshots, and `CoPingPong` for long instruction handshakes.

**Troubleshooting.** If CI fails, read the error first.  Re-run locally.  Ask for a second set of eyes with a link to your PR.

---

## 5) Initiatives & Experiments
**Dual README.** Human and AI voices in parallel to improve clarity and inclusivity.

**In-doc A/B Switcher.** Offer contrasting straw-man proposals to teach by comparison and record preferences.

**Fix the World: The Game (FTW).** Mobile-first ethics play that feeds anonymized insights into real proposals where appropriate.

**CivicFit Engine (CoFit).** Models market demand and fit for governance tools.  Pairs with Grant Use Policy for values-aligned funding.

**Market-Demand Modeling.** Profiles likely users and policies to prioritize high-impact work.

**Parallel Workflow Strategy.** Run low-risk tasks beside deeper discussions to keep momentum.

**For each initiative, we track.** Problem, hypothesis, MVP, how to help, status, and metrics.

---

## 6) Governance & Safety
**Code of Conduct.** Be respectful.  No harassment.  Resolve conflicts with restorative steps.  Escalate via listed maintainers.

**Privacy & Data Handling.** Minimal data, transparent uses, opt-outs.  No hidden analytics.

**Licensing & Attribution.** Institutional authorship by default.  Optional explicit credit on request.  Keep traceability for reversibility.

**Signing Keys & Releases.** Who signs what, with rotation and revocation plan.  Release tags are machine-lowercase; the site shows human-readable aliases.

---

## 7) Contributing Workflow
**Happy path.** Issues → Branch → PR → Review → Squash → Delete branch.  Keep changes small.

**Labels.** `domain`, `product`, `ops`, `ci`, `wiki`, `content`, `refactor`, `funding`.

**Style.** Two spaces after periods.  US spelling, except Dogs n Homes uses UK spelling.  Standard headers/footers.  Congruence labels allowed.

**Commit & PR templates.** Conventional commits and short bodies with “why.”

**Reverts & rollbacks.** Keep ONEBLOCK-style notes for quick undo paths.

---

## 8) Metrics & Roadmap
**KPI dashboard.** Adoptions of charter, decisions recorded, objections resolved, reviewed decisions per month.  Later: contributor retention and time-to-first-PR.

**Release scheme.** Machine-lowercase tags (`cc-v1`, `cocivop-v0.1`), with human aliases on the site.  Squash merges keep history tidy.

**Roadmap.**
- **0–3 months.** Guide v1 in repo.  FTW tutorial.  A/B switcher prototype.  Basic metrics badge.  
- **3–6 months.** CoFit alpha.  Partner intake template live.  More classroom packs.  
- **6–12 months.** Public pilots with published outcomes.  Auto-generated repo map and glossary.  

---

## 9) Reference
**FAQ (sample).**
- *How do I start without coding?*  React in Discussions and help improve docs.  
- *What if I disagree?*  Open a constructive issue with alternatives and trade-offs.  
- *Can I use this in my town?*  Yes.  Forks welcome.  Share lessons back.  

**Glossary.** Backed by GIBindex with provenance for key terms.

**Repo Map.** Human-friendly tree with links to major docs, tools, and initiatives.

**Troubleshooting.** Windows/PS7 quirks, common CI failures, link checker false positives, and how to get help fast.

**Brand Kit.** Logos, colors, usage guidelines, and badges.

---

## 10) Appendices
**Known Workflow Bugs.** A living list with “how you can help fix.”

**Educational Notes.** Curated readings with short summaries to accelerate context.

**Templates.** Issues, PRs, proposals, and lesson plans.

---

**Cross-links from root README (above-the-fold).**
- Start Here → this guide’s Start Here section.  
- Quickstart → Contributor / Builder track.  
- Cognocarta Consenti → Core Concepts.  
- Roadmap → Metrics & Roadmap.  

**Success criteria.** A newcomer reaches first meaningful action in ≤5 minutes.  A builder opens a first PR in ≤15 minutes.  A steward can run a safe release using only the guide.
