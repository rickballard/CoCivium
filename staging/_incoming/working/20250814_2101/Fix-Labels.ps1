param(
  [string]$RepoSlug = "rickballard/CoCivium",
  [string]$Labels = "content,outreach"
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$branch = (git rev-parse --abbrev-ref HEAD)
$prnum  = gh pr list -R $RepoSlug --head $branch --json number -q '.[0].number'
if(!$prnum){ Write-Error "No PR found for branch $branch"; exit 1 }

# Ensure labels exist
$existing = gh label list -R $RepoSlug --json name -q '.[].name'
$want = $Labels.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ }
foreach($w in $want){
  if($existing -notcontains $w){
    gh label create $w -R $RepoSlug --color "0E8A16" --description "Auto-created" | Out-Null
  }
}
# Apply labels
gh pr edit $prnum -R $RepoSlug --add-label ($want -join ',') | Out-Null
Write-Host "Labels applied to PR #${prnum}: $($want -join ',')"