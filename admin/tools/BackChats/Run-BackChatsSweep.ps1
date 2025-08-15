# Run-BackChatsSweep.ps1 (v0.6)
[CmdletBinding()]
param(
  [string]$Filter = "*.md;*.txt;*.jsonl",
  [switch]$DryRun
)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot/BackChats-Config.ps1"

$report = Join-Path $script:HistDir "BackChats_Sweep_$($script:Stamp).md"

# Gather files recursively, handle multiple patterns, unique by path
$patterns = $Filter -split ';'
$files = foreach($pat in $patterns){
  Get-ChildItem -Path $script:InboxDir -File -Recurse -Filter $pat -ErrorAction SilentlyContinue
}
$files = $files | Sort-Object FullName -Unique
if(-not $files){ Write-Host "No inbox files.  Add CoBus pulls or pasted chats."; exit 0 }

$lines = @("# BackChats Sweep — $($script:Stamp)","","Scanned: `"$($script:InboxDir)`"","")

foreach($f in $files){
  $raw = Get-Content -Raw -Encoding UTF8 $f.FullName
  $doLines = ($raw -split "`r?`n") | Where-Object { $_ -match '^(DO\s+[0-9A-Za-z]+)' }
  $psPaste = Select-String -InputObject $raw -Pattern '\[PASTE IN POWERSHELL\]' -AllMatches
  $lines += "## Source: $($f.FullName)"
  $lines += "- Bytes: $((Get-Item $f.FullName).Length)"
  $lines += "- Detected DO-lines: $($doLines.Count)"
  $lines += "- Detected PowerShell paste blocks: $($psPaste.Matches.Count)"
  if($doLines){ $lines += "### DO lines"; $lines += ($doLines | ForEach-Object { "- $_" }) }
  $lines += ""
}

$summary = $lines -join "`r`n"
if($DryRun){ $summary | Write-Host; exit 0 }
$summary | Out-File -Encoding utf8 -Force $report
Write-Host "Report written: $report"

