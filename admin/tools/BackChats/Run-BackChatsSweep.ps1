# Run-BackChatsSweep.ps1
[CmdletBinding()]
param([string]$Filter="*.md;*.txt;*.jsonl",[switch]$DryRun)
. "$PSScriptRoot/BackChats-Config.ps1"
$report = Join-Path $script:HistDir "BackChats_Sweep_$($script:Stamp).md"
$files = ($Filter -split ';' | ForEach-Object { Get-ChildItem -Path $script:InboxDir -File -Recurse -Filter # Run-BackChatsSweep.ps1
[CmdletBinding()]
param([string]$Filter="*.md;*.txt;*.jsonl",[switch]$DryRun)
. "$PSScriptRoot/BackChats-Config.ps1"
$report = Join-Path $script:HistDir "BackChats_Sweep_$($script:Stamp).md"
$files = ($Filter -split ';' | ForEach-Object { Get-ChildItem -Path $script:InboxDir -File -Filter $_ -ErrorAction SilentlyContinue }) | Sort-Object Name
if(-not $files){ Write-Host "No inbox files.  Add CoBus pulls or pasted chats."; exit 0 }
$lines=@("# BackChats Sweep — $($script:Stamp)","","Scanned: `"$($script:InboxDir)`"","")
foreach($f in $files){
  $raw = Get-Content -Raw -Encoding UTF8 $f.FullName
  $doLines = ($raw -split "`r?`n") | Where-Object { $_ -match '^(DO\s+[0-9A-Za-z]+)' }
  $psPaste = Select-String -InputObject $raw -Pattern '\[PASTE IN POWERSHELL\]' -AllMatches
  $lines += "## Source: $($f.Name)"
  $lines += "- Bytes: $((Get-Item $f.FullName).Length)"
  $lines += "- Detected DO-lines: $($doLines.Count)"
  $lines += "- Detected PowerShell paste blocks: $($psPaste.Matches.Count)"
  if($doLines){ $lines += "### DO lines"; $lines += ($doLines | ForEach-Object { "- $_" }) }
  $lines += ""
}
($lines -join "`r`n") | Out-File -Encoding utf8 -Force $report
Write-Host "Report written: $report"
 -ErrorAction SilentlyContinue }) | Sort-Object Name
if(-not $files){ Write-Host "No inbox files.  Add CoBus pulls or pasted chats."; exit 0 }
$lines=@("# BackChats Sweep — $($script:Stamp)","","Scanned: `"$($script:InboxDir)`"","")
foreach($f in $files){
  $raw = Get-Content -Raw -Encoding UTF8 $f.FullName
  $doLines = ($raw -split "`r?`n") | Where-Object { $_ -match '^(DO\s+[0-9A-Za-z]+)' }
  $psPaste = Select-String -InputObject $raw -Pattern '\[PASTE IN POWERSHELL\]' -AllMatches
  $lines += "## Source: $($f.Name)"
  $lines += "- Bytes: $((Get-Item $f.FullName).Length)"
  $lines += "- Detected DO-lines: $($doLines.Count)"
  $lines += "- Detected PowerShell paste blocks: $($psPaste.Matches.Count)"
  if($doLines){ $lines += "### DO lines"; $lines += ($doLines | ForEach-Object { "- $_" }) }
  $lines += ""
}
($lines -join "`r`n") | Out-File -Encoding utf8 -Force $report
Write-Host "Report written: $report"

