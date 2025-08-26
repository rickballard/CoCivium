Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"
$rdme = "$HOME\Documents\GitHub\CoCivium\README.md"

function Show-HexSlice([byte[]]$bytes,[int]$len,[string]$label){
  $take=[Math]::Min($len,$bytes.Length)
  $slice = New-Object byte[] $take
  [Array]::Copy($bytes,0,$slice,0,$take)
  Write-Host "`n-- $label (first $take bytes) --"
  Format-Hex -InputObject $slice
}

Write-Host "=== Working tree (UTF-8 strict preview & counts) ==="
$wb = [IO.File]::ReadAllBytes($rdme)
$utf8s = [Text.UTF8Encoding]::new($false,$true)
$wtxt = $utf8s.GetString($wb)
$wcA  = ([regex]::Matches($wtxt,'[??]')).Count
Write-Host ("First 120 chars:`n{0}" -f $wtxt.Substring(0,[Math]::Min(120,$wtxt.Length)))
Write-Host ("Counts (working): ?/?={0}" -f $wcA)
Show-HexSlice -bytes $wb -len 160 -label "working tree"

Write-Host "`n=== HEAD vs origin ==="
git fetch --quiet origin
cmd /c "git show --no-textconv HEAD:README.md > __head.tmp"
cmd /c "git show --no-textconv origin/main:README.md > __orig.tmp" 2>nul

$hb=[IO.File]::ReadAllBytes('__head.tmp')
$ob=[IO.File]::ReadAllBytes('__orig.tmp')

Show-HexSlice -bytes $hb -len 160 -label "HEAD:README.md"
Show-HexSlice -bytes $ob -len 160 -label "origin/main:README.md"

$htxt=$utf8s.GetString($hb)
$otxt=$utf8s.GetString($ob)
$hcA=([regex]::Matches($htxt,'[??]')).Count
$ocA=([regex]::Matches($otxt,'[??]')).Count
Write-Host ("HEAD mojibake count: {0}" -f $hcA)
Write-Host ("origin mojibake count: {0}" -f $ocA)
