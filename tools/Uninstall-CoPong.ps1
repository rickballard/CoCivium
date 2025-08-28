Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"
if (Get-Module CoPong-EnterTrigger) { try { Disable-CoPongTrigger } catch {} }
$profiles = @($PROFILE.CurrentUserAllHosts, $PROFILE.CurrentUserCurrentHost, $PROFILE.AllUsersAllHosts, $PROFILE.AllUsersCurrentHost) | Where-Object { $_ } | Select-Object -Unique
foreach($p in $profiles){ if(Test-Path $p){ $raw = Get-Content -Raw $p; $new = ($raw -split "`r?`n") | Where-Object { $_ -notmatch "CoPong-EnterTrigger|RepoAccelerator - CoPong trigger" }; ($new -join "`r`n") | Set-Content -Encoding UTF8 $p } }
Write-Host "CoPong trigger uninstalled from session and any legacy profile entries scrubbed (if found)." -ForegroundColor Green
