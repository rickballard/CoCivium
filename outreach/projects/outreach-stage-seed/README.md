# CoCivium Outreach Stage — Target Leads & Playbook (Seed v0.1)

**Owner:** CoCivium Outreach WG  
**Date:** 2025-09-12  
**Artifacts:** `CoCivium_outreach_leads_seed.csv` (this folder)

## Purpose
Operationalize a focused outreach campaign to 30–100 high‑leverage individuals and orgs in *digital constitutionalism, internet governance, and digital rights*, to (1) validate CoCivium’s constitutional architecture, (2) recruit advisors/collaborators, and (3) secure pilots and endorsements.

## Prioritization Heuristics
- **PriorityScore = 0.5 × LikelyEngage + 0.5 × ValueToCoCivium** (5‑point scales)
- First pass focuses on academics + networked conveners (GovLab, Metagov, OII, BKC, I&J) with public contact vectors.
- Defer heads of state / ministers to v0.3 after we have 3+ advisory letters.

## What We’re Asking
- **Advisory 30‑min interview** on CoCivium’s “Cognocarta Consenti” (feedback).
- **Peer review** of two modules: Platform Governance & Metrics/Congruence.
- **Co‑hosted seminar / roundtable** (Metagov/OII/GovLab/BKC) to pressure‑test guardrails.
- **Principles alignment statement** referencing the Council of Europe AI Convention.

## Hooks / Phrases to Test (A/B)
- *“Digital constitutionalism beyond the paper state: code + institutions, not just words.”*
- *“Legal‑tech interoperability: jurisdiction‑aware processes and appeal rights baked in.”*
- *“Metrics that resist gaming: congruence, remedy‑rate, and legitimacy signals.”*
- *“Human‑AI co‑governance with explicit HumanGate approvals and transparent rollback.”*

## Cadence & Funnel
1. **Wave 1 (~20 contacts):** Top PriorityScore ≥4.5. Personalized mails + warm intros where possible.
2. **Wave 2 (~30 contacts):** Scholars/practitioners with public emails or strong LinkedIn vectors.
3. **Wave 3 (~50):** NGO coalitions + treaty fora (observer/liaison invitations).

## Assets to Attach
- 2‑pager: CoCivium overview (PDF).  
- 1‑pager: “Cognocarta Consenti” summary.  
- Diagram: Governance & Remedy Flow (PNG).  
- Link: Repo landing page and READMEs.

## Data Source
The seed list (CSV) includes Name, Affiliation/Role, Why, Ask, Hooks, Contact lead, and scores. Sources are recorded for each entry.

## Next Steps
- [ ] Expand from 40 to 100 entries (v0.2): add contact specifics (email/URL), region tags.
- [ ] Generate templated cold‑open variations (academic / NGO / convening body).
- [ ] Book 4 co‑host venues (Metagov Seminar, OII event, GovLab session, BKC brownbag).
- [ ] Track replies in `outreach/tracker.csv` with status labels: Drafted, Sent, Replied, Call set, Complete.

---

### ONEBLOCK: Stage into repo (local first; adjust paths if needed)

```powershell
# NOP (paste-guard)
''|Out-Null
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

# Paths
$Repo  = Join-Path $HOME 'Documents\GitHub\CoCivium'
$Stage = Join-Path $Repo 'outreach\projects\outreach-stage-seed'
New-Item -ItemType Directory -Force -Path $Stage | Out-Null

# Download artifacts from this chat (place the CSV in the folder first if needed)
# If you downloaded the CSV to Downloads\CoTemp:
$SrcCsv = Join-Path $HOME 'Downloads\CoTemp\CoCivium_outreach_leads_seed.csv'
if (Test-Path $SrcCsv) { Copy-Item $SrcCsv $Stage -Force }

# Write proposal
$Prop = Join-Path $Stage 'README.md'
@'
{PROPOSAL_MD}
'@ | Set-Content -Path $Prop -Encoding UTF8

# Git add/commit (create branch if desired)
Set-Location $Repo
git checkout -b 'outreach/seed-contacts-v0.1' 2>$null
git add 'outreach/projects/outreach-stage-seed/README.md' `
        'outreach/projects/outreach-stage-seed/CoCivium_outreach_leads_seed.csv'
git commit -m 'outreach: seed leads list + playbook (v0.1)'
# Optional: create PR
# gh pr create -t 'Outreach: seed leads + playbook (v0.1)' -b 'Adds seed contact list and outreach playbook.'
```

> Replace `{PROPOSAL_MD}` with this file’s markdown if your shell doesn’t support here-strings.
