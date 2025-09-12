[CmdletBinding()]
param([Parameter(Mandatory)][string]$Path)

$txt = Get-Content -Raw -Path $Path

# crude but effective heuristics:
$askIdx = [regex]::Match($txt, '(?ims)^\s*(?:##\s*)?(?:questions?|clarifications?)\b|^\s*\?\b|(?<=\n)\s*(?:Can you|Should I)\b').Index
$delIdx = [regex]::Match($txt, '(?ims)^\s*(?:##\s*)?(?:deliverables?|downloads?|artifacts?|outputs?)\b|sandbox:/').Index

if ($delIdx -ge 0 -and ($askIdx -lt 0 -or $delIdx -lt $askIdx)) {
  Write-Host "[OK] Deliverables precede asks." -ForegroundColor Green
  exit 0
} else {
  Write-Host "[FAIL] Answer-first violated: provide outputs before asks." -ForegroundColor Red
  exit 2
}
