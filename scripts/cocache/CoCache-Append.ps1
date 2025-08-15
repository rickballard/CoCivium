param(
  [Parameter(Mandatory=$true)][string]$Status,
  [string]$RepoRoot = "$HOME\Documents\GitHub\CoCivium",
  [string]$BusRel   = "admin/session-bus/session_bus.jsonl",
  [string]$Session  = "Main",
  [string]$Author   = $env:UserName
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

$Status = $Status.Trim()
if ($Status.Length -gt 180) { $Status = $Status.Substring(0,180) }

if (-not (Test-Path $RepoRoot)) { throw "Repo not found: $RepoRoot" }
if (-not (Test-Path (Join-Path $RepoRoot '.git'))) { throw "Not a git repo: $RepoRoot" }

$BusAbs = Join-Path $RepoRoot $BusRel
$dir = Split-Path $BusAbs -Parent
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
if (-not (Test-Path $BusAbs)) { New-Item -ItemType File -Force -Path $BusAbs | Out-Null }

$ts = (Get-Date).ToString("s")
$line = (@{ ts=$ts; author=$Author; session=$Session; status=$Status; todos=@() } | ConvertTo-Json -Compress)
Add-Content -Path $BusAbs -Value $line

git -C $RepoRoot add -- $BusRel | Out-Null
$short = if($Status.Length -gt 72){ $Status.Substring(0,72) } else { $Status }
git -C $RepoRoot commit -m ("bus: " + $short) | Out-Null
git -C $RepoRoot push | Out-Null

# Optional: mirror to Gist if the Desktop beacon points to a Gist
$Desktop = [Environment]::GetFolderPath('Desktop')
$Beacon  = Join-Path $Desktop 'CoCivBus_Beacon.json'
if (Test-Path $Beacon -and (Get-Command gh -ErrorAction SilentlyContinue)) {
  try {
    $b = Get-Content $Beacon -Raw | ConvertFrom-Json
    $url = [string]$b.bus_url
    if ($url -match "https://gist\.githubusercontent\.com/.+?/([0-9a-f]{20,})/raw/") {
      $GistId = $Matches[1]
      $content = Get-Content $BusAbs -Raw -Encoding UTF8
      $tmp = New-TemporaryFile
      $body = @{ files = @{ "session_bus.jsonl" = @{ content = $content } } } | ConvertTo-Json -Depth 5
      Set-Content -Path $tmp -Value $body -Encoding UTF8
      gh api -X PATCH "gists/$GistId" -H "Accept: application/vnd.github+json" --input "$tmp" | Out-Null
      Remove-Item $tmp -Force
      Write-Host "✅ Gist $GistId mirrored." -ForegroundColor Green
    }
  } catch {
    Write-Warning "Gist mirror skipped: $($_.Exception.Message)"
  }
}
Write-Host "✅ Appended and pushed." -ForegroundColor Green
