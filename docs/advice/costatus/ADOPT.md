# CoStatus: quick adopt (one-liner loader + safe fallback)

```pwsh
# Prefer repo helpers; graceful fallback
$CC = Join-Path $HOME 'Documents\GitHub\CoCache'
$Adapter = Join-Path $CC 'tools/heartbeat/CoStatus.Adapter.psm1'
if (Test-Path $Adapter) { Import-Module $Adapter -Force -ErrorAction SilentlyContinue }

if (-not (Get-Command Use-CoStatus -ErrorAction SilentlyContinue)) {
  function Use-CoStatus {
    param([string]$Repo=(Split-Path -Leaf (Get-Location)),
          [string]$Branch=((git rev-parse --abbrev-ref HEAD 2>$null).Trim()),
          [string]$Pulse='CU:OK · PU:SOFT · HU:SOFT · WT:OK',
          [string]$Note='', [int]$CountdownSec=6, [double]$Drift=0.2)
    $ts=(Get-Date).ToUniversalTime().ToString('yyyyMMdd-HHmmssZ')
    $levels=@{OK='Green';SOFT='Yellow';HARD='DarkYellow';FATAL='Red'}
    $parts=@{}; foreach($kv in ($Pulse -as [string]).Split('·')){
      $kv=$kv.Trim(); if($kv -match '^(CU|PU|HU|WT):\s*(\w+)$'){ $parts[$Matches[1]]=$Matches[2].ToUpper() }
    }
    $clamp=[Math]::Max(-2,[Math]::Min(2,$Drift)); $idx=[int]([Math]::Round((($clamp+2)/4.0)*8))
    $arr=@(); for($i=0;$i -le 8;$i++){ if($i -eq 4){$arr+='|'} elseif($i -le $idx){$arr+='■'} else {$arr+='·'} }
    $bar = ($arr -join '')
    $deadline=(Get-Date).AddSeconds($CountdownSec)
    for(;;){
      $left=[int]([Math]::Max(0,($deadline-(Get-Date)).TotalSeconds))
      Write-Host "`r" -NoNewline; Write-Host "[CoStatus $ts]" -NoNewline -ForegroundColor Cyan
      foreach($k in 'CU','PU','HU','WT'){ $v=$parts[$k]; $c=@{OK='Green';SOFT='Yellow';HARD='DarkYellow';FATAL='Red'}[$v]; if(-not $c){$c='Gray'}
        Write-Host ("  {0}:{1}" -f $k,($(if($v){$v}else{'?'}))) -NoNewline -ForegroundColor $c }
      Write-Host ("  T-{0,2}s  drift:{1,0:N1}s [{2}]  repo:{3}  branch:{4}  {5}   " -f $left,$Drift,$bar,$Repo,$Branch,$Note) -NoNewline
      if($left -le 0){ break }; Start-Sleep -Milliseconds 250
    }; Write-Host ''
  }
}
# Emit once per cycle/set/MW
Use-CoStatus -Pulse 'CU:OK · PU:SOFT · HU:SOFT · WT:OK' -Note 'cycle' -CountdownSec 6 -Drift 0.2
```