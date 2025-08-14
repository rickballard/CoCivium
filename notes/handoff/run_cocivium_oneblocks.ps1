# run_cocivium_oneblocks.ps1  (v3)
[CmdletBinding()]
param(
  [string]$ZipPath    = "$HOME\Downloads\cocivium_oneblocks.zip",
  [string]$InstallDir = "$HOME\Downloads\cocivium_oneblocks",
  [string]$RepoRoot   = "$HOME\Documents\GitHub\CoCivium",
  [switch]$All        = $true
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
function Log([string]$msg){ Write-Host ("[{0}] {1}" -f (Get-Date -Format HH:mm:ss), $msg) }

# Locate the ZIP (fallback to newest matching in Downloads)
if (-not (Test-Path $ZipPath)) {
  $cand = Get-ChildItem "$HOME\Downloads" -File -Filter "cocivium_oneblocks*.zip" | Sort-Object LastWriteTime -Descending
  if ($cand) { $ZipPath = $cand[0].FullName }
}
if (-not (Test-Path $ZipPath)) { throw "Could not find bundle zip. Expected at: $ZipPath" }

Log "ZIP: $ZipPath"
Log "InstallDir: $InstallDir"
Log "RepoRoot: $RepoRoot"

# Fresh extract
if (Test-Path $InstallDir) { Log "Removing existing $InstallDir ..."; Remove-Item $InstallDir -Recurse -Force }
New-Item -ItemType Directory -Force $InstallDir | Out-Null
Log "Extracting..."
Expand-Archive -Path $ZipPath -DestinationPath $InstallDir

# Verify core scripts exist
$requiredScripts = @(
  "preflight.ps1",
  "apply_master_backlog.ps1",
  "wiki_seed.ps1",
  "create_finance_brief_pr.ps1",
  "patch_wiki_domains.ps1",
  "style_paste_safety.ps1",
  "labels_and_meta_issues.ps1"
)
$missing = @()
foreach($f in $requiredScripts){
  if (-not (Test-Path (Join-Path $InstallDir $f))) { $missing += $f }
}
if ($missing.Count -gt 0) { throw "Missing script(s) from bundle: $($missing -join ', ')" }

# Ensure optional content files (create sane defaults if absent)
function Ensure-File($path, [string]$content) {
  if (-not (Test-Path $path)) {
    $dir = Split-Path $path
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
    Set-Content -Path $path -Value $content -Encoding UTF8
    Log "Created default: $(Split-Path $path -Leaf)"
  }
}

$wikiHomePath = Join-Path $InstallDir "WIKI_HOME.md"
$wikiHome = @'
# CoCivium Wiki

CoCivium is a practical path toward **consentful, polycentric governance**.

Start here:
- [[Getting-Started]]
- [[Decision-Flow]]
- [[Roles]]
- [[Domains]]
- [[FAQ]]
- [[Links]]

**Repo canon**
- Vision → `docs/vision/CoCivium_Vision.md`
- Charter (Cognocarta: Consenti) → `scroll/Cognocarta_Consenti.md`
'@

$financeBriefPath = Join-Path $InstallDir "FINANCE_BRIEF.md"
$financeBrief = @'
# Finance & Budgeting — Consentful Patterns

**Goal:** fund work with dignity and transparency while avoiding power capture.

## Context
Money flows shape incentives and trust. Keep ledgers open, roles separated, and decisions reviewable.

## Practices worth copying
- Open ledgers + monthly notes (cash in/out, cash on hand)
- Ring-fenced grants tied to obligations & review dates
- Separation of concerns: proposer / implementer / approver / auditor
- Budget caps and sunsets; renew on evidence
- Public caps on steward discretion; risk-scaled signals for larger spends
- Portable records (plain files; hashable when needed)

## Minimum viable flow
1) Proposal: context → options → risks → obligations → review date  
2) Consent check → if stalled, escalate to risk-scaled vote  
3) Record outcome + ledger entry + steward owner  
4) Review on date → renew/retire → publish note

**Next:** add citations in `docs/sources/annotated-bibliography.md`.
'@

$checklistPath = Join-Path $InstallDir "CHECKLIST.md"
$checklist = @'
# Operator Checklist (P0)

- Merge open PRs after quick desktop/mobile skim
- Enable Wiki and publish Home/Getting-Started/Decision-Flow/Roles/Domains/FAQ/Links
- Draft first 3 domain briefs (finance, identity/privacy, public records)
- Open Collective: pick host, create **cocivium**, test $1 donation
- Switch Sponsor button when OC is live
'@

Ensure-File $wikiHomePath $wikiHome
Ensure-File $financeBriefPath $financeBrief
Ensure-File $checklistPath $checklist

# Show bundle contents briefly
Log "Bundle contains:"
(Get-ChildItem $InstallDir | Select-Object -ExpandProperty Name) | ForEach-Object { Write-Host " - $_" }

# Ensure repo is a git repo
if (-not (Test-Path $RepoRoot)) { throw "RepoRoot not found: $RepoRoot" }
$null = git -C $RepoRoot rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0) { throw "Not a git repo: $RepoRoot" }

# Step runner
function Run-Step($name, $script, $args){
  Log "==> $name"
  & (Join-Path $InstallDir $script) @args
  Log "<== $name (ok)"
}

# 0) Preflight
Run-Step "Preflight" "preflight.ps1" @{ RepoRoot = $RepoRoot }

if ($All) {
  Run-Step "Apply master backlog" "apply_master_backlog.ps1" @{ RepoRoot = $RepoRoot }
  Run-Step "Wiki seed" "wiki_seed.ps1" @{ RepoRoot = $RepoRoot }
  Run-Step "Create finance brief PR" "create_finance_brief_pr.ps1" @{ RepoRoot = $RepoRoot }
  Run-Step "Patch wiki domains" "patch_wiki_domains.ps1" @{ RepoRoot = $RepoRoot }
  Run-Step "Style paste-safety" "style_paste_safety.ps1" @{ RepoRoot = $RepoRoot }
  Run-Step "Labels & meta issues" "labels_and_meta_issues.ps1" @{ RepoRoot = $RepoRoot }
}

Log "All done. Review any opened PRs and the Wiki."
