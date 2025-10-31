param()

$ErrorActionPreference='Stop'
$root = (git rev-parse --show-toplevel)
$stamp = (Get-Date).ToUniversalTime().ToString("yyyyMMdd-HHmmssZ")
$dl = Join-Path $env:USERPROFILE 'Downloads'
$zip = Join-Path $dl ("AdviceBomb_Vitals_{0}.zip" -f $stamp)

$include = @(
  ".github/workflows/diagram-previews.yml",
  "docs/diagrams/INVENTORY.md",
  "docs/diagrams/render/academy/vital-signs.mmd",
  "docs/diagrams/render/academy/vital-signs.vl.json",
  "docs/diagrams/vitals",
  "data/vitals",
  "tools/vitals"
) | % { Join-Path $root $_ }

# build a temp staging folder
$stage = Join-Path $env:TEMP ("ab_vitals_{0}" -f $stamp)
if(Test-Path $stage){ Remove-Item -Recurse -Force $stage }
New-Item -ItemType Directory -Force $stage | Out-Null
foreach($p in $include){
  if(Test-Path $p){ Copy-Item -Recurse -Force $p $stage }
}

if(Test-Path $zip){ Remove-Item $zip -Force }
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $zip

# sha256 receipt
$sha = (Get-FileHash $zip -Algorithm SHA256).Hash
Set-Content -Encoding UTF8 ($zip + ".sha256") $sha
Write-Host ("Built: {0}`nSHA256: {1}" -f $zip,$sha)

# drop to CoCache inbox if present
$cc = Join-Path $env:USERPROFILE "Documents\GitHub\CoCache\advice\inbox"
if(Test-Path $cc){
  Copy-Item $zip               (Join-Path $cc (Split-Path $zip -Leaf)) -Force
  Copy-Item ($zip + ".sha256") (Join-Path $cc ((Split-Path $zip -Leaf) + ".sha256")) -Force
  $log = Join-Path $cc "INBOX_LOG.md"
  $row = "| $stamp | AdviceBomb_Vitals | $(Split-Path $zip -Leaf) | $sha |"
  if(!(Test-Path $log)){ "# INBOX LOG`n`n| UTC | Kind | File | SHA256 |`n|---|---|---|---|" | Set-Content -Encoding UTF8 $log }
  Add-Content -Encoding UTF8 $log $row
  Write-Host "Dropped to CoCache/advice/inbox and logged."
}
