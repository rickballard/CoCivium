param(
  [string]$Path = "$env:TEMP\\CoPingSession.log",
  [int]$WarnMiB = 5,
  [int]$PollSec = 60
)
Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"
"[*] Watching {0} (warn at {1} MiB)" -f $Path, $WarnMiB
while ($true) {
  if (Test-Path $Path) {
    $size = (Get-Item $Path).Length / 1MB
    if ($size -ge $WarnMiB) {
      Write-Warning ("[BloatWatch] {0:N1} MiB ≥ {1} MiB — consider starting a fresh chat/session." -f $size, $WarnMiB)
    }
  }
  Start-Sleep -Seconds $PollSec
}
