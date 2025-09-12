param(
  [string]$Path = ".gitattributes"
)
$lines  = Get-Content $Path -Raw -EA Stop -Encoding UTF8 -ReadCount 0 -TotalCount 0
$lines  = $lines -split "`r?`n"
$issues = @()

for ($i=0; $i -lt $lines.Count; $i++) {
  $l = $lines[$i]
  if ($l -match '^\s*$' -or $l -match '^\s*#') { continue } # allow blanks & comments
  if ($l -match '^(<<<<<<<|=======|>>>>>>>)')   { $issues += [pscustomobject]@{Line=$i+1; Issue='Merge conflict marker'; Text=$l}; continue }
  if ($l -match '(?<!\S)(origin/|HEAD)(?!\S)') { $issues += [pscustomobject]@{Line=$i+1; Issue='Branch/ref left in file';  Text=$l}; continue }
}

if ($issues.Count) {
  $issues | Format-Table -AutoSize | Out-String | Write-Error
  exit 1
} else {
  "OK: $Path looks sane."
}