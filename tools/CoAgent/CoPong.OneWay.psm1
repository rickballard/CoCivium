Set-StrictMode -Version Latest
$script:LogRoot = Join-Path $HOME "Downloads\CoCivium-Logs"
New-Item -ItemType Directory -Force -Path $script:LogRoot | Out-Null

function Ensure-CoWin32Types {
  if (-not ("Native.Win32" -as [type])) {
    Add-Type -Namespace Native -Name Win32 -MemberDefinition @"
[System.Runtime.InteropServices.DllImport("user32.dll")] public static extern bool SetForegroundWindow(System.IntPtr hWnd);
[System.Runtime.InteropServices.DllImport("user32.dll")] public static extern bool IsIconic(System.IntPtr hWnd);
[System.Runtime.InteropServices.DllImport("user32.dll")] public static extern bool ShowWindow(System.IntPtr hWnd, int nCmdShow);
[System.Runtime.InteropServices.DllImport("user32.dll")] public static extern System.IntPtr GetForegroundWindow();
[System.Runtime.InteropServices.DllImport("user32.dll")] public static extern bool GetWindowRect(System.IntPtr hWnd, out RECT r);
public struct RECT { public int Left; public int Top; public int Right; public int Bottom; }
"@
  }
  Add-Type -AssemblyName System.Windows.Forms -ErrorAction SilentlyContinue
  Add-Type -AssemblyName System.Drawing       -ErrorAction SilentlyContinue
}

function Start-CoTranscript([string]$Tag='auto') {
  New-Item -ItemType Directory -Force -Path $script:LogRoot | Out-Null
  $path = Join-Path $script:LogRoot ("{0}-{1}.ps1log" -f $Tag,(Get-Date -Format 'yyyyMMdd_HHmmss'))
  Start-Transcript -Path $path -IncludeInvocationHeader | Out-Null
  $global:__CoPingLog = $path
}

function Get-CoLatestTranscriptPath {
  $v = Get-Variable -Name __CoPingLog -Scope Global -ErrorAction SilentlyContinue
  if ($v -and $v.Value -and (Test-Path $v.Value)) { return $v.Value }
  $last = Get-ChildItem $script:LogRoot -Filter *.ps1log -ErrorAction SilentlyContinue |
          Sort-Object LastWriteTime -Descending | Select-Object -First 1
  if ($last) { return $last.FullName }
  return $null
}

function Ensure-Transcript {
  $p = Get-CoLatestTranscriptPath
  if (-not $p) { Start-CoTranscript 'auto' }
}

function Set-CoClipboard([Parameter(Mandatory)][string]$Text,[int]$Retries=4){
  Ensure-CoWin32Types
  for($i=1;$i -le $Retries;$i++){
    try {
      [System.Windows.Forms.Clipboard]::SetText($Text)
      Start-Sleep -Milliseconds (60 * $i)
      $got = [System.Windows.Forms.Clipboard]::GetText()
      if($got -and $got.Length -ge [Math]::Min($Text.Length,32)){ return $true }
    } catch {}
  }
  return $false
}

function Export-CoPongImageFromText([string]$Text,[int]$Width=1100,[int]$Pad=16,[string]$Font='Consolas',[int]$FontSize=12){
  Ensure-CoWin32Types
  $font   = New-Object System.Drawing.Font($Font,$FontSize,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Pixel)
  $tmpBmp = New-Object System.Drawing.Bitmap(1,1)
  $g      = [System.Drawing.Graphics]::FromImage($tmpBmp)
  $rect   = New-Object System.Drawing.RectangleF(0,0,$Width - 2*$Pad,1000000)
  $sf     = New-Object System.Drawing.StringFormat
  $sf.FormatFlags = [System.Drawing.StringFormatFlags]::LineLimit
  $size   = $g.MeasureString($Text,$font,$rect.Size,$sf)
  $g.Dispose(); $tmpBmp.Dispose()

  $height = [math]::Ceiling($size.Height) + 2*$Pad
  $bmp    = New-Object System.Drawing.Bitmap($Width,$height)
  $g2     = [System.Drawing.Graphics]::FromImage($bmp)
  $g2.Clear([System.Drawing.Color]::White)
  $g2.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
  $rectDraw = New-Object System.Drawing.RectangleF($Pad,$Pad,$Width-2*$Pad,$height-2*$Pad)
  $g2.DrawString($Text,$font,[System.Drawing.Brushes]::Black,$rectDraw,$sf)
  $g2.Dispose()

  $outPng = Join-Path $script:LogRoot ("copong_{0}.png" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
  $bmp.Save($outPng,[System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
  return $outPng
}

function Invoke-CoPongSend {
  param([string]$TitleLike='ChatGPT|OpenAI|Civium|Claude|Gemini|Bard',[int]$DelayMs=250)
  Ensure-CoWin32Types
  $procs = Get-Process chrome,msedge,firefox -ErrorAction SilentlyContinue |
           Where-Object { $_.MainWindowHandle -ne 0 -and $_.MainWindowTitle -match $TitleLike }
  $p = $procs | Select-Object -First 1
  if(-not $p){ Write-Warning "No browser window matching /$TitleLike/"; return }
  if([Native.Win32]::IsIconic($p.MainWindowHandle)){ [Native.Win32]::ShowWindow($p.MainWindowHandle,9) | Out-Null }
  [Native.Win32]::SetForegroundWindow($p.MainWindowHandle) | Out-Null
  Start-Sleep -Milliseconds $DelayMs
  [System.Windows.Forms.SendKeys]::SendWait("^(v)")
  Start-Sleep -Milliseconds 80
  [System.Windows.Forms.SendKeys]::SendWait("~")
}

function CoPong {
  param([int]$Lines=150,[switch]$CommandsOnly,[int]$MaxChars=12000,[switch]$Paste,[switch]$AsImage)

  Ensure-Transcript
  $parts=@()
  $logPath = Get-CoLatestTranscriptPath
  if ($logPath) {
    $raw = Get-Content -Path $logPath -Tail ($Lines * 4)
    $rxDrop = '^(PowerShell transcript (start|end)|\*{10,}|^→ Transcript:|^✓ CoPong:|^Command start time:|^<<< CoPong PS|^PS CoPong >>>)\b'
    $raw = $raw | Where-Object { $_ -notmatch $rxDrop }
    if ($CommandsOnly) {
      $raw = $raw | Where-Object { $_ -match '^\s*PS [^>]+>\s' -or $_ -match '^\s*>>' -or $_ -match '^\s*Line \|' -or $_ -match '^\s*At line' }
    }
    $parts += $raw
  }
  try {
    $hist = Get-History | Select-Object -Last $Lines | ForEach-Object { $_.CommandLine }
    if ($hist) { $parts += $hist }
  } catch {}

  if (-not $parts -or ($parts -join '').Trim().Length -eq 0) {
    $parts = @('(CoPong: nothing to copy yet.)')
  }
  $text = ($parts | Select-Object -Last $Lines) -join "`r`n"
  $usedImage = $false

  if(-not $AsImage -and $text.Length -gt $MaxChars){ $AsImage = $true }
  if($AsImage){
    $png = Export-CoPongImageFromText -Text $text
    Ensure-CoWin32Types
    [System.Windows.Forms.Clipboard]::SetImage([System.Drawing.Image]::FromFile($png))
    $usedImage = $true
  } else {
    $null = Set-CoClipboard $text
  }

  $out = Join-Path $script:LogRoot ("copong_{0}.txt" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
  $text | Set-Content $out -Encoding UTF8
  Write-Host ("✓ CoPong: {0} ({1}) saved → {2}" -f ($usedImage ? 'image on clipboard' : ('text '+$text.Length+' chars')) , (Get-Date), $out) -ForegroundColor Green

  if($Paste){ Invoke-CoPongSend }
}

# Aliases
Set-Alias CoPong150 CoPong
Export-ModuleMember -Function CoPong,Invoke-CoPongSend,Start-CoTranscript,Ensure-Transcript -Alias CoPong150
