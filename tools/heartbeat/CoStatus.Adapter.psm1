Set-StrictMode -Version Latest
function Use-CoStatus {
  param(
    [string]$Repo   = $null,
    [string]$Branch = $null,
    [string]$Pulse  = 'CU:OK · PU:SOFT · HU:SOFT · WT:OK',
    [string]$Note   = '',
    [int]$CountdownSec = 6,
    [double]$Drift = 0.2
  )
  function Get-GitBranchSafe {
    try { $b = (git rev-parse --abbrev-ref HEAD 2>$null); if([string]::IsNullOrWhiteSpace($b)){'(no-git)'} else {$b.Trim()} } catch { '(no-git)' }
  }
  function Get-RepoNameSafe {
    try { $p = Get-Location; if($p){ Split-Path -Leaf $p.Path } else { '(unknown)' } } catch { '(unknown)' }
  }
  if (-not $Repo)   { $Repo   = Get-RepoNameSafe }
  if (-not $Branch) { $Branch = Get-GitBranchSafe }

  $ts=(Get-Date).ToUniversalTime().ToString('yyyyMMdd-HHmmssZ')
  $levels=@{OK='Green';SOFT='Yellow';HARD='DarkYellow';FATAL='Red'}

  $parts=@{}
  foreach($kv in ($Pulse -as [string]).Split('·')){
    $kv = $kv.Trim()
    if($kv -match '^(CU|PU|HU|WT):\s*(\w+)$'){ $parts[$Matches[1]]=$Matches[2].ToUpper() }
  }

  $clamp=[Math]::Max(-2,[Math]::Min(2,$Drift))
  $idx=[int]([Math]::Round((($clamp+2)/4.0)*8))
  $arr = @()
  for($i=0;$i -le 8;$i++){
    if($i -eq 4){ $arr += '|' }
    elseif($i -le $idx){ $arr += '■' }
    else { $arr += '·' }
  }
  $bar = ($arr -join '')

  $deadline=(Get-Date).AddSeconds($CountdownSec)
  for(;;){
    $left=[int]([Math]::Max(0,($deadline-(Get-Date)).TotalSeconds))
    Write-Host "`r" -NoNewline
    Write-Host "[CoStatus $ts]" -NoNewline -ForegroundColor Cyan
    foreach($k in 'CU','PU','HU','WT'){
      $v = $parts[$k]
      $c = if ($v -and $levels.ContainsKey($v)) { $levels[$v] } else { 'Gray' }
      Write-Host ("  {0}:{1}" -f $k,($(if($v){$v}else{'?'}))) -NoNewline -ForegroundColor $c
    }
    Write-Host ("  T-{0,2}s  drift:{1,0:N1}s [{2}]  repo:{3}  branch:{4}  {5}   " -f `
      $left,$Drift,$bar,$Repo,$Branch,$Note) -NoNewline
    if($left -le 0){ break }
    Start-Sleep -Milliseconds 250
  }
  Write-Host ''
}
Export-ModuleMember -Function Use-CoStatus