Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"

function S([int[]]$codes){ ($codes | ForEach-Object { [string][char]$_ }) -join '' }

# Codepoint-built tokens (ASCII-safe)
$C3    = S 0x00C3                       # '?'
$C2    = S 0x00C2                       # '?'
$Combo = S 0x00C3,0x00AF,0x00C2,0x00BF,0x00C2,0x00BD  # "??????" (double-encoded U+FFFD)

function Get-ReadmeUTF8([string]$spec){
  $tmp = "__blob.tmp"
  cmd /c "git show --no-textconv $spec > $tmp 2>nul"
  if(-not (Test-Path $tmp)){ return $null }
  try {
    $bytes = [IO.File]::ReadAllBytes($tmp)
    [Text.UTF8Encoding]::new($false,$true).GetString($bytes)
  } catch { $null } finally { Remove-Item $tmp -ErrorAction SilentlyContinue }
}

function MeasureMojibake([string]$txt){
  if([string]::IsNullOrEmpty($txt)){ return $null }
  [pscustomobject]@{
    A       = ([regex]::Matches($txt,[regex]::Escape($C3))).Count
    B       = ([regex]::Matches($txt,[regex]::Escape($C2))).Count
    Combo   = ([regex]::Matches($txt,[regex]::Escape($Combo))).Count
    Preview = $txt.Substring(0,[Math]::Min(140,$txt.Length))
  }
}

Write-Host "=== HEAD history for README.md (oldest->newest) ==="
$commits = (git rev-list --date-order --reverse HEAD -- README.md) -split '\r?\n' | Where-Object { $_ }
if(-not $commits){ throw "No README.md history on HEAD." }

$rows = foreach($sha in $commits){
  $txt = Get-ReadmeUTF8 "$sha:README.md"
  $m   = MeasureMojibake $txt
  if($m){
    [pscustomobject]@{
      Sha=$sha
      Meta=(git show -s --format="%h %ci  %an  %s" $sha)
      A=$m.A; B=$m.B; Combo=$m.Combo; Preview=$m.Preview
    }
  }
}

Write-Host "`n=== Tail (last 6 commits) ==="
$rows | Select-Object -Last 6 | ForEach-Object {
  "{0}  A={1} B={2} Combo={3}" -f $_.Meta,$_.A,$_.B,$_.Combo
} | Write-Output

# Find last clean candidate on HEAD
$candidates = $rows | Where-Object { $_.Combo -eq 0 -and ($_.A + $_.B) -lt 5 }
$lastClean  = $candidates | Select-Object -Last 1

if($lastClean){
  Write-Host "`n=== Last CLEAN candidate on HEAD ==="
  "{0}`nA={1} B={2} Combo={3}" -f $lastClean.Meta,$lastClean.A,$lastClean.B,$lastClean.Combo | Write-Output
  "Preview:`n{0}" -f $lastClean.Preview | Write-Output
}else{
  Write-Host "`nNo clean commit on HEAD. Scanning all branches (this may take a moment)..."
  $all = (git rev-list --all -- README.md) -split '\r?\n' | Select-Object -Unique
  $best = $null
  foreach($sha in $all){
    $txt = Get-ReadmeUTF8 "$sha:README.md"
    $m = MeasureMojibake $txt
    if($m -and $m.Combo -eq 0 -and ($m.A + $m.B) -lt 5){
      $best = [pscustomobject]@{ Sha=$sha; Meta=(git show -s --format="%h %ci  %an  %s" $sha); A=$m.A; B=$m.B; Combo=$m.Combo; Preview=$m.Preview }
    }
  }
  if($best){
    Write-Host "`n=== CLEAN candidate off-branch ==="
    "{0}`nA={1} B={2} Combo={3}" -f $best.Meta,$best.A,$best.B,$best.Combo | Write-Output
    "Preview:`n{0}" -f $best.Preview | Write-Output
  } else {
    Write-Host "`nNo clean README found anywhere."
  }
}
