# BackChats-Config.ps1
param()
$script:RepoRoot  = (Resolve-Path "$PSScriptRoot/../../..").Path
$script:InboxDir  = Join-Path $RepoRoot "admin/inbox/backchats"
$script:HistDir   = Join-Path $RepoRoot "admin/history"
$script:Stamp     = (Get-Date -Format "yyyyMMdd_HHmm")
