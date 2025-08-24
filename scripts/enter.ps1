param([string]$RepoPath = "$HOME\Documents\GitHub\CoCivium", [switch]$Force)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
if(!(Test-Path -LiteralPath $RepoPath)){ throw "Repo not found: $RepoPath" }
if(-not $Force){
  $ans = Read-Host "Enter repo? Enter=continue, N=cancel"
  if($ans -match '^(n|no)$'){ Write-Host "Cancelled."; return }
}
$mutex = [Threading.Mutex]::new($false,"Global\EnterRepo-"+$PID)
if(-not $mutex.WaitOne(0)){ Write-Host "Already running."; return }
try {
  Set-Location -LiteralPath $RepoPath
  git status -sb
} finally {
  $mutex.ReleaseMutex() | Out-Null
  $mutex.Dispose()
}
