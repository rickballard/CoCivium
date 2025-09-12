param(
  [Parameter(Mandatory)][int]$PR,
  [string]$Subject = "Admin squash-merge",
  [string]$Tag
)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

if (-not (gh auth status 2>$null)) { throw "gh auth required" }
$state = (gh pr view $PR --json state -q .state).Trim()
if ($state -ne 'MERGED') {
  gh pr merge $PR --squash --delete-branch=false --subject $Subject --admin | Out-Null
  if ((gh pr view $PR --json state -q .state).Trim() -ne 'MERGED') { throw "Merge failed/blocked" }
}

git fetch origin --prune | Out-Null
git switch main | Out-Null
git reset --hard origin/main

if ($Tag) {
  git tag -fa $Tag -m "$Subject (PR #$PR)"
  git push -f origin "refs/tags/$Tag"
  Write-Host "✓ Moved tag '$Tag' to $(git rev-parse --short HEAD)"
} else {
  Write-Host "✓ Merged PR #$PR"
}