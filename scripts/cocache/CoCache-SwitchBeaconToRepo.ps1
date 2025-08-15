param(
  [string]$RepoRoot = "$HOME\Documents\GitHub\CoCivium",
  [string]$BusRel   = "admin/session-bus/session_bus.jsonl"
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
if (-not (Test-Path $RepoRoot)) { throw "Repo not found: $RepoRoot" }
if (-not (Test-Path (Join-Path $RepoRoot '.git'))) { throw "Not a git repo: $RepoRoot" }

$remote = (git -C $RepoRoot remote get-url origin).Trim()
if ($remote -notmatch "github\.com[:/](.+?)/(.+?)(?:\.git)?$") { throw "Cannot parse origin: $remote" }
$Owner  = $Matches[1]; $Repo = $Matches[2]
$Branch = (git -C $RepoRoot rev-parse --abbrev-ref HEAD)
$RawRepoURL = "https://raw.githubusercontent.com/$Owner/$Repo/$Branch/$BusRel"

$Beacon = Join-Path ([Environment]::GetFolderPath('Desktop')) 'CoCivBus_Beacon.json'
if (-not (Test-Path $Beacon)) { throw "Beacon not found: $Beacon" }
$b = Get-Content $Beacon -Raw | ConvertFrom-Json
$b.bus_url = $RawRepoURL
($b | ConvertTo-Json -Depth 5) | Set-Content -Path $Beacon -Encoding UTF8
Write-Host "✅ Beacon set to:`n   $RawRepoURL" -ForegroundColor Green
