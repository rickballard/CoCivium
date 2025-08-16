Param([switch]$Accept)
$ErrorActionPreference='Stop'

$apos = [char]0x2019
$rules = @(
  @{ find = '(?i)\bCivium\b';          replace = 'CoCivium' },
  @{ find = "CoCoCivium's";                replace = "CoCoCivium's" },
  @{ find = ("CoCivium{0}s" -f $apos);   replace = ("CoCivium{0}s" -f $apos) }
  # add more here as we deprecate other words/phrases
)

$exclude = @(
  '^scroll/legacy/', '^site/assets/', '^docs/symbols/MANIFEST\.lock$',
  '\.(png|jpg|jpeg|svg|ico|gif|pdf|zip|gz|7z)$'
)

$files = (& git ls-files) | Where-Object {
  $p = $_
  -not ($exclude | Where-Object { $p -match $_ })
}

$viol=@()
foreach($f in $files){
  $text = Get-Content $f -Raw -ErrorAction SilentlyContinue
  if($null -eq $text){ continue }
  $orig = $text
  foreach($r in $rules){
    $text = [regex]::Replace($text, $r.find, $r.replace)
  }
  if($text -ne $orig){
    if($Accept){
      Set-Content -Path $f -Value $text -Encoding utf8
    } else {
      foreach($r in $rules){
        foreach($m in [regex]::Matches($orig, $r.find)){
          $line = ($orig.Substring(0,$m.Index).Split("`n").Count)
          $viol += "{0}:{1}: {{…{2}…}}" -f $f,$line,$m.Value
        }
      }
    }
  }
}

if($Accept){
  Write-Host "Deprecated terms normalized. Stage & commit the edits."
  exit 0
}
if($viol.Count){
  Write-Error ("Deprecated terms found:`n" + ($viol -join "`n") + "`nRun: pwsh tools/deprecated-sweep.ps1 -Accept")
  exit 1
}
Write-Host "No deprecated terms found."

