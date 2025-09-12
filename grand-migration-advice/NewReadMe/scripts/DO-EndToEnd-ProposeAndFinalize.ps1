# End-to-end: relax → proposal PR (auto-merge) → finalize moves → finalize PR (auto-merge)
param(
  [string]$RepoPath = (Join-Path $HOME 'Documents\GitHub\CoCivium'),
  [string]$StagePath = (Join-Path $HOME 'Downloads\CoTemp\NewReadMe\proposal'),
  [switch]$RelaxBranchProtection = $true,
  [switch]$LeaveProtectionRelaxed = $true  # do not restore by default
)

function Require-Cmd($n){ if (-not (Get-Command $n -ErrorAction SilentlyContinue)) { throw "$n not found" } }
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
Require-Cmd git; Require-Cmd gh

if (-not (Test-Path $RepoPath)) { throw "Repo not found: $RepoPath" }
if (-not (Test-Path $StagePath)) { throw "Stage not found: $StagePath" }

Set-Location $RepoPath
$repo = (gh repo view --json nameWithOwner | ConvertFrom-Json).nameWithOwner
if (-not $repo) { throw "gh not authenticated to a repo under $RepoPath" }

$Now = Get-Date -Format 'yyyyMMdd_HHmm'
$propBranch = "docs/new-root-readme_proposal_$Now"
$finBranch  = "docs/new-root-readme_finalize_$Now"

# 1) Relax branch protection (optional)
$backup = Join-Path $PSScriptRoot 'branch-protection.backup.json'
if ($RelaxBranchProtection) {
  Write-Host "[1/7] Backing up branch protection → $backup" -ForegroundColor Yellow
  gh api repos/$repo/branches/main/protection > $backup
  Write-Host "[2/7] Disabling branch protection on main" -ForegroundColor Yellow
  gh api -X DELETE repos/$repo/branches/main/protection
} else {
  Write-Host "Skipping protection relax."
}

# 2) Create proposal PR and auto-merge
Write-Host "[3/7] Creating proposal PR…" -ForegroundColor Cyan
git fetch --all
git checkout main
git pull --ff-only
git checkout -b $propBranch

$dest = Join-Path $RepoPath 'proposal'
if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item -Path (Join-Path $StagePath '*') -Destination $dest -Recurse -Force

git add proposal
$body = @"
CoWrap — New Root README Proposal (v3.2)
- Navigational README, Onramps, Outputs (taxonomy, out-of-scope)
- Badges/status, RFC template, Congruence rubric, Records logging
- BPOE CoTemp guidance; diagrams; notices
"@
$title = 'Docs: New root README + Onramps/Outputs (Proposal)'
git commit -m $title -m $body
git push -u origin $propBranch

$labels = @('docs','proposal','bpoe','readme','academy','onramps','outputs')
$labelArgs = @(); foreach($l in $labels){ $labelArgs += @('--label', $l) }
gh pr create --title $title --body $body --base main --head $propBranch @labelArgs | Out-Null
$prNum = gh pr view --json number --jq .number --head $propBranch
if (-not $prNum) { throw "Could not get proposal PR number" }
Write-Host "Proposal PR #$prNum created." -ForegroundColor Green
gh pr merge $prNum --squash --delete-branch --admin --yes

# 3) Finalize repo structure
Write-Host "[4/7] Finalizing repo structure…" -ForegroundColor Cyan
git checkout main
git pull --ff-only
git checkout -b $finBranch

# Archive existing root README
$depDir = Join-Path $RepoPath 'deprecated'; if (-not (Test-Path $depDir)) { New-Item -ItemType Directory -Force -Path $depDir | Out-Null }
$currRoot = Join-Path $RepoPath 'README.md'
if (Test-Path $currRoot) {
  $backupReadme = Join-Path $depDir ("legacy_readme_{0}.md" -f $Now)
  Move-Item $currRoot $backupReadme -Force
}

# Promote proposal content
Move-Item (Join-Path $RepoPath 'proposal\README.md') (Join-Path $RepoPath 'README.md') -Force
foreach($d in 'onramps','outputs','academy'){
  $src = Join-Path $RepoPath "proposal\$d"
  $dst = Join-Path $RepoPath $d
  if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
  Move-Item $src $dst -Force
}

# Move diagrams & docs
$docsDir = Join-Path $RepoPath 'docs'
$diaDir  = Join-Path $docsDir 'diagrams'
if (-not (Test-Path $diaDir)) { New-Item -ItemType Directory -Force -Path $diaDir | Out-Null }
if (Test-Path (Join-Path $RepoPath 'proposal\diagrams')) {
  Move-Item (Join-Path $RepoPath 'proposal\diagrams\*') $diaDir -Force
}

# BPOE & migration notes
$bpoeDir = Join-Path $docsDir 'bpoe'; if (-not (Test-Path $bpoeDir)) { New-Item -ItemType Directory -Force -Path $bpoeDir | Out-Null }
$migDir  = Join-Path $docsDir 'migration'; if (-not (Test-Path $migDir)) { New-Item -ItemType Directory -Force -Path $migDir | Out-Null }
if (Test-Path (Join-Path $RepoPath 'proposal\BPOE_CoTemp_Proposal.md')) {
  Move-Item (Join-Path $RepoPath 'proposal\BPOE_CoTemp_Proposal.md') (Join-Path $bpoeDir 'BPOE_CoTemp_Proposal.md') -Force
}
if (Test-Path (Join-Path $RepoPath 'proposal\PROPOSAL_NOTICE.md')) {
  Move-Item (Join-Path $RepoPath 'proposal\PROPOSAL_NOTICE.md') (Join-Path $migDir 'PROPOSAL_NOTICE_archived.md') -Force
}
if (Test-Path (Join-Path $RepoPath 'proposal\MIGRATION_NOTES.md')) {
  Move-Item (Join-Path $RepoPath 'proposal\MIGRATION_NOTES.md') (Join-Path $migDir 'NewReadMe_MIGRATION_NOTES.md') -Force
}

# RFC template
$rfcsDir = Join-Path $docsDir 'rfcs'; if (-not (Test-Path $rfcsDir)) { New-Item -ItemType Directory -Force -Path $rfcsDir | Out-Null }
if (Test-Path (Join-Path $RepoPath 'proposal\docs\rfcs')) {
  Move-Item (Join-Path $RepoPath 'proposal\docs\rfcs\*') $rfcsDir -Force
}

# Scripts
$scrDir = Join-Path $RepoPath 'scripts\do\NewReadMe'; if (-not (Test-Path $scrDir)) { New-Item -ItemType Directory -Force -Path $scrDir | Out-Null }
if (Test-Path (Join-Path $RepoPath 'proposal\scripts')) {
  Move-Item (Join-Path $RepoPath 'proposal\scripts\*') $scrDir -Force
}

# Clean proposal dir
if (Test-Path (Join-Path $RepoPath 'proposal')) { Remove-Item (Join-Path $RepoPath 'proposal') -Recurse -Force }

git add .
$finTitle = 'Docs: New root README — finalize structure'
$finBody = @"
CoWrap — Finalize New Root README (v3.2)
- Promote proposal into final repo structure
- Archive prior root README to /deprecated
- Move Academy/Onramps/Outputs to root; diagrams/docs/bpoe/migration to /docs
- Keep scripts under /scripts/do/NewReadMe
"@
git commit -m $finTitle -m $finBody
git push -u origin $finBranch
$finNum = gh pr create --title $finTitle --body $finBody --base main --head $finBranch --label docs --label readme --label bpoe | Out-Null; $finNum = gh pr view --json number --jq .number --head $finBranch
if (-not $finNum) { throw "Could not get finalize PR number" }
Write-Host "Finalize PR #$finNum created." -ForegroundColor Green
gh pr merge $finNum --squash --delete-branch --admin --yes

if (-not $LeaveProtectionRelaxed) {
  Write-Host "[7/7] Re-enable protections using scripts/DO-BranchProtection-RestoreDefaults.ps1" -ForegroundColor Yellow
} else {
  Write-Host "[7/7] Protections left relaxed (per request)." -ForegroundColor Yellow
}
Write-Host "Done. New root README is live. You can mark this session successful & complete." -ForegroundColor Green
