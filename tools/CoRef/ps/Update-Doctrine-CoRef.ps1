param(
  [string]$DoctrinePath,
  [string]$Namespace="CD"
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
if (-not $DoctrinePath) { $DoctrinePath = Join-Path $PSScriptRoot "..\..\docs\doctrine-index.md" | Resolve-Path }
$DoctrinePath = $DoctrinePath.ToString()
$repoRoot = (Get-Item $DoctrinePath).Directory.Parent.Parent.FullName
$gen = Join-Path $repoRoot "tools\CoRef\ps\Generate-CoRef.ps1"
$out = [System.IO.Path]::ChangeExtension($DoctrinePath, ".coref.json")
if (Test-Path $gen) {
  & $gen -Path $DoctrinePath -DocId "$Namespace:doctrine-index" -Namespace $Namespace -OutMap $out
  Write-Host "[CoDoctrine] updated sidecar at $out"
} else {
  Write-Host "[CoDoctrine] CoRef generator not found. Wrote placeholder sidecar only."
}
