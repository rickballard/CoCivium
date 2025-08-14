param(
  [Parameter(Mandatory)] [string] $Owner,
  [Parameter(Mandatory)] [string] $Repo,
  [string] $Branch = 'main',
  [Parameter(Mandatory)] [string[]] $PRs,
  [ValidateSet('s','m','r')] [string] $Strategy = 's',
  [switch] $DryRun
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$Token = $env:ADMIN_PAT; if(-not $Token){ $Token = gh auth token }
if(-not $Token){ throw "No token found. Set ADMIN_PAT or run 'gh auth login'." }
$H=@{Authorization="Bearer $Token";Accept='application/vnd.github+json';'Content-Type'='application/json';'X-GitHub-Api-Version'='2022-11-28'}
$PRR="https://api.github.com/repos/$Owner/$Repo/branches/$Branch/protection/required_pull_request_reviews"
function Get-PRR { Invoke-RestMethod -Method GET -Uri $PRR -Headers $H }
function Patch-PRR([hashtable]$Body){ if($DryRun){ Write-Host "DRYRUN PATCH $($Body|ConvertTo-Json -Compress)"; return }; Invoke-RestMethod -Method PATCH -Uri $PRR -Headers $H -Body ($Body|ConvertTo-Json -Compress) | Out-Null }
$bk = Get-PRR
$bkFile = "$env:TEMP\prr-$Repo-$Branch-$((Get-Date).ToString('yyyyMMdd_HHmmss')).json"
$bk | ConvertTo-Json -Depth 8 | Set-Content -Encoding utf8 $bkFile
$patch = [ordered]@{ dismiss_stale_reviews=[bool]$bk.dismiss_stale_reviews; require_code_owner_reviews=$false; required_approving_review_count=0; require_last_push_approval=$false }
Patch-PRR $patch
$results=@()
foreach($n in $PRs){
  try{
    if($DryRun){ Write-Host "DRYRUN gh pr merge $n -R $Owner/$Repo -$Strategy --admin" } else { gh pr merge $n -R "$Owner/$Repo" "-$Strategy" --admin | Out-Null }
    $v = gh pr view $n -R "$Owner/$Repo" --json number,state,mergedAt,mergeCommit | ConvertFrom-Json
    $results += [pscustomobject]@{ PR="#$($v.number)"; State=$v.state; MergedAt=$v.mergedAt; SHA=$v.mergeCommit.oid }
  } catch { $results += [pscustomobject]@{ PR="#$n"; State="ERROR"; MergedAt=$null; SHA=$null } }
}
if(-not $DryRun){ $orig = Get-Content -Raw $bkFile; Invoke-RestMethod -Method PATCH -Uri $PRR -Headers $H -Body $orig | Out-Null }
$results | Format-Table -AutoSize
