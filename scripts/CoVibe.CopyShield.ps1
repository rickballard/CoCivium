function CoShield([Parameter(Mandatory)][string]$Key,[int]$Seconds=3){
  try{
    $dir = Join-Path $env:TEMP "CoVibeShield"; New-Item -ItemType Directory -Force $dir | Out-Null
    $file = Join-Path $dir ( ($Key -replace "[^A-Za-z0-9._-]","_") + ".lock" )
    $now = Get-Date
    if(Test-Path $file){
      $age = ($now - (Get-Item $file).LastWriteTime).TotalSeconds
      if($age -lt $Seconds){ Write-Host ("-- [CoShield] skipped duplicate within {0}s: {1}" -f $Seconds,$Key); return $false }
    }
    Set-Content -Path $file -Value $now.Ticks -Encoding ascii
    return $true
  } catch { return $true }
}
