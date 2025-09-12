param(
  [Parameter(Mandatory=$true)][string]$OldName,
  [Parameter(Mandatory=$true)][string]$NewName,
  [string]$OldRole,
  [string]$NewRole,
  [switch]$DryRun
)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$here  = Split-Path -Parent $MyInvocation.MyCommand.Path
$root  = Resolve-Path (Join-Path $here '..')
$dir   = Join-Path $root 'docs\outreach\LehaneOps'

$files = Get-ChildItem $dir -Recurse -Include *.md,*.ps1,*.yml,*.yaml,*.json -File
$changes = 0
foreach($f in $files){
  $c = Get-Content -Raw -LiteralPath $f.FullName
  $c2 = $c -replace [regex]::Escape($OldName), $NewName
  if ($OldRole -and $NewRole) { $c2 = $c2 -replace [regex]::Escape($OldRole), $NewRole }
  if ($c2 -ne $c) {
    $changes++
    if (-not $DryRun) { $c2 | Set-Content -Encoding UTF8 -LiteralPath $f.FullName }
    Write-Host "Updated: $($f.FullName)"
  }
}
if ($DryRun) { Write-Host "DryRun complete. Would change: $changes files" } else { Write-Host "Applied changes: $changes files" }
