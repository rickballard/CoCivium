param([string[]]$Paths)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

function Should-Skip($file){
  $head = Get-Content -LiteralPath $file -TotalCount 10 -ErrorAction SilentlyContinue
  if ($null -eq $head) { return $false }
  return ($head -match 'BPOE:\s*skip')
}
function Quote-Advisory([string]$file){
  $raw = Get-Content -Raw -LiteralPath $file
  $lines = $raw -split "`r?`n"
  $out = New-Object System.Collections.Generic.List[string]
  $inFence = $false
  foreach($l in $lines){
    if ($l -match '^\s*```') { $out.Add($l); $inFence = -not $inFence; continue }
    if ($inFence) { $out.Add($l); continue }
    if ($l -match '^\s*$') { $out.Add($l); continue }   # blank
    if ($l -match '^\s*#') { $out.Add($l); continue }   # headings
    if ($l -match '^\s*>') { $out.Add($l); continue }   # already callout
    $out.Add('> ' + $l)
  }
  ($out -join "`r`n") | Set-Content -Encoding UTF8 -LiteralPath $file
  Write-Host "BPOE applied: $file"
}

if (-not $Paths -or $Paths.Count -eq 0) {
  # Default to staged files
  $Paths = git diff --cached --name-only --diff-filter=ACM | Where-Object { $_ -like '*.md' }
}
foreach($p in $Paths){
  if (-not (Test-Path $p)) { continue }
  if (Should-Skip $p) { Write-Host "BPOE skip: $p"; continue }
  Quote-Advisory $p
}
