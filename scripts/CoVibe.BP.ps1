# CoStack BP helpers: heartbeat, timeout, and HumanGate
function CoBP-NoOp { param(); "" | Out-Null }

function CoBP-WaitGate {
  param([string]$Message = "Press Enter to continue")  # [Press Enter]
  Read-Host $Message | Out-Null
}

function Invoke-CoSafe {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)][scriptblock]$Script,
    [int]$TimeoutSec = 180,
    [int]$HeartbeatSec = 5,
    [string]$Task = "task"
  )
  Write-Host ("-- starting {0} (timeout {1}s; heartbeat {2}s)" -f $Task,$TimeoutSec,$HeartbeatSec)
  $job = Start-Job -ScriptBlock $Script
  try {
    $elapsed = 0
    while ($true) {
      $state = (Get-Job -Id $job.Id).State
      if ($state -in 'Completed','Failed','Stopped') {
        Receive-Job -Id $job.Id -Keep 2>$null | ForEach-Object { $_ | Write-Host }
        if ($state -eq 'Completed') { Write-Host ("-- done: {0}" -f $Task); return $true }
        throw ("{0} ended with state {1}" -f $Task,$state)
      }
      Start-Sleep -Seconds ([Math]::Min($HeartbeatSec, [Math]::Max(1, $TimeoutSec - $elapsed)))
      $elapsed += $HeartbeatSec
      Write-Host ("... working ({0}s / {1}s)" -f $elapsed,$TimeoutSec)
      if ($elapsed -ge $TimeoutSec) { throw ("Timeout after {0}s: {1}" -f $TimeoutSec,$Task) }
    }
  }
  catch {
    Write-Warning $_
    try { Stop-Job -Id $job.Id -Force -ErrorAction SilentlyContinue } catch {}
    throw
  }
  finally {
    try { Remove-Job -Id $job.Id -Force -ErrorAction SilentlyContinue } catch {}
  }
}