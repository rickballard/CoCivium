param([string]$Path = ".")
$patterns = @(
  '^\sPS .+?>\s$',
  '^\s>>>\s$',
  '^\s>>\s$',
  '^\s\^(C|Z)\s$',
  '^\s--- .+ ---\s$'
)
$bad = @()
foreach ($p in $patterns) {
  $bad += Select-String -Path $Path -Pattern $p -AllMatches -ErrorAction SilentlyContinue
}
if ($bad) { $bad | Format-Table Path,LineNumber,Line; exit 1 } else { "OK" }
