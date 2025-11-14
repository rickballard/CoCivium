$ErrorActionPreference="Stop"
$R = (Resolve-Path "$PSScriptRoot\..\..").Path
$roots = @(
  "https://github.com/rickballard/CoCivium",
  "https://github.com/rickballard/CoCache",
  "https://github.com/rickballard/rickballard"
)
$outDir = Join-Path $R "docs\links"
New-Item -ItemType Directory -Force $outDir | Out-Null
$jsonOut = Join-Path $outDir "backlinks.json"
$mdOut   = Join-Path $outDir "BACKLINKS.md"

$files = Get-ChildItem -Path $R -Recurse -Include *.md -File | Where-Object { $_.FullName -notmatch "\\docs\\links\\BACKLINKS.md$" }
$map = @{}
foreach($f in $files){
  $t = Get-Content $f.FullName -Raw
  foreach($root in $roots){
    $rx = [regex]::Escape($root)
    $m = [regex]::Matches($t, "$rx[^\s\)\]]*")
    if($m.Count -gt 0){
      if(-not $map.ContainsKey($root)){ $map[$root] = @() }
      $rel = $f.FullName.Replace($R + [IO.Path]::DirectorySeparatorChar, "")
      $map[$root] += $rel
    }
  }
}

# Write JSON
$obj = @{}
foreach($k in $map.Keys){ $obj[$k] = ($map[$k] | Sort-Object -Unique) }
$obj | ConvertTo-Json -Depth 10 | Set-Content -Encoding utf8 $jsonOut

# Write human MD
$md = @("# Backlinks (bi-directional index)", "")
foreach($k in $map.Keys | Sort-Object){
  $md += "## $k"
  foreach($p in ($map[$k] | Sort-Object -Unique)){ $md += "- $p" }
  $md += ""
}
$md | Set-Content -Encoding utf8 $mdOut
