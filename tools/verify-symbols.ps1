Param([switch]$Accept)
$ErrorActionPreference='Stop'
$manifest = "docs/symbols/MANIFEST.lock"
$gibDir   = "site/assets/gib"
if(-not (Test-Path $gibDir)){ Write-Host "No glyph dir."; exit 0 }
$files = @(Get-ChildItem $gibDir -Filter *.svg -File | Sort-Object Name)
$curr  = foreach($f in $files){
  $raw   = Get-Content $f.FullName -Raw
  $sha   = [Convert]::ToHexString([Security.Cryptography.SHA256]::Create().ComputeHash([Text.Encoding]::UTF8.GetBytes($raw))).ToLower()
  [pscustomobject]@{ slug=[IO.Path]::GetFileNameWithoutExtension($f.Name); path=$f.FullName.Replace("$PWD\","").Replace("\","/"); sha256=$sha }
}
if(-not (Test-Path $manifest)){
  if($Accept){ $curr | ConvertTo-Json -Depth 3 | Set-Content -Encoding utf8 $manifest; exit 0 }
  Write-Error "Missing $manifest. Run: pwsh tools/verify-symbols.ps1 -Accept && commit."
  exit 1
}
$old = Get-Content $manifest -Raw | ConvertFrom-Json
$oldMap = @{}; foreach($o in $old){ $oldMap[$o.slug]=$o }
$changes=@()
foreach($c in $curr){
  if(-not $oldMap.ContainsKey($c.slug)){ $changes += "NEW:$($c.slug)"; continue }
  if($oldMap[$c.slug].sha256 -ne $c.sha256){ $changes += "CHANGED:$($c.slug)" }
}
foreach($o in $oldMap.Keys){
  if(-not ($curr | Where-Object slug -eq $o)){ $changes += "REMOVED:$o" }
}
if($changes.Count -gt 0){
  if($Accept){
    $curr | ConvertTo-Json -Depth 3 | Set-Content -Encoding utf8 $manifest
    Write-Host "Manifest updated."
    exit 0
  }
  Write-Error ("Symbol set changed: " + ($changes -join ', ') + "`nIf intended, run: pwsh tools/verify-symbols.ps1 -Accept && commit.")
  exit 1
}
Write-Host "Symbols match manifest."
