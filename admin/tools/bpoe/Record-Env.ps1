# Record-Env.ps1 — capture local OE/BPOE with per-tool timeouts (v0.8)
[CmdletBinding()]
param([int]$TimeoutSec = 12,[switch]$SkipDotNet)
$ErrorActionPreference='Stop'
function ExecProbe([string]$name,[string]$cmd,[string]$args='--version',[int]$timeout=12){
  Write-Host ("[probe] {0} … (timeout {1}s)" -f $name,$timeout)
  try{
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $cmd; $psi.Arguments = $args
    $psi.RedirectStandardOutput = $true; $psi.RedirectStandardError  = $true
    $psi.UseShellExecute = $false; $psi.CreateNoWindow = $true
    $p = [System.Diagnostics.Process]::Start($psi)
    if(-not $p.WaitForExit($timeout * 1000)){ try{ $p.Kill() } catch {}; return "${name}: (timeout ${timeout}s)" }
    $out = $p.StandardOutput.ReadToEnd(); if([string]::IsNullOrWhiteSpace($out)){ $out = $p.StandardError.ReadToEnd() }
    if($p.ExitCode -ne 0){ return "${name}: (error) $out".Trim() }
    return "${name}: " + ([regex]::Replace($out.Trim(),'\r|\n+','  '))
  } catch { return "${name}: not found" }
}
$stamp = Get-Date -Format "yyyyMMdd_HHmm"
$outFile = "admin/history/OE_Snapshot_$stamp.md"
$lines = @("# OE/BPOE Snapshot — $(Get-Date -Format 'yyyy-MM-dd HH:mm')","","## System","")
$lines += "OS: $([System.Environment]::OSVersion.VersionString)"
$lines += "User: $env:USERNAME"
$lines += "","## PowerShell","PSVersion: $($PSVersionTable.PSVersion.ToString())",""
$lines += "## Tooling"
$lines += ExecProbe 'git'    'git'    '--version'   $TimeoutSec
$lines += ExecProbe 'gh'     'gh'     '--version'   $TimeoutSec
$lines += ExecProbe 'node'   'node'   '--version'   $TimeoutSec
$lines += ExecProbe 'npm'    'npm'    '--version'   $TimeoutSec
$lines += ExecProbe 'python' 'python' '--version'   $TimeoutSec
if(-not $SkipDotNet){ $lines += ExecProbe 'dotnet' 'dotnet' '--info' $TimeoutSec } else { $lines += 'dotnet: (skipped)' }
$lines += "","## Notes","- Per-tool timeout = $TimeoutSec s; long-running tools are truncated/marked timeout.","- Script path: admin/tools/bpoe/Record-Env.ps1"
$lines -join "`r`n" | Out-File -Encoding utf8 -Force $outFile
Write-Host "Wrote $outFile"
