param(
  [Parameter(Mandatory=$true)][string]$Owner,
  [string]$Repo = (Split-Path -Leaf (git rev-parse --show-toplevel 2>$null)),
  [int]$Limit = 50
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
function Say([string]$m){ "{0}  {1}" -f (Get-Date -Format s),$m | Write-Host }

$root = (Get-Location)
$report = "_overlap_scan.txt"
$patterns = @(
  "filename:canon language:Markdown user:$Owner",
  "filename:*.canon.* language:Markdown user:$Owner",
  "filename:*Megascroll* language:Markdown user:$Owner",
  "filename:*BPOE* language:Markdown user:$Owner",
  "path:.do user:$Owner",
  "filename:*Filename*Conventions* user:$Owner"
)

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add("# Overlap scan ($(Get-Date -Format s))")
$lines.Add("> owner=$Owner repo=$Repo limit=$Limit")
$lines.Add("")

$lines.Add("## Local repo hits")
$local = Get-ChildItem -Recurse -File -Include *.md,*.mdx,*.txt 2>$null |
  Where-Object { $_.Name -match 'canon|megascroll|bpoe|filename|convention|wisdom' }
if($local){ $local | ForEach-Object { $lines.Add(" - " + $_.FullName.Substring($root.Path.Length+1)) } }
else { $lines.Add(" (none)") }
$lines.Add("")

function GHS([string]$q){
  gh api -X GET "search/code?q=$([uri]::EscapeDataString($q))&per_page=$Limit" --jq '.items[] | "\(.repository.full_name) | \(.path) | \(.html_url)"' 2>$null
}

$lines.Add("## Remote user scan (top matches)")
foreach($pat in $patterns){
  $lines.Add("### `$pat`")
  $hits = GHS $pat
  if($LASTEXITCODE -ne 0){ $lines.Add(" (gh search unavailable)") }
  elseif(-not $hits){ $lines.Add(" (no results)") }
  else{ $hits -split "`n" | ForEach-Object { $lines.Add(" - $_") } }
  $lines.Add("")
}

$lines | Set-Content -Encoding UTF8 -NoNewline $report
Say "Wrote $report"