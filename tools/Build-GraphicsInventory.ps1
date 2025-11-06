param(
  [Parameter(Mandatory=$true)][string]$Repo,
  [switch]$OpenPR
)
$ErrorActionPreference="Stop"

function Ensure-Dir([string]$p){ if(-not (Test-Path -LiteralPath $p)){ $null = New-Item -ItemType Directory -Force -Path $p } }

# Roots to scan
$rootsSpec = @('docs\diagrams','docs\assets','assets','static','public')
$roots = @()
foreach($r in $rootsSpec){ $p = Join-Path $Repo $r; if(Test-Path -LiteralPath $p){ $roots += $p } }

if(-not $roots){ throw "No asset roots found under $Repo" }

# Output paths
$diagRoot   = Join-Path $Repo 'docs\diagrams'
Ensure-Dir $diagRoot
$invPath    = Join-Path $diagRoot 'INVENTORY.md'
$healthPath = Join-Path $diagRoot 'HEALTHCHECK.md'

# Regex & helpers
$hdrRx    = '^(flowchart|graph|sequenceDiagram|gantt|classDiagram|erDiagram|journey|xychart-beta)\b'
function EscMD([string]$s){ ($s -replace '\|','\|') -replace '`','\`' }
function ReadText($p){ Get-Content -LiteralPath $p -Raw -ErrorAction Stop }

# Collect files
$exts = @('*.mmd','*.vl.json','*.svg','*.png','*.jpg','*.jpeg','*.gif','*.webp','*.d2','*.plantuml','*.pu','*.uml')
$files = @()
foreach($root in $roots){
  $files += Get-ChildItem $root -Recurse -File -Include $exts -ErrorAction SilentlyContinue
}

# Buckets
$rows = @()
$issues_header    = @()
$issues_init      = @()
$issues_nonascii  = @()
$issues_click404  = @()
$issues_vljson    = @()

foreach($f in $files){
  $full   = $f.FullName
  $relAbs = Resolve-Path -LiteralPath $full
  $rel    = ($relAbs.Path.Substring($Repo.Length)).TrimStart('\','/')
  $ext    = $f.Extension.ToLowerInvariant()

  $kind = switch -Regex ($f.Name){
    '.*\.mmd$'      {'Mermaid'}
    '.*\.vl\.json$' {'Vega-Lite'}
    '.*\.svg$'      {'SVG'}
    '.*\.(png|jpg|jpeg|gif|webp)$' {'Raster'}
    '.*\.(d2|plantuml|pu|uml)$' {'OtherDiagram'}
    default {'Other'}
  }

  $title = [IO.Path]::GetFileNameWithoutExtension($f.Name)
  $purpose = $null
  $howTo = $null
  $preview = $null

  $txt = $null
  try{ $txt = ReadText $full }catch{ $txt = $null }

  # Basic Mermaid / VL validation
  $headerOK = $null
  $hasInit  = $false
  $nonAsc   = $false

  if($kind -eq 'Mermaid' -and $txt){
    $first = ($txt -split "`r?`n") | Where-Object {$_ -notmatch '^\s*$'} | Select-Object -First 1
    $headerOK = [bool]($first -match $hdrRx)
    if(-not $headerOK){ $issues_header += $rel }
    $hasInit = [bool]([regex]::Match($txt,'%%\s*\{init:','Singleline').Success)
    if($hasInit){ $issues_init += $rel }
  }
  if($txt){
    if([regex]::Match($txt,'[^\u0000-\u007F]').Success){ $nonAsc = $true; $issues_nonascii += $rel }
  }

  # Mermaid click target 404 detection
  if($kind -eq 'Mermaid' -and $txt){
    $dir = Split-Path -Parent $full
    foreach($line in ($txt -split "`r?`n")){
      if($line -match '^\s*click\s+\S+\s+"([^"]+)"'){
        $tgt = $Matches[1]
        $tgtPath = if([IO.Path]::IsPathRooted($tgt)){ $tgt } else { Join-Path $dir $tgt }
        if(-not (Test-Path -LiteralPath $tgtPath)){
          $relTgt = try { (Resolve-Path -LiteralPath $tgtPath -ErrorAction Stop).Path.Substring($Repo.Length).TrimStart('\','/') } catch { $tgt }
          $issues_click404 += "$rel -> $relTgt"
        }
      }
    }
  }

  # Purpose / How-to extraction (lightweight)
  if($kind -eq 'Mermaid' -and $txt){
    # %% purpose: ...  OR %% use: ...
    $purpose = ($txt -split "`r?`n" | Where-Object { $_ -match '^\s*%%\s*(purpose|use)\s*:\s*(.+)$' } | Select-Object -First 1) `
      | ForEach-Object { ($_.ToString() -replace '^\s*%%\s*(purpose|use)\s*:\s*','').Trim() }
    if(-not $purpose){ $purpose = "TODO: add '%% purpose: ...' comment on the first lines." }
    $howTo = "Embed in Markdown using ```mermaid fences; CI exports previews under docs/diagrams/_previews when available."
  } elseif($kind -eq 'Vega-Lite' -and $txt){
    try{
      $json = $txt | ConvertFrom-Json -ErrorAction Stop
      if($json.description){ $purpose = $json.description }
    }catch{
      $issues_vljson += "$rel :: $($_.Exception.Message -replace "`r?`n",' ')"
    }
    if(-not $purpose){ $purpose = "TODO: add a 'description' field in the JSON root." }
    $howTo = "Render via Vega/Vega-Lite; for docs, include a PNG/SVG export or link to a viewer."
  } elseif($kind -eq 'SVG' -and $txt){
    $titleMatch = [regex]::Match($txt,'<title>(.*?)</title>', 'Singleline')
    if($titleMatch.Success){ $title = $titleMatch.Groups[1].Value.Trim() }
    $purpose = ($txt -split "`r?`n" | Where-Object { $_ -match '^\s*<!--\s*purpose\s*:\s*(.+?)\s*-->\s*$' } | Select-Object -First 1) `
      | ForEach-Object { ($_.ToString() -replace '^\s*<!--\s*purpose\s*:\s*','' -replace '\s*-->\s*$','').Trim() }
    if(-not $purpose){ $purpose = "TODO: add '<!-- purpose: ... -->' near top of SVG." }
    $howTo = "Embed directly in Markdown or include as <img>; prefer SVG for crispness."
  } else {
    if(-not $purpose){ $purpose = "TODO: document purpose." }
    $howTo = "Reference from docs; consider exporting a web-friendly preview."
  }

  # Preview path heuristic (if CI wrote previews)
  $preRoot = Join-Path $Repo 'docs\diagrams\_previews'
  if(Test-Path -LiteralPath $preRoot){
    $relDir = Split-Path -Parent $rel
    # Try file-name match inside _previews\<relDir>
    $tryDir = Join-Path $preRoot $relDir
    if(Test-Path -LiteralPath $tryDir){
      $base = [IO.Path]::GetFileNameWithoutExtension($f.Name)
      $cand = Get-ChildItem $tryDir -File -Include "$base*.svg","$base*.png" -ErrorAction SilentlyContinue | Select-Object -First 1
      if($cand){ $preview = ($cand.FullName.Substring($Repo.Length)).TrimStart('\','/') }
    }
  }
  if(-not $preview){ $preview = $rel } # fallback

  $rows += [pscustomobject]@{
    File        = $rel
    Kind        = $kind
    Title       = $title
    Purpose     = $purpose
    HowToUse    = $howTo
    Preview     = $preview
    HeaderOK    = if($kind -eq 'Mermaid'){ $headerOK } else { $null }
    HasInit     = if($kind -eq 'Mermaid'){ $hasInit } else { $false }
    NonASCII    = $nonAsc
    SizeBytes   = $f.Length
    LastWrite   = $f.LastWriteTimeUtc.ToString('u')
  }
}

# -------- Write INVENTORY.md --------
$md = @()
$md += '# Graphics & Diagrams Inventory'
$md += ''
$md += 'This inventory is generated. For each asset, include a short **purpose** and a quick **how-to-use** tip.'
$md += ''
$md += '| File | Kind | Title | Purpose | How to Use | Preview |'
$md += '|---|---|---|---|---|---|'
foreach($r in $rows | Sort-Object File){
  $md += ('| {0} | {1} | {2} | {3} | {4} | {5} |' -f
    (EscMD $r.File), (EscMD $r.Kind), (EscMD $r.Title), (EscMD $r.Purpose),
    (EscMD $r.HowToUse), (EscMD $r.Preview))
}
[IO.File]::WriteAllLines($invPath, $md, [Text.UTF8Encoding]::new($false))

# -------- Append Inventory Refresh to HEALTHCHECK.md --------
if(-not (Test-Path -LiteralPath $healthPath)){
  [IO.File]::WriteAllText($healthPath, "# Diagrams Healthcheck`n`n", [Text.UTF8Encoding]::new($false))
}
$utc = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd HH:mm:ss 'UTC'")
$h = @()
$h += '---'
$h += "## Inventory Refresh — $utc"
$h += ''
$h += ("- Assets scanned: {0}" -f $rows.Count)
$h += ("- Mermaid without header first line: {0}" -f $issues_header.Count)
$h += ("- Mermaid with `%%{{init}}%%`: {0}" -f $issues_init.Count)
$h += ("- Files with non-ASCII: {0}" -f $issues_nonascii.Count)
$h += ("- Broken Mermaid `click` targets: {0}" -f $issues_click404.Count)
$h += ("- Invalid Vega-Lite JSON: {0}" -f $issues_vljson.Count)
$h += ''
function Block([string]$title, $items){
  $o=@(); $o+="### $title"; if(-not $items -or $items.Count -eq 0){ $o+= "_None_"; return $o }
  $o+='';
  foreach($i in $items){ $o+= "- $i" }
  return $o
}
$h += Block "Mermaid header not first line", $issues_header
$h += ''; $h += Block "Found Mermaid init directives (remove)", $issues_init
$h += ''; $h += Block "Non-ASCII present (scrub)", $issues_nonascii
$h += ''; $h += Block "Broken `click` targets (source -> resolved path)", $issues_click404
$h += ''; $h += Block "Invalid Vega-Lite JSON (file :: error)", $issues_vljson
Add-Content -LiteralPath $healthPath -Value ($h -join "`n") -Encoding UTF8

# -------- PR & previews --------
Push-Location $Repo
try{
  $branch = ('chore/graphics-inventory_{0:yyyyMMdd-HHmmss}' -f (Get-Date))
  git switch -c $branch | Out-Null
  git add -- docs/diagrams/INVENTORY.md docs/diagrams/HEALTHCHECK.md
  git commit -m "chore(diagrams): refresh graphics inventory + healthcheck (purpose/how-to/preview columns)"
  git push --set-upstream origin $branch | Out-Null
  $pr = gh pr create -f -t "chore(diagrams): graphics inventory + healthcheck refresh" -b "Adds rich **INVENTORY.md** (purpose/how-to/preview) and appends counts to **HEALTHCHECK.md**."
  gh workflow run ".github/workflows/diagram-previews.yml" --ref $branch | Out-Null
  "PR: $pr"
}
finally{ Pop-Location }
