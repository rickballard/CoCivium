# BPOE-PwshBounce
if ($PSVersionTable.PSVersion.Major -lt 7) {
  $cmd = Get-Command pwsh -ErrorAction SilentlyContinue
  if ($cmd) { & $cmd.Source -NoProfile -File $PSCommandPath @args; exit $LASTEXITCODE }
}[CmdletBinding()]
param(
  [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot),
  [string]$CsvPath  = $null
)

$ErrorActionPreference = 'Stop'

if (-not $CsvPath) {
  $CsvPath = Join-Path $RepoRoot 'outreach\projects\outreach-stage-seed\CoCivium_outreach_leads_v0.2.csv'
}
if (-not (Test-Path $CsvPath)) { throw "CSV not found: $CsvPath" }

$OutTpl = Join-Path $RepoRoot 'outreach\projects\outreach-stage-seed\templates'
New-Item -ItemType Directory -Force -Path $OutTpl | Out-Null

# Load CSV
$rows = Import-Csv $CsvPath

# Normalize score
foreach ($r in $rows) {
  $v = $r.'PriorityScore(0-100)'
  $r.'PriorityScore(0-100)' = [double]::Parse(($v -replace '[^0-9\.\-]','0')) 2>$null
}

# Top 6
$top = $rows | Sort-Object {[double]$_.'PriorityScore(0-100)'} -Descending | Select-Object -First 6

function Pick-Theme($r) {
  foreach ($k in @('KeyPhrases','Role/Focus','WhyApproach')) {
    $val = ($r.$k | Out-String).Trim()
    if ($val) {
      $t = ($val -split '[,;]')[0].Trim()
      if ($t.Length -gt 90) { return ($t.Substring(0,87) + '…') } else { return $t }
    }
  }
  return 'governance-by-design'
}

# Build first-lines markdown
$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('# Wave-0: first-line openers (top 6)')
[void]$sb.AppendLine()

foreach ($r in $top) {
  $name = ($r.Name ?? 'there')
  $aff  = $r.Affiliation
  $url  = $r.ContactURL
  $ask  = $r.Ask
  $score= [int]$r.'PriorityScore(0-100)'
  $theme= Pick-Theme $r

  $subj = 'Digital constitutionalism in practice - quick advisory request (CoCivium)'
  $opener = "Hi $name - your work on $theme has shaped our approach."
  $body = @(
    "We're operationalizing due-process + appeals inside protocols (code + institutions, not just words).",
    "Could we book 30 minutes to sanity-check our Cognocarta Consenti (rights, remedies, jurisdiction-aware routing) and our anti-gaming metrics (congruence, remedy-rate, legitimacy signals)?"
  ) -join ' '
$influence = "You'd directly influence the appeals module and a near-term pilot; timing is flexible."
  $tail = if ($ask) { "Our specific ask here: $ask" } else { "We'll share a 2-pager in advance; lightweight but concrete." }
  $link = if ($url) { "Ref: $url" } else { "" }

  $block = @"
### $name - $aff  (Score: $score)
**Subject:** $subj

$opener
$body
$influence
$tail
$link
"@

  [void]$sb.AppendLine($block)
  [void]$sb.AppendLine('---')
  [void]$sb.AppendLine()
}

$firstLines = Join-Path $OutTpl 'wave0_first_lines_v0.2.md'
$sb.ToString() | Set-Content -Path $firstLines -Encoding UTF8

# Individual email drafts -> zip
$stage = Join-Path $env:TEMP 'outreach_emails_wave0_top6'
if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory -Force -Path $stage | Out-Null

foreach ($r in $top) {
  $name = ($r.Name ?? 'there'); if (-not $name) { $name = 'there' }
  $aff  = ($r.Affiliation ?? '')
  $theme= Pick-Theme $r
  $url  = ($r.ContactURL ?? '')
  $ask  = ($r.Ask ?? '')

  $subject = 'Digital constitutionalism in practice - quick advisory request (CoCivium)'
  $body = @"
Hi $name,

Your work on $theme has shaped our approach at CoCivium.

Quick context: we're operationalizing due-process + appeals inside protocols
(code + institutions, not just words).

Could we book 30 minutes to sanity-check our Cognocarta Consenti
(rights, remedies, jurisdiction-aware routing) and our anti-gaming metrics
(congruence, remedy-rate, legitimacy signals)?

Influence: you'd directly shape the appeals module and a near-term pilot; timing is flexible.
$([string]::IsNullOrWhiteSpace($ask) ? '' : "Our specific ask: $ask`n")
We'll share a 2-pager in advance.

$([string]::IsNullOrWhiteSpace($url) ? '' : "Ref: $url")

Best,
Rick
"@

  $fname = ("{0} - {1}.txt" -f $name.Replace('/','-'), ($aff ?? '').Substring(0, [Math]::Min(40, ($aff ?? '').Length))).Trim()
  "Subject: $subject`r`n`r`n$body" | Set-Content -Path (Join-Path $stage $fname) -Encoding UTF8
}

$zip = Join-Path $OutTpl 'outreach_emails_wave0_top6.zip'
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path (Join-Path $stage '*') -DestinationPath $zip -Force

Write-Host "[OK] Wrote:"
Write-Host " - $firstLines"
Write-Host " - $zip"


