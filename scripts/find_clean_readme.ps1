Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"

function Get-ReadmeTextFromSpec([string]$spec){
  $tmp = "__blob.tmp"
  cmd /c "git show --no-textconv $spec > $tmp 2>nul"
  if(-not (Test-Path $tmp)){ return $null }
  $bytes = [IO.File]::ReadAllBytes($tmp)
  try {
    $utf8 = [Text.UTF8Encoding]::new($false,$true) # strict
    $txt  = $utf8.GetString($bytes)
    return $txt
  } catch {
    return $null
  }
}

function Measure-Mojibake([string]$txt){
  if($null -eq $txt){ return $null }
  $a = ([regex]::Matches($txt,'?')).Count
  $b = ([regex]::Matches($txt,'?')).Count
  $combo = ([regex]::Matches($txt,'??????')).Count
  [pscustomobject]@{
    A=$a; B=$b; Combo=$combo
    Preview=$txt.Substring(0,[Math]::Min(140,$txt.Length))
  }
}

Write-Host "=== Scanning README.md history on HEAD (oldest->newest) ==="
$commits = (git rev-list --date-order --reverse HEAD -- README.md) -split '\r?\n' | ? { $_ }
$rows = @()
foreach($sha in $commits){
  $txt = Get-ReadmeTextFromSpec "$sha:README.md"
  $m = Measure-Mojibake $txt
  if($m){
    $meta = (git show -s --format="%h %ci  %an  %s" $sha)
    $rows += [pscustomobject]@{ Sha=$sha; Meta=$meta; A=$m.A; B=$m.B; Combo=$m.Combo; Preview=$m.Preview }
  }
}

if(-not $rows){ throw "No README.md history found." }

# Candidate = no '??????' and very low spurious '?'/'?'
$candidates = $rows | ? { $_.Combo -eq 0 -and ($_.A + $_.B) -lt 5 }
$lastClean = $candidates | Select-Object -Last 1

Write-Host "`n=== Summary (last 5 commits) ==="
$rows | Select-Object -Last 5 | ForEach-Object {
  "{0}  A={1} B={2} Combo={3}" -f $_.Meta,$_.A,$_.B,$_.Combo
} | Write-Output

if($lastClean){
  Write-Host "`n=== Last CLEAN candidate ==="
  "{0}`nA={1} B={2} Combo={3}" -f $lastClean.Meta,$lastClean.A,$lastClean.B,$lastClean.Combo | Write-Output
  "Preview:`n{0}" -f $lastClean.Preview | Write-Output
}else{
  Write-Host "`nNo clean commit on HEAD. Scanning all branches..."
  $all = (git rev-list --all -- README.md) -split '\r?\n' | Select-Object -Unique
  $best = $null
  foreach($sha in $all){
    $txt = Get-ReadmeTextFromSpec "$sha:README.md"
    $m = Measure-Mojibake $txt
    if($m -and $m.Combo -eq 0 -and ($m.A + $m.B) -lt 5){
      $best = [pscustomobject]@{ Sha=$sha; Meta=(git show -s --format="%h %ci  %an  %s" $sha); A=$m.A; B=$m.B; Combo=$m.Combo; Preview=$m.Preview }
    }
  }
  if($best){
    Write-Host "`n=== CLEAN candidate found off-branch ==="
    "{0}`nA={1} B={2} Combo={3}" -f $best.Meta,$best.A,$best.B,$best.Combo | Write-Output
    "Preview:`n{0}" -f $best.Preview | Write-Output
  } else {
    Write-Host "`nNo clean version found anywhere."
  }
}
