Set-StrictMode -Version Latest
$script:HB_ID = 'BPOE.Heartbeat'
function Start-Heartbeat([string]$Msg='working'){
  if ($script:HBTimer) { return }
  if ($Msg) { Write-Host -NoNewline "$Msg " }
  $script:HBTimer = [System.Timers.Timer]::new(1000); $script:HBTimer.AutoReset = $true
  Register-ObjectEvent -InputObject $script:HBTimer -EventName Elapsed -SourceIdentifier $script:HB_ID -Action { Write-Host -NoNewline '.' } | Out-Null
  $script:HBTimer.Start()
}
function Stop-Heartbeat(){
  if (-not $script:HBTimer) { return }
  try {
    $script:HBTimer.Stop()
    Unregister-Event -SourceIdentifier $script:HB_ID -ErrorAction SilentlyContinue
    Get-Job -Name $script:HB_ID -ErrorAction SilentlyContinue | Remove-Job -Force -ErrorAction SilentlyContinue
  } finally {
    $script:HBTimer.Dispose(); $script:HBTimer = $null
    Write-Host ''  # newline after dots
  }
}
function Invoke-WithHeartbeat([string]$Msg,[scriptblock]$Block){
  Start-Heartbeat $Msg
  try { & $Block } finally { Stop-Heartbeat }
}