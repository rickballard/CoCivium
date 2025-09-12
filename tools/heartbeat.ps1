Set-StrictMode -Version Latest
$global:__BPOE_HB_ID = '__BPOE_Heartbeat'

function Start-Heartbeat([string]$Msg='working') {
  if (-not (Get-Variable __BPOE_HBTimer -Scope Global -ErrorAction SilentlyContinue)) {
    Set-Variable __BPOE_HBTimer -Scope Global -Value $null
  }
  if (-not (Get-Variable __BPOE_HBSub   -Scope Global -ErrorAction SilentlyContinue)) {
    Set-Variable __BPOE_HBSub   -Scope Global -Value $null
  }
  if ($global:__BPOE_HBTimer) { return }
  if ($Msg) { Write-Host -NoNewline "$Msg " }

  $global:__BPOE_HBTimer = [System.Timers.Timer]::new(1000)
  $global:__BPOE_HBTimer.AutoReset = $true

  Unregister-Event -SourceIdentifier $global:__BPOE_HB_ID -ErrorAction SilentlyContinue | Out-Null
  $global:__BPOE_HBSub = Register-ObjectEvent -InputObject $global:__BPOE_HBTimer -EventName Elapsed `
    -SourceIdentifier $global:__BPOE_HB_ID -Action { [Console]::Write('.') }

  $global:__BPOE_HBTimer.Start()
}

function Stop-Heartbeat() {
  if (-not (Get-Variable __BPOE_HBTimer -Scope Global -ErrorAction SilentlyContinue)) { return }
  if (-not $global:__BPOE_HBTimer) { return }
  try {
    $global:__BPOE_HBTimer.Stop()
    if ($global:__BPOE_HBSub) { Unregister-Event -SubscriptionId $global:__BPOE_HBSub.Id -ErrorAction SilentlyContinue | Out-Null }
    Unregister-Event -SourceIdentifier $global:__BPOE_HB_ID -ErrorAction SilentlyContinue | Out-Null
  } finally {
    $global:__BPOE_HBTimer.Dispose()
    $global:__BPOE_HBTimer = $null
    $global:__BPOE_HBSub   = $null
    Write-Host ''
  }
}

function Invoke-WithHeartbeat([string]$Msg, [scriptblock]$Block) {
  Start-Heartbeat $Msg
  try { & $Block } finally { Stop-Heartbeat }
}