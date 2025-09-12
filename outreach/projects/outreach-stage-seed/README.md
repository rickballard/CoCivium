# CoCivium Outreach — Wave 0 (v0.2)

This seed list prioritizes **18 high-leverage advisors/conveners** spanning academia, civil society, standards, and policy bodies. We score each contact on:  
- **Value (40%)** — Their potential to materially improve our governance/appeals module, measurement plan, or legitimacy.  
- **Likelihood (40%)** — Probability of engaging on a 30‑minute advisory call within ~2–3 weeks.  
- **Contact Reliability (20%)** — Availability of a clear, official contact route (faculty profile, org page, etc.).  

**PriorityScore = (0.4·Value + 0.4·Likelihood + 0.2·Contact) × 20** → 0–100.

## What we’re asking (default)
- A **30‑minute advisory** to sanity‑check our *Cognocarta Consenti* module and our **anti‑gaming metrics** (congruence, remedy‑rate, legitimacy signals).  
- Optionally, a **pressure‑test seminar** (“Digital constitutions that actually run”) co‑hosted with their community.

## Hooks (tune per contact)
- *“Due process + appeals embedded in protocols”* (code + institutions, not just words).  
- *“Jurisdiction‑aware routing and remedy rights aligned with the Council of Europe AI Convention.”*  
- *“Operational transparency: from statements to measurable, auditable flows.”*  

## Cadence
1) Day 0: Intro email with 1‑pager + flow diagram.  
2) Day 5–7: Nudge with one concrete question from our checklist.  
3) Day 14–21: Offer seminar/roundtable slot; propose 2–3 dates.  

## Templates
**Academic (short):**
> Subject: Digital constitutionalism in practice — quick advisory request (CoCivium)  
> Hi {{Title}} {{LastName}} — your work on {{their-theme}} has shaped our thinking. We’re operationalizing *digital constitutionalism* beyond text: due process + appeal **inside** protocols.  
> Could we book a 30‑minute advisory to sanity‑check our *Cognocarta Consenti* (rights/remedies, jurisdiction‑aware routing) and our **anti‑gaming metrics** (congruence, remedy‑rate, legitimacy signals)? We’ll share a 2‑pager in advance.  
> — Rick (CoCivium)

**NGO/Policy (short):**
> Subject: Principles alignment + remedy‑rights in practice (request for review)  
> Hi {{Name}} — CoCivium is implementing user‑rights + remedy by design, aligned with the Council of Europe AI Convention. 30‑min review to stress‑test our appeals & transparency flows and discuss a short alignment statement?  
> We’ll share a 1‑pager, flow diagram, and a checklist mapped to your positions.

**Convener (seminar):**
> Subject: Co‑hosting a pressure‑test seminar: “Digital constitutions that actually run”  
> Hi {{Name}} — 60‑minute session to test CoCivium’s draft modules with your community (short demo + critique). Three prompts: (1) due‑process on protocols, (2) legal‑interoperability, (3) anti‑gaming metrics. Goal: hard feedback, pilot venues, and a short write‑up crediting discussants.

## Files
- `CoCivium_outreach_leads_v0.2.csv` — scored contacts (Wave 0).

---

### Repo staging (PowerShell, idempotent)
```powershell
$Repo   = Join-Path $HOME 'Documents\GitHub\CoCivium'
$OutDir = Join-Path $Repo 'outreach\projects\outreach-stage-seed'
$DL     = Join-Path $HOME 'Downloads'
$CoTemp = Join-Path $DL   'CoTemp'
New-Item -ItemType Directory -Force -Path $OutDir,$CoTemp | Out-Null

# Place these two files in your Downloads first:
# - CoCivium_outreach_leads_v0.2.csv
# - outreach_project_proposal_v0.2.md

Copy-Item (Join-Path $DL 'CoCivium_outreach_leads_v0.2.csv') (Join-Path $OutDir 'CoCivium_outreach_leads_v0.2.csv') -Force
Copy-Item (Join-Path $DL 'outreach_project_proposal_v0.2.md') (Join-Path $OutDir 'README.md') -Force

Set-Location $Repo
$branch = 'outreach/seed-contacts-v0.2'
if ((git branch --list $branch) -ne $null) { git checkout $branch } else { git checkout -b $branch }
git add 'outreach/projects/outreach-stage-seed/README.md' 'outreach/projects/outreach-stage-seed/CoCivium_outreach_leads_v0.2.csv'
git commit -m 'outreach: wave 0 leads + playbook (v0.2)'
git push -u origin $branch
gh pr create -t 'Outreach: wave 0 leads + playbook (v0.2)' -b 'Adds scored contacts, default asks/hooks, and cadence.' --label docs --label outreach
```
