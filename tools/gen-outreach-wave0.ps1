param(
  [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot),
  [string]$CsvPath
)

# BPOE-PwshBounce (must appear AFTER param so PS5 stays happy)
if ($PSVersionTable.PSVersion.Major -lt 7) {
  $cmd = Get-Command pwsh -ErrorAction SilentlyContinue
  if ($cmd) { & $cmd.Source -NoProfile -File $PSCommandPath @args; exit $LASTEXITCODE }
}

$ErrorActionPreference = 'Stop'

if (-not $CsvPath) {
  $CsvPath = Join-Path $RepoRoot 'outreach\projects\outreach-stage-seed\CoCivium_outreach_leads_v0.2.csv'
}
if (-not (Test-Path $CsvPath)) {
  Write-Host "[TODO] CSV not found: $CsvPath"
  exit 0
}

$OutTpl = Join-Path $RepoRoot 'outreach\projects\outreach-stage-seed\templates'
New-Item -ItemType Directory -Force -Path $OutTpl | Out-Null

$rows = Import-Csv $CsvPath

# Normalize score
foreach ($r in $rows) {
  $v  = $r.'PriorityScore(0-100)'
  $v2 = if ($null -ne $v) { ($v -replace '[^0-9\.\-]','') } else { '0' }
  if ([string]::IsNullOrWhiteSpace($v2)) { $v2 = '0' }
  $r.'PriorityScore(0-100)' = [double]$v2
}

$top = $rows | Sort-Object {[double]($_.'PriorityScore(0-100)')} -Descending | Select-Object -First 6

function Get-Val($row, $prop, $fallback='') {
  $v = $row.$prop
  if ($null -eq $v) { return $fallback }
  if ($v -is [string] -and [string]::IsNullOrWhiteSpace($v)) { return $fallback }
  return $v
}

function Pick-Theme($r) {
  foreach ($k in @('KeyPhrases','Role/Focus','WhyApproach')) {
    $val = Get-Val $r $k ''
    if ($val) {
      $t = ($val -split '[,;]')[0].Trim()
      if ($t.Length -gt 90) { return ($t.Substring(0,87) + '...') } else { return $t }
    }
  }
  return 'governance-by-design'
}

# Build first-lines markdown
$sb = New-Object System.Text.StringBuilder
$null = $sb.AppendLine('# Wave-0: first-line openers (top 6)')
$null = $sb.AppendLine()

foreach ($r in $top) {
  $name  = Get-Val $r 'Name' 'there'
  $aff   = Get-Val $r 'Affiliation' ''
  $url   = Get-Val $r 'ContactURL' ''
  $ask   = Get-Val $r 'Ask' ''
  $score = [int](Get-Val $r 'PriorityScore(0-100)' 0)
  $theme = Pick-Theme $r

  $subj    = 'Digital constitutionalism in practice — quick advisory request (CoCivium)'
  $opener  = "Hi $name — your work on $theme has shaped our approach."
  $body    = 'We are operationalizing due-process + appeals inside protocols (code + institutions, not just words). Could we book 30 minutes to sanity-check our Cognocarta Consenti (rights, remedies, jurisdiction-aware routing) and our anti-gaming metrics (congruence, remedy-rate, legitimacy signals)?'
  $influ   = "You'd directly influence the appeals module and a near-term pilot; timing is flexible."
  $tail    = if ($ask) { "Our specific ask here: $ask" } else { 'We will share a 2-pager in advance; lightweight but concrete.' }
  $link    = if ($url) { "Ref: $url" } else { '' }

  $block = @"
### $name — $aff  (Score: $score)
**Subject:** $subj

$opener
$body
$influ
$tail
$link
"@

  $null = $sb.AppendLine($block)
  $null = $sb.AppendLine('---')
  $null = $sb.AppendLine()
}

$firstLines = Join-Path $OutTpl 'wave0_first_lines_v0.2.md'
$sb.ToString() | Set-Content -Path $firstLines -Encoding UTF8

# Individual email drafts -> zip
$stage = Join-Path $env:TEMP 'outreach_emails_wave0_top6'
if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory -Force -Path $stage | Out-Null

foreach ($r in $top) {
  $name  = Get-Val $r 'Name' 'there'
  $aff   = Get-Val $r 'Affiliation' ''
  $theme = Pick-Theme $r
  $url   = Get-Val $r 'ContactURL' ''
  $ask   = Get-Val $r 'Ask' ''

  $subject = 'Digital constitutionalism in practice — quick advisory request (CoCivium)'
  $body = @"
Hi $name,

Your work on $theme has shaped our approach at CoCivium.

Quick context: we are operationalizing due-process + appeals inside protocols
(code + institutions, not just words).

Could we book 30 minutes to sanity-check our Cognocarta Consenti
(rights, remedies, jurisdiction-aware routing) and our anti-gaming metrics
(congruence, remedy-rate, legitimacy signals)?

Influence: you'd directly shape the appeals module and a near-term pilot; timing is flexible.
$([string]::IsNullOrWhiteSpace($ask) ? '' : "Our specific ask: $ask`n")
We will share a 2-pager in advance.

$([string]::IsNullOrWhiteSpace($url) ? '' : "Ref: $url")

Best,
Rick
"@

  $safeAff = if ($aff) { $aff } else { '' }
  if ($safeAff.Length -gt 40) { $safeAff = $safeAff.Substring(0,40) }
  $baseLeft  = _ToAsciiFileName($name)
  $baseRight = _ToAsciiFileName($safeAff)
  $fname     = ("{0} - {1}.txt" -f $baseLeft, $baseRight).Trim()
  "Subject: $subject`r`n`r`n$body" | Set-Content -Path (Join-Path $stage $fname) -Encoding UTF8
}

$zip = Join-Path $OutTpl 'outreach_emails_wave0_top6.zip'
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $zip -Force

Write-Host "[OK] Wrote:"
Write-Host " - $firstLines"
Write-Host " - $zip"

