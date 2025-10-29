param(
  [string]$RepoRoot = (Resolve-Path "$PSScriptRoot\..").Path
)
$ErrorActionPreference='Stop'
function Rel([string]$abs,[string]$root){ ($abs.Substring($root.Length+1) -replace '\\','/') }

$Utf8 = [Text.UTF8Encoding]::new($false)
$diagDir   = Join-Path $RepoRoot 'docs\diagrams'
$renderDir = Join-Path $diagDir 'render'
$metaDir   = Join-Path $diagDir 'meta'
$indexHtml = Join-Path $diagDir 'index.html'
$styleCss  = Join-Path $diagDir 'style.css'

# Collect artifacts
$items = @{}
Get-ChildItem -Path $renderDir -File -Include *.mmd,*.svg,*.png -Recurse | ForEach-Object {
  $rel  = Rel $_.FullName $RepoRoot
  $base = $rel -replace '\.(mmd|svg|png)$',''
  if(-not $items.ContainsKey($base)){ $items[$base] = [ordered]@{ mmd=$null; svg=$null; png=$null } }
  switch -Regex ($rel){
    '\.mmd$' { $items[$base].mmd = $rel }
    '\.svg$' { $items[$base].svg = $rel }
    '\.png$' { $items[$base].png = $rel }
  }
}

# Load meta
$meta = @{}
Get-ChildItem -Path $metaDir -File -Filter *.json -ErrorAction SilentlyContinue | ForEach-Object {
  try{
    $o = Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json
    $src = ($o.source -as [string]); if([string]::IsNullOrWhiteSpace($src)){ return }
    $src = $src.TrimStart('/')
    $base = $src -replace '\.(mmd|svg|png)$',''
    $meta[$base] = $o
  }catch{}
}

# Write style.css (vanilla, responsive grid)
$css = @"
:root{
  --bg: #0d1117; --fg:#c9d1d9; --mut:#8b949e; --card:#161b22; --line:#30363d; --pill:#21262d;
}
*{box-sizing:border-box}
body{margin:0;padding:32px;background:var(--bg);color:var(--fg);font:14px/1.5 system-ui,Segoe UI,Roboto,Helvetica,Arial}
a{color:#58a6ff;text-decoration:none}
a:hover{text-decoration:underline}
.header{max-width:1400px;margin:0 auto 16px auto}
.header h1{margin:0 0 6px 0;font-size:22px}
.header .tip{color:var(--mut)}
.grid{max-width:1400px;margin:0 auto;display:grid;grid-template-columns:repeat(12,1fr);gap:16px}
.card{grid-column:span 12;background:var(--card);border:1px solid var(--line);border-radius:12px;overflow:hidden}
@media(min-width:900px){ .card{grid-column:span 6} }
@media(min-width:1300px){ .card{grid-column:span 4} }
.card .media{background:#0b0e12;border-bottom:1px solid var(--line);display:flex;align-items:center;justify-content:center;min-height:360px}
.card .media img{max-width:100%;max-height:420px;display:block;background:transparent}
.card .media .ph{width:100%;height:420px;border:2px dashed #444;border-radius:10px;opacity:.6}
.card .body{padding:14px}
.row{display:flex;gap:10px;flex-wrap:wrap;margin:8px 0 0 0}
.pill{background:var(--pill);border:1px solid var(--line);border-radius:999px;padding:4px 8px;color:var(--mut);font-size:12px}
.meta a{margin-right:8px}
.footer{max-width:1400px;margin:24px auto 0 auto;color:var(--mut);font-size:12px}
"@
[IO.File]::WriteAllText($styleCss,$css,$Utf8)

# Build cards
$cards = [System.Collections.Generic.List[string]]::new()
foreach($base in ($items.Keys | Sort-Object)){
  $rec = $items[$base]
  $name = ($base -replace '^docs/diagrams/render/','')
  $disp = ($name -replace '/',' › ')
  $metaObj = $null
  if($meta.ContainsKey($base)){ $metaObj = $meta[$base] } else {
    $tmp = $rec.mmd; if(-not $tmp){ $tmp = $rec.svg }; if(-not $tmp){ $tmp = $rec.png }
    if($tmp){ $tryKey = $tmp -replace '\.(mmd|svg|png)$',''; if($meta.ContainsKey($tryKey)){ $metaObj = $meta[$tryKey] } }
  }
  $title   = if($metaObj -and $metaObj.title){ [string]$metaObj.title } else { $disp }
  $caption = if($metaObj -and $metaObj.caption){ [string]$metaObj.caption } else { '' }
  $tags    = if($metaObj -and $metaObj.tags){ ($metaObj.tags -join ", ") } else { '' }

  $media = "<div class='ph'></div>"
  if($rec.svg){ $media = "<img src='/$($rec.svg)' alt='$disp' loading='lazy'/>" }
  elseif($rec.png){ $media = "<img src='/$($rec.png)' alt='$disp' loading='lazy'/>" }

  $files = @(); if($rec.mmd){ $files += "<a href='/$($rec.mmd)'>mmd</a>" }; if($rec.svg){ $files += "<a href='/$($rec.svg)'>svg</a>" }; if($rec.png){ $files += "<a href='/$($rec.png)'>png</a>" }
  $filesCell = if($files){ ($files -join " · ") } else { "—" }

  $issueTitle = "Diagram: $name"
  $bodyLines = @("Please review this diagram.","","Files:",(if($rec.mmd){"- /$($rec.mmd)"}),(if($rec.svg){"- /$($rec.svg)"}),(if($rec.png){"- /$($rec.png)"}),"","Context: docs/diagrams pipeline.") | Where-Object { $_ -ne $null }
  $issueUrl = "https://github.com/$env:GITHUB_REPOSITORY/issues/new" # fallback if running in CI
  if(-not $env:GITHUB_REPOSITORY){ $issueUrl = "https://github.com/$($env:Owner ?? "rickballard")/$($env:Repo ?? "CoCivium")/issues/new" }
  $issueUrl += "?title=" + [uri]::EscapeDataString($issueTitle) + "&body=" + [uri]::EscapeDataString(($bodyLines -join "`n")) + "&labels=diagram,design&assignees=rickballard"

  $cards.Add(@"
<div class='card'>
  <div class='media'>$media</div>
  <div class='body'>
    <h3>$title</h3>
    <div class='meta'><span class='pill'>$disp</span> $(if($tags){"<span class='pill'>$tags</span>"}else{''})</div>
    $(if($caption){"<p>$caption</p>"}else{''})
    <div class='row'><strong>Files:</strong> $filesCell</div>
    <div class='row'><a href='$issueUrl'>Open issue</a></div>
  </div>
</div>
"@)
}

# Write index.html
$stamp = (Get-Date).ToUniversalTime().ToString('yyyy-MM-dd HH:mm:ss') + " UTC"
$html = @"
<!doctype html>
<html lang="en">
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<title>CoCivium — Diagrams Gallery</title>
<link rel="preload" href="style.css" as="style"><link rel="stylesheet" href="style.css">
<body>
  <div class="header">
    <h1>Diagrams Gallery</h1>
    <div class="tip">Generated from docs/diagrams/render + meta (last updated: $stamp)</div>
    <p><a href="../DIAGRAMS.md">Docs page</a> · <a href="INVENTORY.md">Inventory (blob)</a></p>
  </div>
  <div class="grid">
    $($cards -join "`n")
  </div>
  <div class="footer">No corruption, no coercion, no crowns.</div>
</body>
</html>
"@
[IO.File]::WriteAllText($indexHtml,$html,$Utf8)

Write-Host "Gallery built: $indexHtml"