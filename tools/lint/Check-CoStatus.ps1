param(
  [string]$RepoRoot = (Get-Location).Path,
  [int]$MaxAgeDays = 365
)
$ErrorActionPreference='Stop'

$adopt = Join-Path $RepoRoot 'docs\advice\costatus\ADOPT.md'
if (!(Test-Path $adopt)) {
  Write-Error "Missing docs/advice/costatus/ADOPT.md"
  exit 20
}

if (-not (Select-String -LiteralPath $adopt -Pattern 'Use-CoStatus' -Quiet)) {
  Write-Error "ADOPT.md present but missing 'Use-CoStatus' loader"
  exit 21
}

$age = (Get-Date) - (Get-Item $adopt).LastWriteTimeUtc
if ($age.TotalDays -gt $MaxAgeDays) {
  Write-Warning "ADOPT.md older than $MaxAgeDays days"
}

Write-Host "CoStatus guard: OK" -ForegroundColor Green