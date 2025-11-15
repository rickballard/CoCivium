param(
  [string]$RepoRoot = "$(Join-Path $HOME 'Documents\GitHub\CoCivium')"
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

Write-Host ">> Test-CoEthicsLogEntries: validating all entries against schema" -ForegroundColor Cyan

$logRoot = Join-Path $RepoRoot 'docs\CoEthicsGauge\CoEthicsLog'
$schema  = Join-Path $logRoot 'ENTRY_SCHEMA_v0.json'
$entriesRoot = Join-Path $logRoot 'entries'

if (-not (Test-Path $schema)) {
  throw "Schema not found: $schema"
}

if (-not (Test-Path $entriesRoot)) {
  Write-Host "   - No entries directory found; nothing to validate." -ForegroundColor Yellow
  return
}

$files = Get-ChildItem -Path $entriesRoot -Recurse -Filter *.json -ErrorAction SilentlyContinue
if (-not $files) {
  Write-Host "   - No JSON entries found under $entriesRoot" -ForegroundColor Yellow
  return
}

$failCount = 0
foreach ($f in $files) {
  try {
    $ok = Get-Content $f.FullName -Raw | Test-Json -SchemaFile $schema
    if ($ok) {
      Write-Host ("   OK   {0}" -f $f.FullName.Substring($RepoRoot.Length+1)) -ForegroundColor Green
    }
    else {
      Write-Host ("   FAIL {0}" -f $f.FullName.Substring($RepoRoot.Length+1)) -ForegroundColor Red
      $failCount++
    }
  }
  catch {
    Write-Host ("   ERROR {0} -> {1}" -f $f.FullName.Substring($RepoRoot.Length+1), $_.Exception.Message) -ForegroundColor Red
    $failCount++
  }
}

if ($failCount -eq 0) {
  Write-Host ">> Test-CoEthicsLogEntries: all entries validated successfully." -ForegroundColor Green
}
else {
  Write-Host (">> Test-CoEthicsLogEntries: {0} file(s) failed validation." -f $failCount) -ForegroundColor Red
}
