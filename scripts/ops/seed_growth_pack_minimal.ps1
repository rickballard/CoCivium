# seed_growth_pack_minimal.ps1
# Purpose: Seed a minimal growth pack into CoCivium on the current feature branch.
# Safe to run multiple times (idempotent-ish).
# Requires: Python 3 on PATH (for the linter/renderer).

Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

$Repo = "$HOME\Documents\GitHub\CoCivium"
if(!(Test-Path $Repo)){ throw "Repo not found: $Repo" }
Set-Location $Repo

# Ensure we're on the expected branch
$Branch = "feat/seed-growth-pack-v0-20250814"
git rev-parse --verify $Branch 2>$null | Out-Null
if($LASTEXITCODE -ne 0){ git switch -c $Branch } else { git switch $Branch }

$files = @{
  "kits/GLK/templates/Decision_Log.md" = @'
# Decision Log

> Keep entries short. One screen. Link evidence. Dates in ISO 8601.

## Metadata
- **Proposer:** 
- **Chair:** 
- **Recorder:** 
- **Quorum:** 
- **Objection Window:** 
- **Meeting/Thread Link:** 
- **Tags:** 

## Context
Why now? Prior decisions or mandates to consider.

## Proposal
One paragraph. Optional bullet criteria for success.

## Considerations
Key facts, tradeoffs, alternatives considered (max 5 bullets). Link evidence.

## Objections
- **O-1:** <summary> — _Open_ / _Mitigated_ / _Withdrawn_ — Owner — Evidence link

## Decision
Approved / Rejected / Deferred. Short rationale.

## Execution
Owner(s), checklist, target date, rollback note.

## Evidence Links
- Link 1

## Dates
- Proposed: 
- Decided: 
- Review-by (optional): 
'@;
  "tools/decision_log_linter.py" = @'
#!/usr/bin/env python3
import sys, re, pathlib
REQ_SEC=[r'^## Metadata',r'^## Context',r'^## Proposal',r'^## Considerations',r'^## Objections',r'^## Decision',r'^## Execution',r'^## Evidence Links',r'^## Dates']
REQ_META=[r'^- \\*\\*Proposer:\\*\\*\\s*',r'^- \\*\\*Chair:\\*\\*\\s*',r'^- \\*\\*Recorder:\\*\\*\\s*',r'^- \\*\\*Quorum:\\*\\*\\s*',r'^- \\*\\*Objection Window:\\*\\*\\s*']
def lint(p):
    t=p.read_text(encoding='utf-8',errors='ignore'); probs=[]
    for pat in REQ_SEC:
        if not re.search(pat,t,re.M): probs.append(f"Missing section: {pat[3:]}")
    for pat in REQ_META:
        if not re.search(pat,t,re.M): probs.append(f"Missing metadata: {pat.split('**')[1]}")
    return probs
def main(argv):
    targets=[pathlib.Path(x) for x in argv[1:]] or [pathlib.Path('kits/GLK/templates/Decision_Log.md')]
    allp=[]
    for t in targets:
        if not t.exists(): allp.append(f"File not found: {t}"); continue
        p=lint(t)
        if p: allp.append(f"[{t}] "+" | ".join(p))
    if allp: print("\\n".join(allp)); sys.exit(1)
    print("Decision Log linter: OK"); sys.exit(0)
if __name__=="__main__": main(sys.argv)
'@;
  "metrics/mission.toml" = @'
period = "Q3-2025"
adopters = 0
published_logs = 0
median_time_to_decision_days = 0
referral_rate_pct = 0
'@;
  "metrics/credibility.toml" = @'
period = "Q3-2025"
dii_verified_count = 0
case_studies_published = 0
top_risks = []
'@;
  "tools/render_eyes.py" = @'
#!/usr/bin/env python3
import tomllib, pathlib
def bar(v,m,x,y,w,h,l):
    pct=0 if m==0 else min(v/m,1.0); f=int(w*pct)
    return f'<text x="{x}" y="{y-6}" font-size="10" fill="#aaa">{l}: {v}</text>'\
           f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="3" fill="#222"/>'\
           f'<rect x="{x}" y="{y}" width="{f}" height="{h}" rx="3" fill="#00d4ff"/>'
def mission(m):
    svg=['<svg xmlns="http://www.w3.org/2000/svg" width="420" height="150">',f'<text x="12" y="20" font-size="12" fill="#fff">Mission Eye — {m.get("period","")}</text>']
    items=[("Adopters",m.get("adopters",0),100),("Published Logs",m.get("published_logs",0),300),("Median Days",m.get("median_time_to_decision_days",0),30),("Referral %",m.get("referral_rate_pct",0),100)]
    y=40
    for lbl,val,maxv in items: svg.append(bar(val,maxv,12,y,360,12,lbl)); y+=28
    svg.append("</svg>"); return "\\n".join(svg)
def cred(c):
    svg=['<svg xmlns="http://www.w3.org/2000/svg" width="420" height="170">',f'<text x="12" y="20" font-size="12" fill="#fff">Credibility Eye — {c.get("period","")}</text>']
    items=[("DII Verified",c.get("dii_verified_count",0),50),("Case Studies",c.get("case_studies_published",0),50)]
    y=40
    for lbl,val,maxv in items: svg.append(bar(val,maxv,12,y,360,12,lbl)); y+=28
    y+=6; svg.append(f'<text x="12" y="{y}" font-size="10" fill="#aaa">Top Risks</text>')
    x=90
    for r in c.get("top_risks",[])[:5]:
        rpn=r.get("rpn",0); color="#19c37d" if rpn<=4 else "#f5a623" if rpn<=9 else "#ff4d4f"
        svg.append(f'<circle cx="{x}" cy="{y-4}" r="6" fill="{color}"></circle>'); x+=20
    svg.append("</svg>"); return "\\n".join(svg)
b=pathlib.Path("."); m=tomllib.loads(b.joinpath("metrics/mission.toml").read_text(encoding="utf-8")); c=tomllib.loads(b.joinpath("metrics/credibility.toml").read_text(encoding="utf-8"))
o=b.joinpath("docs/img"); o.mkdir(parents=True, exist_ok=True)
o.joinpath("mission_eye.svg").write_text(mission(m), encoding="utf-8")
o.joinpath("credibility_eye.svg").write_text(cred(c), encoding="utf-8")
print("Rendered mission_eye.svg and credibility_eye.svg")
'@;
  "docs/img/concord_mark.svg" = @'
<svg xmlns="http://www.w3.org/2000/svg" width="180" height="36" viewBox="0 0 180 36" role="img" aria-label="Concord Mark"><defs><linearGradient id="g" x1="0" y="0" x2="1" y="1"><stop offset="0%" stop-color="#2c7be5"/><stop offset="100%" stop-color="#00d4ff"/></linearGradient></defs><rect rx="6" ry="6" width="180" height="36" fill="#111"/><text x="14" y="23" font-family="Inter,Segoe UI,Arial" font-size="14" fill="#fff">Concord Mark</text><circle cx="160" cy="18" r="10" fill="none" stroke="url(#g)" stroke-width="3"/><circle cx="160" cy="18" r="4" fill="#00d4ff"/></svg>
'@;
  "mark/USAGE.md" = @'
# Concord Mark — Usage
Add this badge where you publish decisions (README, website). Link it to your Decision Log index. Only use the mark if you have at least one published decision with evidence.
Example Markdown:
[![Concord Mark](docs/img/concord_mark.svg)](docs/decisions/)
'@;
  "risk/register.yml" = @'
- id: R-001
  title: Adoption stall
  category: Growth
  likelihood: 3
  impact: 3
  owner: Rick
  triggers: ["<10 published logs/month for 2 months"]
  mitigations: ["Run 2 GBSC Sprints", "Publish 2 micro-studies"]
  status: Open
- id: R-002
  title: Brand contamination
  category: Reputation
  likelihood: 2
  impact: 4
  owner: Rick
  triggers: ["Association with groups tolerating illegality"]
  mitigations: ["Guardrails policy; fast removal with receipts"]
  status: Open
'@;
  "services/gbsc/one_pager.md" = @'
# GroupBuild Sprint Consulting (GBSC)
Two 90-minute sessions to ship your first Decision Log entry, a minimal charter delta, role prompts, and guardrails. Price: $4,500 flat. Deliverables: decision entry with evidence, charter delta, prompt playbook + guardrails, next-two decisions plan.
'@;
  "docs/README-dropin.md" = @'
<p align="center">
  <img src="docs/img/mission_eye.svg" alt="Mission Eye" width="45%" />
  <img src="docs/img/credibility_eye.svg" alt="Credibility Eye" width="45%" />
</p>
<p align="center">
  <a href="docs/decisions/"><img src="docs/img/concord_mark.svg" alt="Concord Mark" height="28"/></a>
</p>
'@;
  ".gitattributes" = @'
*.sh text eol=lf
*.py text eol=lf
*.yml text eol=lf
*.yaml text eol=lf
*.md text eol=lf
*.svg text eol=lf
'@;
  "projects/lab/README.md" = @'
# CoCivium Lab (Temporary)
Temporary workspace during the grand migration. Artifacts move to a private org later. No secrets.
'@
}

foreach($k in $files.Keys){
  $p = Join-Path $Repo $k
  New-Item -ItemType Directory -Path (Split-Path $p) -Force | Out-Null
  $files[$k] | Set-Content -LiteralPath $p -Encoding UTF8
}

git add -A
git commit -m "feat(growth-pack): minimal seed (template, linter, eyes, mark, risk, GBSC, lab)"
git push

Write-Host "Seed complete. PR should now show a diff on branch: $Branch"
