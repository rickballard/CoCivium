Set-StrictMode -Version Latest
function Get-LocalStamp { param([string]$Format="yyyy-MM-dd HH:mm"); Get-Date -Format $Format }
function Set-CoSetName { param([Parameter(Mandatory)][string]$Name) $env:COCIVIUM_SET_NAME=$Name }
function Show-CoDelay { param([int]$Seconds) Write-Host ""; Write-Host ("[{0}] ? ----- Planned wait: {1}s (not stuck) -----" -f (Get-LocalStamp), $Seconds) -ForegroundColor Yellow; Write-Host "" }
function Test-CoRepo { $sent=@("docs/ops/policy/BP_ASSISTANT_BLOCKS.md","docs/ISSUEOPS.md","README.assistant.md"); foreach($s in $sent){ if(Test-Path (Join-Path $PWD $s)){return $true}}; return $false }
function Test-CoContext {
  if ($env:REPOACCEL_ACTIVE -ne "1" -and $env:COAGENT_ACTIVE -ne "1") { return $false }
  if ($env:COAGENT_ACTIVE -eq "1") { if (Test-CoRepo -or (Test-Path (Join-Path $PWD ".coagent-allow-copong"))){} else { return $false } }
  else { if (-not (Test-CoRepo)) { return $false } }
  return $true
}
$script:__CoPongEnabled = $false
function Disable-CoPongTrigger { if (-not $script:__CoPongEnabled) { return }; try { Set-PSReadLineOption -AddToHistoryHandler $null; Set-PSReadLineKeyHandler -Key Enter -Function AcceptLine } catch {}; $script:__CoPongEnabled=$false }
function Enable-CoPongTrigger {
  if ($script:__CoPongEnabled) { return }
  if (-not (Get-Module PSReadLine)) { Import-Module PSReadLine -ErrorAction SilentlyContinue | Out-Null }
  if (-not (Test-CoContext)) { return }
  Set-PSReadLineOption -AddToHistoryHandler { param([string]$line) if ($line -match "^\?\?\?$") { $false } else { $true } }
  Set-PSReadLineKeyHandler -Key Enter -BriefDescription "CoPong ???" -LongDescription "Typed ??? → copy last transcript lines to clipboard & show demark" -ScriptBlock {
    param($key,$arg)
    $line=$null;$cursor=$null; [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line,[ref]$cursor)
    if ($line -match "^\?\?\?$") {
      if (-not (Test-CoContext)) { [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine(); return }
      $count = 150; $path = Join-Path $PWD ".reports\ps7-transcript.log"; $dir = Split-Path $path
      if (!(Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
      try { $script:__copong_started = $false; try { Start-Transcript -Path $path -Append -ErrorAction Stop | Out-Null; $script:__copong_started = $true } catch {}
      $raw = Get-Content -Path $path -Tail $count -ErrorAction SilentlyContinue
      $clean = @()
      if ($raw) { $clean = $raw | Where-Object { $_ -notmatch "^\*{5,}|$script:__copong_started = $false; try { Start-Transcript -Path $path -Append -ErrorAction Stop | Out-Null; $script:__copong_started = $true } catch {}
      if ($clean) { Set-Clipboard -Value ($clean -join "`r`n") }
      $copied = if ($clean) { $clean.Count } else { 0 }
      $set=$env:COCIVIUM_SET_NAME; $namePart = if ($set) { " ($set)" } else { "" }
      for($i=0;$i -lt 3;$i++){ Write-Host "" }
      Write-Host ("[{0}] [END-SET] " -f (Get-LocalStamp)) -NoNewline; Write-Host ("✅ ----- End of DO Set{0} ----- ✅" -f $namePart) -ForegroundColor Green
      Write-Host ("[{0}] Copied {1} lines to clipboard — switch to chat and press Ctrl+V to paste." -f (Get-LocalStamp), $copied) -ForegroundColor Green
      for($i=0;$i -lt 2;$i++){ Write-Host "" }
      try { [Console]::Beep(900,120) } catch {}
      [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
      try { [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt() } catch {}
      return
    } else { [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine() }
  }
  try { Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action { try { Set-PSReadLineOption -AddToHistoryHandler $null } catch {}; try { Set-PSReadLineKeyHandler -Key Enter -Function AcceptLine } catch {} } | Out-Null } catch {}
  $script:__CoPongEnabled = $true
}
Export-ModuleMember -Function Enable-CoPongTrigger,Disable-CoPongTrigger,Set-CoSetName,Show-CoDelay
