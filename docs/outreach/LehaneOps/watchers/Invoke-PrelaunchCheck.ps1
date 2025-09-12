$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here

# Very light prelaunch verifier — extend as needed.
$stamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outDir = Join-Path $here "..\reports\prelaunch"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$notes = @()
$notes += "# LehaneOps — Prelaunch Verification ($stamp)"
$notes += ""
$notes += "## Checks"
$notes += "- Confirm target role/title still in scope (manual check via OpenAI site/press)."
$notes += "- Review last 30 days of `LehaneWatch.md` for shifts in priorities."
$notes += "- Re‑confirm pro bono IP/NDA stance ready."
$notes += "- Re‑confirm precursor checklist is ✅."

$notes -join "`r`n" | Out-File -Encoding utf8 (Join-Path $outDir "prelaunch_$stamp.md")
