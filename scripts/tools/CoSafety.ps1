Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Remove-Item alias:ps -ErrorAction SilentlyContinue

function Use-CoLock { param([Parameter(Mandatory)][string]$Name,[scriptblock]$Script)
  $dir = ".admin-backup"; if(-not (Test-Path $dir)){ New-Item -ItemType Directory $dir | Out-Null }
  $lock = Join-Path $dir ("{0}.lock" -f $Name)
  if(Test-Path $lock){ throw "Guard: lock '$Name' exists ($lock). Remove it to re-run." }
  try { New-Item -ItemType File -Path $lock | Out-Null; & $Script } finally { Remove-Item $lock -ErrorAction SilentlyContinue }
}
function Require-CoRepoState {
  param([string]$ExpectRemote='https://github.com/rickballard/CoCivium.git',[string]$RequireBranch,[switch]$AllowDirty)
  $root = (git rev-parse --show-toplevel) 2>$null; if(-not $root){ throw "Not inside a Git repo." }
  $remote = git config --get remote.origin.url; if($ExpectRemote -and $remote -ne $ExpectRemote){ throw "Origin mismatch: $remote" }
  $head = git rev-parse --abbrev-ref HEAD; if($head -eq 'HEAD'){ throw "Detached HEAD. Switch to a branch first." }
  if($RequireBranch -and $head -ne $RequireBranch){ throw "On '$head', expected '$RequireBranch'." }
  if(Test-Path .git\rebase-merge -or Test-Path .git\rebase-apply){ throw "Rebase in progress; finish/abort it first." }
  if(-not $AllowDirty){ $dirty = git status --porcelain; if($dirty){ throw "Working tree not clean.`n$dirty" } }
}
function Confirm-Co { param([Parameter(Mandatory)][string]$Message); if((Read-Host "$Message  Type YES to continue") -ne 'YES'){ throw "Canceled." } }
function Backup-Protections { param([string]$Repo) $out=".admin-backup/main_protection.json"; gh api "repos/$Repo/branches/main/protection" > $out; Write-Host "Backed up protections to $out" }
function Relax-Protections   { param([string]$Repo) Confirm-Co "Relax protections on $Repo main (temporary)";
  @{required_status_checks=$null;enforce_admins=$false;required_pull_request_reviews=$null;restrictions=$null;required_linear_history=$false;allow_force_pushes=$true;allow_deletions=$false;block_creations=$false;required_conversation_resolution=$false;lock_branch=$false;allow_fork_syncing=$false} |
    ConvertTo-Json -Depth 10 | gh api -X PUT "repos/$Repo/branches/main/protection" --input - }
function Restore-Protections { param([string]$Repo) Confirm-Co "Restore protections on $Repo main";
  @{required_status_checks=$null;enforce_admins=$true;required_pull_request_reviews=@{dismiss_stale_reviews=$true;require_code_owner_reviews=$false;required_approving_review_count=1;require_last_push_approval=$false};restrictions=$null;required_linear_history=$true;allow_force_pushes=$false;allow_deletions=$false;block_creations=$false;required_conversation_resolution=$true;lock_branch=$false;allow_fork_syncing=$false} |
    ConvertTo-Json -Depth 10 | gh api -X PUT "repos/$Repo/branches/main/protection" --input - }