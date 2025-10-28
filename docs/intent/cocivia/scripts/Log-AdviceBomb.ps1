# Log-AdviceBomb.ps1
param([Parameter(Mandatory=$true)][string]$ZipPath, [string]$CoCache="$HOME\Documents\GitHub\CoCache")
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$inbox = Join-Path $CoCache 'advice\inbox'
$dest  = Join-Path $inbox (Split-Path $ZipPath -Leaf)
Copy-Item $ZipPath $dest -Force
$sha = (Get-FileHash $dest -Algorithm SHA256).Hash
$shaFile = "$dest.sha256"; $sha | Out-File -Encoding ascii $shaFile
$log = Join-Path $CoCache 'advice\INBOX_LOG.md'
$line = '| ' + (Get-Date -AsUTC -Format 'yyyy-MM-ddTHH:mm:ssZ') + ' | ' + (Split-Path $dest -Leaf) + ' | ' + $sha + ' | CoCivia launch-prep v1.0 |'
Add-Content -Path $log -Value $line
Write-Host "Logged and checksummed."
