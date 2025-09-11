param([string[]]$Paths)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

function Apply-One([string]$file){
  $lines = (Get-Content -Raw -LiteralPath $file) -split "`r?`n"
  $out   = New-Object System.Collections.Generic.List[string]
  $inFence = $false
  foreach($l in $lines){
    if ($l -match '^\s*```') { $out.Add($l); $inFence = -not $inFence; continue }
    if ($inFence)           { $out.Add($l); continue }
    if ($l -match '^\s*$')  { $out.Add($l); continue }  # blank
    if ($l -match '^\s*#')  { $out.Add($l); continue }  # headings
    if ($l -match '^\s*>')  { $out.Add($l); continue }  # already callout
    # everything else = advisory -> quote it
    $out.Add('> ' + $l)
  }
  ($out -join "`r`n") | Set-Content -Encoding UTF8 -LiteralPath $file
  Write-Host "BPOE applied: $file"
}

if (-not $Paths -or $Paths.Count -eq 0) {
  $root = Resolve-Path (Join-Path $PSScriptRoot '..')
  $Paths = @(
    (Join-Path $root 'README.md'),
    (Join-Path $root 'plans\01_precursor.md'),
    (Join-Path $root 'plans\02_outreach.md')
  )
}
foreach($p in $Paths){ if(Test-Path $p){ Apply-One $p } }
