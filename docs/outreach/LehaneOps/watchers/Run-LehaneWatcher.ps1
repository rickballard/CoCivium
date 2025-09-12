param(
  [string]$ConfigPath = ".\watch.config.json"
)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

function Load-Json($p){
  if (!(Test-Path $p)) { throw "Missing config at $p (copy watchers\watch.sample.json to watchers\watch.config.json)" }
  Get-Content -Raw -LiteralPath $p | ConvertFrom-Json
}

$cfg = Load-Json -p $ConfigPath

# Resolve paths relative to this script
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here

$rawDir = Resolve-Path (Join-Path $here $cfg.output.raw_json_dir) -ErrorAction SilentlyContinue
if (-not $rawDir) {
  New-Item -ItemType Directory -Force -Path (Join-Path $here $cfg.output.raw_json_dir) | Out-Null
  $rawDir = Resolve-Path (Join-Path $here $cfg.output.raw_json_dir)
}

$now = Get-Date
$sessionId = $now.ToString("yyyyMMdd_HHmmss")

$results = @()

foreach($src in $cfg.sources){
  try{
    if($src.type -eq "rss"){
      $xml = Invoke-WebRequest -UseBasicParsing -Uri $src.url -TimeoutSec 20 | Select-Object -ExpandProperty Content | Out-String
      [xml]$rss = $xml
      foreach($item in $rss.rss.channel.item){
        $results += [pscustomobject]@{
          source = $src.name
          title  = $item.title
          link   = $item.link
          pubDate= $item.pubDate
        }
      }
    } else {
      # future: html/json handlers
    }
  } catch {
    $results += [pscustomobject]@{ source=$src.name; title="ERROR: $($_.Exception.Message)"; link=""; pubDate=$null }
  }
}

# Filter by keywords
$keywords = $cfg.targets[0].keywords
$filtered = $results | Where-Object {
  $t = $_.title
  ($keywords | ForEach-Object { $t -match [regex]::Escape($_) }) -contains $true
}

# Save raw json
$rawPath = Join-Path $rawDir "$sessionId.json"
$filtered | ConvertTo-Json -Depth 6 | Out-File -Encoding utf8 $rawPath

# Update report
$report = Resolve-Path (Join-Path $here $cfg.output.report_markdown) -ErrorAction SilentlyContinue
if (-not $report) {
  $rp = Join-Path $here $cfg.output.report_markdown
  New-Item -ItemType File -Force -Path $rp | Out-Null
  $report = Resolve-Path $rp
}

$lines = @()
$lines += "# Lehane Watch — Rolling Digest"
$lines += ""
$lines += "*Last update:* " + $now.ToString("yyyy-MM-dd HH:mm:ss zzz")
$lines += ""
$lines += "## Matches (filtered by target keywords)"
if($filtered.Count -eq 0){
  $lines += "- _No new relevant items found in this session_."
} else {
  foreach($r in $filtered | Select-Object -First 30){
    $date = if($r.pubDate){ [DateTime]::Parse($r.pubDate).ToString("yyyy-MM-dd") } else { "" }
    $lines += ("- **{0}** — [{1}]({2})" -f $date, $r.title, $r.link)
  }
}
$lines += ""
$lines += "## Sources"
foreach($s in $cfg.sources){
  $lines += ("- {0}: {1}" -f $s.name, $s.url)
}
$lines += ""
$lines += "> Configurable via `watchers\\watch.config.json`. Controlled frequency. Public sources only."

$lines -join "`r`n" | Out-File -Encoding utf8 $report.Path
