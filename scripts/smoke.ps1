param(
  [string]$Path = "README.md"
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
if (-not $repo) { $repo = (Get-Location).Path }

Write-Host "== CoCivium smoke check ==" -ForegroundColor Cyan
Write-Host "Repo: $repo"
Write-Host "File: $Path"

# Read text and bytes
$full = Join-Path $repo $Path
if (!(Test-Path $full)) {
  Write-Host "✗ File not found: $full" -ForegroundColor Red
  exit 1
}
$bytes = [IO.File]::ReadAllBytes($full)
$txt   = [IO.File]::ReadAllText($full, [Text.UTF8Encoding]::new($false))  # decode as UTF-8 (no BOM)

# 1) Encoding: no BOM
if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
  Write-Host "✗ UTF-8 BOM detected; please save without BOM." -ForegroundColor Red
  $fail = $true
} else {
  Write-Host "✓ No BOM" -ForegroundColor Green
}

# 2) Encoding: no mojibake markers
$fffd = [string][char]0xFFFD
if ($txt -match 'Ã|Â' -or $txt.Contains($fffd)) {
  Write-Host "✗ Mojibake markers found (Ã, Â, or �). Fix encoding." -ForegroundColor Red
  $fail = $true
} else {
  Write-Host "✓ No mojibake markers" -ForegroundColor Green
}

# 3) Line endings: LF only, and final newline
if ($txt -match "`r") {
  Write-Host "✗ CR characters detected; convert to LF only." -ForegroundColor Red
  $fail = $true
} else {
  Write-Host "✓ LF line endings" -ForegroundColor Green
}
if (-not $txt.EndsWith("`n")) {
  Write-Host "✗ Missing final newline at EOF." -ForegroundColor Yellow  # warn only
}

# 4) Collect referenced local asset paths
$paths = @()
$paths += [regex]::Matches($txt,'!\[[^\]]*\]\(([^)\s]+)(?:\s+"[^"]*")?\)') | ForEach-Object { $_.Groups[1].Value }
$paths += [regex]::Matches($txt,'<img[^>]+src=["'']([^"'']+)["'']')       | ForEach-Object { $_.Groups[1].Value }
$paths = $paths | Where-Object { $_ -like './*' -or $_ -like 'assets/*' } | ForEach-Object { $_.Trim() -replace '^\./','' } | Sort-Object -Unique

if ($paths.Count -gt 0) {
  Write-Host "Assets referenced:"
  foreach($p in $paths){
    $local = Join-Path $repo $p
    if (Test-Path $local) {
      Write-Host ("  ✓ {0}" -f $p) -ForegroundColor Green
    } else {
      Write-Host ("  ✗ MISSING: {0}" -f $p) -ForegroundColor Red
      $fail = $true
    }
  }
} else {
  Write-Host "No local asset references detected."
}

if ($fail) {
  exit 1
} else {
  Write-Host "All checks passed." -ForegroundColor Green
  exit 0
}
