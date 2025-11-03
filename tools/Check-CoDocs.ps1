param([string]$Root = ".")
$ErrorActionPreference="Stop"
$bad = @()

# Rule A: no em dashes in Markdown
$emd = Get-ChildItem $Root -Recurse -Include *.md | Select-String '—' -SimpleMatch
if($emd){ $bad += "Em dash found in: " + ($emd | Select-Object -ExpandProperty Path -Unique) }

# Rule B: no backticked internal doc paths `docs/...`
$bt  = Get-ChildItem $Root -Recurse -Include *.md | Select-String '`docs/' -SimpleMatch
if($bt){ $bad += "Backticked internal path found in: " + ($bt | Select-Object -ExpandProperty Path -Unique) }

if($bad.Count){
  $bad | ForEach-Object { Write-Host $_ }
  exit 1
}
Write-Host "Docs check passed."
