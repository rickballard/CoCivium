param([Parameter(Mandatory)][string]$Note)
$dest = Join-Path $PSScriptRoot '..\docs\bpoe\LESSONS.md'
$line = "- $(Get-Date -Format s) — $Note"
New-Item -ItemType Directory -Force (Split-Path $dest) | Out-Null
Add-Content -Path $dest -Value $line -Encoding utf8NoBOM
Write-Host "LESSONS.md +1"
