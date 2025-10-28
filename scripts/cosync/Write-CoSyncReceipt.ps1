param(
  [string]$OutDir = ".\out",
  [string]$Session = "CoPrime",
  [string]$Scope = "",
  [string]$Changes = "",
  [string]$Todos = "",
  [string]$CiSummary = "",
  [string]$Risks = "",
  [string]$Assumptions = ""
)
$ErrorActionPreference='Stop'
if(!(Test-Path $OutDir)){ New-Item -ItemType Directory -Force -Path $OutDir | Out-Null }
$utc = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd HH:mm:ssZ")
$md = @()
$md += "# RECEIPT"
$md += ""
$md += "- when: $utc"
$md += "- session: $Session"
$md += "- scope: $Scope"
$md += ""
$md += "## changes"
$md += "$Changes"
$md += ""
$md += "## next-3"
$md += "$Todos"
$md += ""
$md += "## CI"
$md += "$CiSummary"
$md += ""
$md += "## risks/assumptions"
$md += "$Risks"
$md += "$Assumptions"
$path = Join-Path $OutDir "RECEIPT.md"
$md -join "`r`n" | Set-Content -Encoding UTF8 $path
Write-Host "Wrote $path"
