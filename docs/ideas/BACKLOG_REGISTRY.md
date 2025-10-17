# CoCivium™ – Idea Backlog Registry (v1)

> Source: `IdeaCards_Retrospective.md` (9 canonical ideas). This registry captures nuance, justification, and a phased strategy so future-us can recognize intent quickly.

## Summary (ICE)
Idea | I | C | E | Score
---|---:|---:|---:|---:
Human Gating: targeted mobile notifications | 4 | 3 | 2 | 6.0
Outreach: pitch CoCivium™ to GitHub; request upgrade & staff monitor | 3 | 3 | 2 | 4.5
Stable DO-block packaging & copy/paste UX | 4 | 4 | 2 | 8.0
CoAgent Kit starter course + YouTube shorts | 4 | 3 | 3 | 4.0
Developer Onramp & Tutorial (poetic lead-in) | 4 | 4 | 2 | 8.0
Vision: Communal Mindspace evolution + safe diagram | 5 | 3 | 3 | 5.0
Brand-canonical poetic lead-ins/outs | 3 | 4 | 1 | 12.0
Press kit: free-use images folder | 3 | 3 | 2 | 4.5
CoPong hard cap → temp-file ingestion | 4 | 4 | 1 | 16.0

## Human Gating: targeted mobile notifications

**One‑liner.** Send human-gate prompts only to the right approver(s); design a 10‑second mobile approve/deny flow.

**Problem / Context.**
- Gate requests are noisy (broadcast to everyone) which delays decisions and creates attention tax.
- Approvals often happen away from keyboard; current UX is not mobile‑first.

**Why this / Why now.**
- As activity increases, broadcast pings will not scale.
- Clear audit trails of human decisions are a governance pillar; better UX → more consistent gating.

**Justification (expanded).**
- Near: reduce mean time to decision and reduce pings per gate.
- Mid: raise throughput by routing to CODEOWNERS/roles automatically.
- Long: safer delegation while keeping humans-in-the-loop for sensitive actions.

**Strategy (phases).**
- Phase 0 – Discovery: map labels → roles/CODEOWNERS; list gateable actions; design single-screen mobile checklist.
- Phase 1 – MVP: '/gate' bot comment that looks up role(s), pings them, and records a decision (approve/deny/route).
- Phase 2 – Scale: escalation timeouts, Slack/Discord bridges, per-repo policy packs.
- Comms: document 'How to Gate' in ONRAMP; add quick demo GIF in README.

**Risks & Mitigations.**
- Misrouted gates → wrong approver. Mitigation: explicit role fallbacks, manual 'route to X' option.
- Approvals not linked to identity. Mitigation: require signed actions (GH user) + bot audit log.
- Over-automation. Mitigation: keep 'Ask anyone' escape hatch.

**Success metrics.**
- Mean time to decision (MTTD).
- Avg. number of people pinged per gate.
- Approval-to-deny ratio; % of gates routed correctly on first try.

**Dependencies.** CODEOWNERS/roles registry, GitHub App or Actions bot, Label taxonomy

**Priority (ICE).** I=4 • C=3 • E=2 → **Score 6.0**

---

## Outreach: pitch CoCivium™ to GitHub; request upgrade & staff monitor

**One‑liner.** Position CoCivium™ as a public‑interest project; seek plan upgrade and a GitHub liaison.

**Problem / Context.**
- Limits on actions minutes / features could slow the project.
- No clear line to a support/BD contact; slower unblockings.

**Why this / Why now.**
- Early relationship compounds benefits; lowers friction for future org/repo scale.

**Justification (expanded).**
- Public good angle; helps GitHub showcase civic tech use‑cases; potential sponsorship.

**Strategy (phases).**
- Phase 0: 1‑pager + 6‑slide deck; identify contact paths (Support → BD).
- Phase 1: Send outreach; request org plan upgrade and a point‑person.
- Phase 2: Quarterly check‑ins; co‑write a short case study if traction appears.

**Risks & Mitigations.**
- Perception of vendor lock‑in → keep multi‑platform posture.
- Time sink if response is slow.

**Success metrics.**
- Upgrade granted?
- Liaison assigned?
- Turnaround time on support tickets.

**Dependencies.** Deck + letter, Clear public README/NEXT narrative

**Priority (ICE).** I=3 • C=3 • E=2 → **Score 4.5**

---

## Stable DO-block packaging & copy/paste UX

**One‑liner.** Make multimodal 'DO' blocks paste‑safe and stackable with an importable 'pastepack'.

**Problem / Context.**
- Long scripts get clipped or pasted out of order.
- Users cannot easily run multi‑step sequences safely.

**Why this / Why now.**
- We rely heavily on reproducible 'DO' snippets; friction here wastes cycles.

**Justification (expanded).**
- Less thrash; fewer support moments; better first‑run experience.

**Strategy (phases).**
- Phase 0: spec 'pastepack' (zip/txt with checksum + step delays).
- Phase 1: CoWorkbench: import pack, show 'ready' status, run with pauses.
- Phase 2: Signing & provenance for shared packs.

**Risks & Mitigations.**
- Security of imported content → show diff & signed author.
- Version drift → include minimum requirements.

**Success metrics.**
- First‑run success rate
- Avg. steps to green
- Support pings about broken pastes

**Dependencies.** CoWorkbench changes, Docs & examples

**Priority (ICE).** I=4 • C=4 • E=2 → **Score 8.0**

---

## CoAgent Kit starter course + YouTube shorts

**One‑liner.** A friendly 6–8 lesson track for non‑coders; shorts drive awareness → course converts.

**Problem / Context.**
- Hard for newcomers to know where to start; docs feel dense to non‑devs.

**Why this / Why now.**
- We need a healthy inflow of collaborators; video is a fast onramp.

**Justification (expanded).**
- Builds community, improves contributor quality, and clarifies our voice.

**Strategy (phases).**
- Phase 0: outline & scripts for 6–8 lessons (+ 30–45s shorts).
- Phase 1: record screen/audio; publish with checklists and a minimal example repo.
- Phase 2: update quarterly; collect Q&A to improve ONRAMP.

**Risks & Mitigations.**
- Production time; brand drift if tone is off.

**Success metrics.**
- Clones of example repo
- Course completion rate
- Watch‑through rate of shorts

**Dependencies.** Brand guidelines, Example repo, Basic motion graphics

**Priority (ICE).** I=4 • C=3 • E=3 → **Score 4.0**

---

## Developer Onramp & Tutorial (poetic lead-in)

**One‑liner.** A crisp ONRAMP.md that explains L4 agency, governance, and how to ship—optionally opened with a short poetic vignette.

**Problem / Context.**
- New devs lack a single golden path; fragmented docs.

**Why this / Why now.**
- We just reorganized; lock in a coherent welcome that sets expectations.

**Justification (expanded).**
- Shortens time‑to‑first‑contribution; reduces handholding.

**Strategy (phases).**
- Phase 0: draft structure (Lead‑in → Why → How → Tactics → Guardrails → Call to CoEvolve).
- Phase 1: include 'CoPing/CoPong' and 'Two‑Minds' links; wire into README & QUICKSTART.
- Phase 2: measure and iterate.

**Risks & Mitigations.**
- Too flowery or too dry—balance needed.

**Success metrics.**
- Time‑to‑first‑PR
- Drop‑off on ONRAMP page

**Dependencies.** Brand/poetry canon, Quickstart alignment

**Priority (ICE).** I=4 • C=4 • E=2 → **Score 8.0**

---

## Vision: Communal Mindspace evolution + safe diagram

**One‑liner.** Explain the staged evolution towards a communal mindspace with a diagram that is media‑safe and reviewed before release.

**Problem / Context.**
- Concept is powerful but easy to misinterpret; visuals can be misused.

**Why this / Why now.**
- We need an internal compass and external story while staying safe.

**Justification (expanded).**
- High leverage narrative for outreach & recruiting; reduces misconceptions.

**Strategy (phases).**
- Phase 0: write concept notes w/ caveats and ethics.
- Phase 1: prototype diagram variants; private review w/ trusted peers.
- Phase 2: publish to brand site once safety & brand sign‑off.

**Risks & Mitigations.**
- Memetic risk; over‑promising; critics take it out of context.

**Success metrics.**
- Comprehension tests before/after
- Negative‑feedback rate post‑publish

**Dependencies.** Brand review, Safety review panel

**Priority (ICE).** I=5 • C=3 • E=3 → **Score 5.0**

---

## Brand-canonical poetic lead-ins/outs

**One‑liner.** Define a repeatable structure for poetic intros/outros so they feel like us and carry metadata.

**Problem / Context.**
- Inconsistent tone and structure; hard to reuse.

**Why this / Why now.**
- We’re building a recognizable voice; consistency helps.

**Justification (expanded).**
- Improves communication quality; supports ONRAMP & course.

**Strategy (phases).**
- Phase 0: pattern doc under docs/brand/poetry with examples.
- Phase 1: footer spec (version/congruence).
- Phase 2: add lint rule / pre‑commit check for poetry files.

**Risks & Mitigations.**
- Over‑templating kills authenticity.

**Success metrics.**
- Adoption rate across docs
- Time to draft a new piece

**Dependencies.** Brand team (you), Docs linter (optional)

**Priority (ICE).** I=3 • C=4 • E=1 → **Score 12.0**

---

## Press kit: free-use images folder

**One‑liner.** Curate text‑free art in multiple sizes/formats for journalists and bloggers.

**Problem / Context.**
- Press asks for images; we have none that are ready and licensed.

**Why this / Why now.**
- Being ready avoids rushed, off‑brand assets when attention comes.

**Justification (expanded).**
- Low effort, decent payoff for outreach & legitimacy.

**Strategy (phases).**
- Phase 0: create assets/press/free‑use + README (license/usage).
- Phase 1: seed 3–5 concepts; owner approvals.
- Phase 2: refresh quarterly.

**Risks & Mitigations.**
- Misuse of assets; outdated branding.

**Success metrics.**
- Downloads/uses
- Inbound links using provided images

**Dependencies.** Design time, License text

**Priority (ICE).** I=3 • C=3 • E=2 → **Score 4.5**

---

## CoPong hard cap → temp-file ingestion

**One‑liner.** When a DO block is too big, auto‑switch to a temp file in Downloads so runs aren’t blocked by paste limits.

**Problem / Context.**
- UI paste limits block large scripts and lead to malformed pastes.

**Why this / Why now.**
- We’re authoring larger automation blocks; safety and speed matter.

**Justification (expanded).**
- Keeps momentum; fewer broken sessions.

**Strategy (phases).**
- Phase 0: design CoPongTempCache; file naming and cleanup policy.
- Phase 1: implement in CoWorkbench; document in ONRAMP/README.
- Phase 2: optional: background watcher to offer re‑run.

**Risks & Mitigations.**
- Path/perms issues on Windows/Mac; stale temp files.

**Success metrics.**
- # of runs using fallback
- Success rate after fallback
- Temp cleanup lag

**Dependencies.** CoWorkbench changes, OS‑specific paths

**Priority (ICE).** I=4 • C=4 • E=1 → **Score 16.0**

---

## Pending Harvest (to grow this registry)
- `docs/ideas/*.md` in CoCivium™ (including Two‑Minds links).
- `admin/inbox/**` (use the Inbox Harvester; convert `.docx`/`.odt` to `.md`).
- Open Discussions with label `idea` (if any).
- PR descriptions & commit messages containing 'Idea:' or 'docs(ideas):'.
- External pads: `RickPads.zip`, `BeachIdeaCard.odt` (convert via Pandoc).

### Helper – scan & build REGISTRY.md (PowerShell)
```powershell
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo = "$HOME\Documents\GitHub\CoCivium"
$ideas = Join-Path $repo 'docs\ideas'
$cards = Get-ChildItem $ideas -Filter *.md | ? { $_.Name -ne 'INDEX.md' }

function Get-FM {
  param([string]$t)
  $m=[regex]::Match($t,"(?s)^---\s*(.*?)\s*---"); if(-not $m.Success){ return @{} }
  $h=@{}; foreach($line in ($m.Groups[1].Value -split "`r?`n")){
    if($line -match '^\s*([A-Za-z0-9_-]+)\s*:\s*(.*)$'){ $h[$matches[1]]=$matches[2].Trim().Trim('"').Trim("'") }
  }; return $h
}

$rows = @()
foreach($c in $cards){
  $raw = Get-Content -Raw $c.FullName
  $fm  = Get-FM $raw
  $title = if($fm.title){ $fm.title } else { $c.BaseName }
  $tags  = if($fm.tags){ $fm.tags.Trim('[',']') } else { '' }
  $rows += [pscustomobject]@{ Title=$title; File=$c.Name; Tags=$tags }
}

$body = @("# Idea Registry",
"", "Title | File | Tags", "---|---|---") + ($rows | sort Title | % { "{0} | {1} | {2}" -f $_.Title,$_.File,$_.Tags })
$reg = Join-Path $ideas 'REGISTRY.md'; $body -join "`r`n" | Set-Content -Encoding UTF8 $reg
Write-Host "Wrote $reg"
```

