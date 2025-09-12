# Stage → branch → push → PR
''|Out-Null
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$RepoPath   = Join-Path $HOME 'Documents\GitHub\CoCivium'
$StagePath  = Join-Path $HOME 'Downloads\CoTemp\NewReadMe\proposal'
$BranchName = 'docs/new-root-readme_proposal_{0}' -f (Get-Date -Format 'yyyyMMdd_HHmm')
$PrTitle    = 'Docs: New root README + Onramps/Outputs (Proposal)'
$Labels     = @('docs','proposal','bpoe','readme','academy','onramps','outputs')

if (-not (Test-Path $RepoPath)) { throw "Repo not found: $RepoPath" }
if (-not (Test-Path $StagePath)) { throw "Stage not found: $StagePath" }
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "git not found" }
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw "gh not found" }

Set-Location $RepoPath
git fetch --all
git checkout main
git pull --ff-only
git checkout -b $BranchName

$Dest = Join-Path $RepoPath 'proposal'
if (Test-Path $Dest) { Remove-Item $Dest -Recurse -Force }
New-Item -ItemType Directory -Force -Path $Dest | Out-Null
Copy-Item -Path (Join-Path $StagePath '*') -Destination $Dest -Recurse -Force

git add proposal
$wrap = @"
CoWrap — New Root README Proposal (v3.2)

- Navigational root README
- Comprehensive Outputs taxonomy (policies, standards/specs, artefacts/tools, records)
- Out-of-scope constraints to prevent scope creep
- Badges/status mini-spec; RFC template
- Congruence rubric; Records logging for badges
- CoTemp BPOE guidance; notices; diagrams
"@
git commit -m $PrTitle -m $wrap
git push -u origin $BranchName

$labelArgs = @(); foreach($l in $Labels){ $labelArgs += @('--label', $l) }
gh pr create --title $PrTitle --body $wrap --base main --head $BranchName @labelArgs | Out-Null
Write-Host "Proposal PR opened. Review → HumanGate → squash-merge." -ForegroundColor Green
