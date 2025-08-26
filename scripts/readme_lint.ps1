Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo   = "$HOME\Documents\GitHub\CoCivium"
$readme = Join-Path $repo 'README.md'
$t      = Get-Content -LiteralPath $readme -Raw
$lines  = $t -split "`r?`n"
$fails  = New-Object System.Collections.Generic.List[string]

# No console/prompt chevrons
if ($t -match '(?m)^(?:>\s*)+.+$') { $fails.Add("Found stray lines starting with '>' (console paste).") | Out-Null }
if ($t -match '(?m)^PS [^\r\n>]+>') { $fails.Add("Found stray PowerShell prompt lines.") | Out-Null }

# WWH markers present
$beg = ([regex]::Matches($t,'(?m)^\s*<!--\s*WWH:BEGIN\s*-->\s*$')).Count
$end = ([regex]::Matches($t,'(?m)^\s*<!--\s*WWH:END\s*-->\s*$')).Count
if ($beg -ne 1 -or $end -ne 1) { $fails.Add("WWH markers must appear exactly once (BEGIN/END).") | Out-Null }

# WWH order
$whyIdx=@(); $whoIdx=@(); $howIdx=@()
for ($i=0; $i -lt $lines.Length; $i++){
  if ($lines[$i] -match '^\s*<img\s+[^>]*why-line\.svg\?v=\d+') { $whyIdx += $i }
  if ($lines[$i] -match '^\s*<img\s+[^>]*who-line\.svg\?v=\d+') { $whoIdx += $i }
  if ($lines[$i] -match '^\s*<img\s+[^>]*how-line\.svg\?v=\d+') { $howIdx += $i }
}
if ($whyIdx.Count -ne 1 -or $whoIdx.Count -ne 1 -or $howIdx.Count -ne 1) {
  $fails.Add("Why/Who/How must appear exactly once each.") | Out-Null
} elseif (!($whoIdx[0] -eq $whyIdx[0]+1 -and $howIdx[0] -eq $whoIdx[0]+1)) {
  $fails.Add("Why/Who/How must be on three consecutive lines.") | Out-Null
}

# Separator: allow END marker and blank lines before the '---'
if ($howIdx.Count -eq 1) {
  $k = $howIdx[0] + 1
  while ($k -lt $lines.Length -and $lines[$k] -match '^\s*(?:<!--\s*WWH:END\s*-->)?\s*$') { $k++ }
  if ($k -ge $lines.Length -or $lines[$k] -notmatch '^\s*---\s*$') {
    $fails.Add("Expected '---' separator immediately after WWH block (END/blank line allowed before it).") | Out-Null
  }
}

# WWH must come before first acrostic
$acro = for($i=0;$i -lt $lines.Length;$i++){
  if ($lines[$i] -match '^\s*<img\s+[^>]*\./assets/icons/(life|feels|broken|until|governments|coevolve|solutions|for-you)-line\.svg\?v=\d+') { $i }
}
if ($whyIdx.Count -eq 1 -and $acro.Count -gt 0 -and $whyIdx[0] -ge $acro[0]) {
  $fails.Add("WWH must appear before the first acrostic.") | Out-Null
}
# no stray bold-only W/W/H
if ($t -match '(?m)^\s*\*\*(Why|Who|How):\*\*') { $fails.Add("Remove stray bold-only W/W/H lines.") | Out-Null }

# Icon hygiene
if ([regex]::Matches($t,'(?i)src="\./assets/icons/[^"]*(?<!-line)\.svg').Count -gt 0) { $fails.Add("Icon src without -line.svg.") | Out-Null }
if ([regex]::Matches($t,'(?i)\./assets/icons/[^"\s]+-line(?!\.svg)').Count -gt 0)   { $fails.Add("Icon src missing .svg after -line.") | Out-Null }
if ([regex]::Matches($t,'(?i)src="\./assets/icons/[^"]+\.svg(?!\?v=\d+)').Count -gt 0){ $fails.Add("Icon src missing ?v= cache-buster.") | Out-Null }
foreach($m in [regex]::Matches($t,'(?m)^\s*<img\s+[^>]*src="\./assets/icons/[^"]+"[^>]*>.*$')){
  if ($m.Value -notmatch '\/>\s*&nbsp;&nbsp;\s+\*\*') { $fails.Add("Icon line missing `&nbsp;&nbsp; **` spacing.") | Out-Null; break }
}

# Acrostics + COEVOLVE uppercase
$labels = @('LIFE','FEELS','BROKEN','UNTIL','GOVERNMENTS','COEVOLVE','SOLUTIONS','FOR YOU')
foreach($L in $labels){
  $p = "(?m)^\s*<img[^>]*>\s*&nbsp;&nbsp;\s+\*\*" + [regex]::Escape($L) + ":\*\*"
  $c = ([regex]::Matches($t,$p)).Count
  if ($c -eq 0) { $fails.Add("Missing acrostic: $L") | Out-Null }
  if ($c -gt 1) { $fails.Add("Duplicate acrostic: $L ($c)") | Out-Null }
}
if ($t -match '\*\*CoEvolve:\*\*') {
  $line = (Select-String -Path $readme -Pattern '\*\*CoEvolve:\*\*' -AllMatches | Select-Object -First 1).Line
  $fails.Add("Use **COEVOLVE:** (uppercase). Offending line: ${line}") | Out-Null
}

if ($fails.Count -gt 0){
  Write-Host "README LINT FAILED:" -ForegroundColor Red
  $fails | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
  exit 1
}else{
  Write-Host "README LINT PASS ✅" -ForegroundColor Green
  exit 0
}
