function Invoke-CoEnvelope {
  param(
    [Parameter(Mandatory)][string]$Code,
    [string]$Tag = ("COBLOCK-{0:yyyyMMdd_HHmmssfff}" -f (Get-Date))
  )
  $tmp = Join-Path $env:TEMP ("{0}.ps1" -f $Tag)
  # Write with BOM so WinPS 5.1 parses UTF-8 safely if we ever fall back.
  Set-Content -Path $tmp -Value $Code -Encoding UTF8BOM
  # Prefer PowerShell 7 (pwsh); fallback to Windows PowerShell if needed.
  $hostExe = (Get-Command pwsh -EA SilentlyContinue)?.Source
  if(-not $hostExe){ $hostExe = (Get-Command powershell -EA SilentlyContinue)?.Source }
  if(-not $hostExe){ throw "No PowerShell engine found (pwsh/powershell)." }
  try{
    Write-Host ">> [$Tag] START"
    & $hostExe -NoProfile -ExecutionPolicy Bypass -File $tmp
    $rc = $LASTEXITCODE
    Write-Host ">> [$Tag] END (rc=$rc)"
  } finally {
    Remove-Item $tmp -Force -ErrorAction SilentlyContinue
  }
}
