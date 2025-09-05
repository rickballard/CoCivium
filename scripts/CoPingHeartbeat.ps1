param([int]$Minutes=20)
Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"
while ($true) {
  $ts = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
  Write-Host ("[Heartbeat] {0} — session alive; consider reseed if sluggish." -f $ts)
  Start-Sleep -Seconds ($Minutes*60)
}
