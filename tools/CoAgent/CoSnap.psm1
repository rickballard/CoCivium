Set-StrictMode -Version Latest
$script:SnapRoot = Join-Path $HOME "Downloads\CoCivium-Logs"
New-Item -ItemType Directory -Force -Path $script:SnapRoot | Out-Null

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

function Get-ActiveWindowRect {
  Ensure-CoWin32Types
  $h = [Native.Win32]::GetForegroundWindow()
  if($h -eq [IntPtr]::Zero){ return $null }
  $r = New-Object Native.Win32+RECT
  [void][Native.Win32]::GetWindowRect($h, [ref]$r)
  return [System.Drawing.Rectangle]::FromLTRB($r.Left,$r.Top,$r.Right,$r.Bottom)
}

function Capture-RectImage([System.Drawing.Rectangle]$Rect){
  Ensure-CoWin32Types
  $bmp = New-Object System.Drawing.Bitmap($Rect.Width,$Rect.Height)
  $g   = [System.Drawing.Graphics]::FromImage($bmp)
  $g.CopyFromScreen($Rect.Location,[System.Drawing.Point]::Empty,$Rect.Size)
  $g.Dispose()
  return $bmp
}

function CoSnap {
  [CmdletBinding()]
  param([switch]$Paste)
  Ensure-CoWin32Types
  Start-Sleep -Milliseconds 80
  $rect = Get-ActiveWindowRect
  if(-not $rect){ Write-Warning "No active window."; return }
  $bmp  = Capture-RectImage $rect
  $png  = Join-Path $script:SnapRoot ("cosnap_{0}.png" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
  $bmp.Save($png,[System.Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose()
  Write-Host "Saved: $png" -ForegroundColor Green
  if($Paste){
    [System.Windows.Forms.Clipboard]::SetImage([System.Drawing.Image]::FromFile($png))
    Start-Sleep -Milliseconds 120
    [System.Windows.Forms.SendKeys]::SendWait("^(v)"); Start-Sleep -Milliseconds 60; [System.Windows.Forms.SendKeys]::SendWait("~")
  }
  return $png
}

function CoSnapScroll {
  [CmdletBinding()]
  param([int]$Pages=2,[int]$DelayMs=180,[switch]$Paste)
  Ensure-CoWin32Types
  Start-Sleep -Milliseconds 80
  [System.Windows.Forms.SendKeys]::SendWait("^{END}")
  Start-Sleep -Milliseconds $DelayMs
  $rect = Get-ActiveWindowRect
  if(-not $rect){ Write-Warning "No active window."; return }
  $frames=@()
  for($i=0;$i -lt $Pages;$i++){
    $frames += ,(Capture-RectImage $rect)
    [System.Windows.Forms.SendKeys]::SendWait("{PGUP}")
    Start-Sleep -Milliseconds $DelayMs
  }
  [System.Windows.Forms.SendKeys]::SendWait("^{END}")
  $w = ($frames | ForEach-Object {$_.Width}  | Measure-Object -Maximum).Maximum
  $h = ($frames | ForEach-Object {$_.Height} | Measure-Object -Sum).Sum
  $out = New-Object System.Drawing.Bitmap($w,$h)
  $g   = [System.Drawing.Graphics]::FromImage($out)
  $y=0; foreach($f in $frames){ $g.DrawImage($f,0,$y); $y+=$f.Height; $f.Dispose() }
  $g.Dispose()
  $png = Join-Path $script:SnapRoot ("cosnap_scroll_{0}.png" -f (Get-Date -Format 'yyyyMMdd_HHmmss'))
  $out.Save($png,[System.Drawing.Imaging.ImageFormat]::Png); $out.Dispose()
  Write-Host "Saved scrollshot: $png" -ForegroundColor Green
  if($Paste){
    [System.Windows.Forms.Clipboard]::SetImage([System.Drawing.Image]::FromFile($png))
    Start-Sleep -Milliseconds 120
    [System.Windows.Forms.SendKeys]::SendWait("^(v)"); Start-Sleep -Milliseconds 60; [System.Windows.Forms.SendKeys]::SendWait("~")
  }
  return $png
}

Export-ModuleMember -Function CoSnap,CoSnapScroll
