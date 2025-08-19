Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

$repo   = "$HOME\Documents\GitHub\CoCivium"
$readme = Join-Path $repo 'README.md'
if (!(Test-Path $readme)) {
  Write-Host "FAIL: README.md not found at $readme" -ForegroundColor Red; exit 1
}
$t     = Get-Content -LiteralPath $readme -Raw
$lines = $t -split "`r?`n"
$fails = New-Object System.Collections.Generic.List[string]

# --- 1) Exactly one W/W/H, in order, on 3 consecutive lines, before the acrostics ---
$whyIdx=@(); $whoIdx=@(); $howIdx=@(); $acroIdx=@()
for ($i=0; $i -lt $lines.Length; $i++){
  if ($lines[$i] -match '^\s*<img\s+[^>]*why-line\.svg\?v=\d+') { $whyIdx += $i }
  if ($lines[$i] -match '^\s*<img\s+[^>]*who-line\.svg\?v=\d+') { $whoIdx += $i }
  if ($lines[$i] -match '^\s*<img\s+[^>]*how-line\.svg\?v=\d+') { $howIdx += $i }
  if ($lines[$i] -match '^\s*<img\s+[^>]*\./assets/icons/(life|feels|broken|until|governments|coevolve|solutions|for-you)-line\.svg\?v=\d+') { $acroIdx += $i }
}
if ($whyIdx.Count -ne 1 -or $whoIdx.Count -ne 1 -or $howIdx.Count -ne 1) {
  $fails.Add("WWH must appear exactly once each (why=$($whyIdx.Count), who=$($whoIdx.Count), how=$($howIdx.Count)).") | Out-Null
} else {
  if (!($whoIdx[0] -eq $whyIdx[0]+1 -and $howIdx[0] -eq $whoIdx[0]+1)) {
    $fails.Add("WWH must be three consecutive lines.") | Out-Null
  }
  if ($acroIdx.Count -gt 0 -and $whyIdx[0] -ge $acroIdx[0]) {
    $fails.Add("WWH block must appear before the first LIFE/… acrostic.") | Out-Null
  }
}
# No bold-only W/W/H lines anywhere
if ($t -match '(?m)^\s*\*\*(Why|Who|How):\*\*') {
  $fails.Add("Found stray bold-only W/W/H line(s); they should be the iconized block under the H2.") | Out-Null
}

# --- 2) Icon hygiene ---
# a) any icons/ src that is .svg must be -line.svg
$badPlain = [regex]::Matches($t, '(?i)src="\./assets/icons/[^"]*(?<!-line)\.svg')
if ($badPlain.Count -gt 0) { $fails.Add("Icon src without -line.svg: $($badPlain[0].Value)") | Out-Null }
# b) no paths like ...-linelife (missing .svg after -line)
$badNoSvg = [regex]::Matches($t, '(?i)\./assets/icons/[^"\s]+-line(?!\.svg)')
if ($badNoSvg.Count -gt 0) { $fails.Add("Icon src missing .svg after -line: $($badNoSvg[0].Value)") | Out-Null }
# c) require ?v= cache-buster
$badNoV = [regex]::Matches($t, '(?i)src="\./assets/icons/[^"]+\.svg(?!\?v=\d+)')
if ($badNoV.Count -gt 0) { $fails.Add("Icon src missing ?v= cache-buster: $($badNoV[0].Value)") | Out-Null }
# d) spacing after icon
$iconLines = [regex]::Matches($t, '(?m)^\s*<img\s+[^>]*src="\./assets/icons/[^"]+"[^>]*>.*$')
foreach($m in $iconLines){
  if ($m.Value -notmatch '\/>\s*&nbsp;&nbsp;\s+\*\*') {
    $fails.Add("Icon line missing `&nbsp;&nbsp; **` spacing: $($m.Value.Trim())") | Out-Null; break
  }
}

# --- 3) Acrostic labels: present once each; COEVOLVE uppercase ---
$labels = @('LIFE','FEELS','BROKEN','UNTIL','GOVERNMENTS','COEVOLVE','SOLUTIONS','FOR YOU')
foreach($L in $labels){
  $p = "(?m)^\s*<img[^>]*>\s*&nbsp;&nbsp;\s+\*\*$([regex]::Escape($L)):\*\*"
  $count = ([regex]::Matches($t, $p)).Count
  if ($count -eq 0) { $fails.Add("Missing acrostic: $L") | Out-Null }
  if ($count -gt 1) { $fails.Add("Duplicate acrostic: $L ($count)") | Out-Null }
}
if ($t -match '\*\*CoEvolve:\*\*') { $fails.Add("Use **COEVOLVE:** (uppercase) for the label.") | Out-Null }

# --- Result ---
if ($fails.Count -gt 0) {
  Write-Host "README LINT FAILED:" -ForegroundColor Red
  $fails | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
  exit 1
} else {
  Write-Host "README LINT PASS ✅" -ForegroundColor Green
  exit 0
}
