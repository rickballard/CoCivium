Set-StrictMode -Version Latest
$script:LogRoot = Join-Path $HOME "Downloads\CoCivium-Logs"
New-Item -ItemType Directory -Force -Path $script:LogRoot | Out-Null

function Ensure-CoWin32Types {
  if (-not ("Native.Win32" -as [type])) {
    Add-Type -Namespace Native -Name Win32 -MemberDefinition @"
[System.Runtime.InteropServices.DllImport("user32.dll")] public static extern bool SetForegroundWindow(System.IntPtr hWnd);
[System.Runtime.InteropServices.DllImport("user32.dll")] public static extern bool IsIconic(System.IntPtr hWnd);
[System.Runtime.InteropServices.DllImport("user32.dll")] public static extern bool ShowWindow(System.IntPtr hWnd, int nCmdShow);
"@
  }
  Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
}

function Ensure-Transcript {
  $v = Get-Variable -Name __CoPingLog -Scope Global -ErrorAction SilentlyContinue
  $ok = $v -and $v.Value -and (Test-Path $v.Value)
  if (-not $ok) {
    $path = Join-Path $script:LogRoot ("auto-{0}.ps1log" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
    Start-Transcript -Path $path -IncludeInvocationHeader | Out-Null
    $global:__CoPingLog = $path
  }
}

function Set-CoClipboard([Parameter(Mandatory)][string]$Text,[int]$Retries=4){
  for($i=1; $i -le $Retries; $i++){
    try { Set-Clipboard -Value $Text } catch {}
    Start-Sleep -Milliseconds (60 * $i)
    try { $got = Get-Clipboard -Raw } catch { $got = $null }
    if($got -and $got.Length -ge [Math]::Min($Text.Length,32)){ return $true }
  }
  return $false
}

function Focus-And-Paste {
  param([string]$TitleLike='ChatGPT|OpenAI|Civium|Claude|Gemini|Bard',[int]$DelayMs=250)
  Ensure-CoWin32Types
  $procs = Get-Process chrome,msedge,firefox,brave,opera -ErrorAction SilentlyContinue |
           Where-Object { $_.MainWindowHandle -ne 0 -and ($_.MainWindowTitle -match $TitleLike -or $_.MainWindowTitle) }
  $p = $procs | Select-Object -First 1
  if(-not $p){ Write-Warning "No browser window found to paste into."; return $false }
  if([Native.Win32]::IsIconic($p.MainWindowHandle)){ [Native.Win32]::ShowWindow($p.MainWindowHandle,9) | Out-Null }
  [Native.Win32]::SetForegroundWindow($p.MainWindowHandle) | Out-Null
  Start-Sleep -Milliseconds $DelayMs
  [System.Windows.Forms.SendKeys]::SendWait("^(v)"); Start-Sleep -Milliseconds 80; [System.Windows.Forms.SendKeys]::SendWait("~")
  return $true
}

function CoPong {
  [CmdletBinding()]
  param(
    [int]$Lines,
    [switch]$CommandsOnly,
    [switch]$NoSend,
    [int]$MaxChars = 12000,
    [string]$TitleLike = 'ChatGPT|OpenAI|Civium|Claude|Gemini|Bard'
  )
  Ensure-Transcript

  # sane defaults
  $base=200; $min=120; $max=600
  $logPath = $global:__CoPingLog
  $raw = @()
  if ($logPath -and (Test-Path $logPath)) { $raw = Get-Content -Path $logPath -Tail ($max*4) }

  $rxDrop = '^(PowerShell transcript (start|end)|\*{10,}|^→ Transcript:|^✓ CoPong:|^Command start time:|^<<< CoPong PS|^PS CoPong >>>)\b'
  $raw = $raw | Where-Object { $_ -notmatch $rxDrop }

  if ($CommandsOnly) {
    $raw = $raw | Where-Object { $_ -match '^\s*PS [^>]+>\s' -or $_ -match '^\s*>>' -or $_ -match '^\s*Line \|' -or $_ -match '^\s*At line' }
  }

  # heuristic sizing
  $bonus = 0
  $lastCmd = (Get-History | Select-Object -Last 1 | ForEach-Object CommandLine)
  if ($lastCmd -and ($lastCmd -match '(?i)\b(git|gh|pwsh|dotnet|npm|yarn|pnpm|pip|winget|choco|make)\b')) { $bonus += 80 }
  $tail120 = ($raw | Select-Object -Last 120) -join "`n"
  if ($tail120 -match '(?im)(^At line|^Line \s*\||^CategoryInfo|^FullyQualifiedErrorId|(?:^|\s)(error|fatal)\b|Exception:|Traceback)') { $bonus += 120 }

  if ($PSBoundParameters.ContainsKey('Lines')) {
    $want = [math]::Min($max,[math]::Max($min,$Lines))
  } else {
    $want = [math]::Min($max,[math]::Max($min,$base + $bonus))
  }

  try { $hist = Get-History | Select-Object -Last $want | ForEach-Object CommandLine; if ($hist) { $raw += $hist } } catch {}
  if (-not $raw -or ($raw -join '').Trim().Length -eq 0) { $raw = @('(CoPong: nothing to copy yet.)') }

  $text = (($raw | Select-Object -Last $want) -join "`r`n")
  if ($text.Length -gt $MaxChars) { $text = "…(truncated to $MaxChars chars)…`r`n" + $text.Substring($text.Length - $MaxChars) }

  $okClip = Set-CoClipboard $text | Out-Null

  $out = Join-Path $script:LogRoot ("copong_{0}.txt" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
  $text | Set-Content $out -Encoding UTF8
  Write-Host ("✓ CoPong: copied {0} chars; saved → {1}" -f $text.Length, $out) -ForegroundColor Green

  if (-not $NoSend) {
    if (-not (Focus-And-Paste -TitleLike $TitleLike)) {
      Write-Warning "Paste failed or no browser focused. Opening folder so you can drag-drop: $script:LogRoot"
      Start-Process explorer.exe $script:LogRoot
    }
  }
}

Export-ModuleMember -Function CoPong
