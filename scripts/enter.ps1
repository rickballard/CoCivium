param([string]$RepoPath = "C:\Users\Chris\Documents\GitHub\CoCivium", [switch]$Force)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
if(!(Test-Path -LiteralPath $RepoPath)){ throw "Repo not found: $RepoPath" }
if(-not $Force){ $ans = Read-Host "Enter repo? Enter=continue, N=cancel"; if($ans -match '^(n|no)$'){ Write-Host "Cancelled."; return } }
$lockName = "Global\EnterRepo-"+([IO.Path]::GetFullPath($RepoPath).ToLowerInvariant().GetHashCode())
$mutex = [Threading.Mutex]::new($false,$lockName)
if(-not $mutex.WaitOne(0)){ Write-Host "Already running for $RepoPath."; return }
try { Set-Location -LiteralPath $RepoPath; git status -sb }
finally { $mutex.ReleaseMutex() | Out-Null; $mutex.Dispose() }
