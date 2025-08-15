# Record-Env.ps1 — capture local OE/BPOE environment into admin/history (v0.2)
[CmdletBinding()]
param()
$ErrorActionPreference='Stop'

function TryVer([string]$name, [string]$cmd, [string]$args='--version'){
  try{
    $p = Start-Process -FilePath $cmd -ArgumentList $args -NoNewWindow -PassThru `
         -RedirectStandardOutput "STDOUT.tmp" -RedirectStandardError "STDERR.tmp" -Wait
    $out = Get-Content -Raw -ErrorAction SilentlyContinue "STDOUT.tmp"
    if(-not $out){ $out = Get-Content -Raw -ErrorAction SilentlyContinue "STDERR.tmp" }
    Remove-Item -ErrorAction SilentlyContinue "STDOUT.tmp","STDERR.tmp"
    if($LASTEXITCODE -ne 0){ return "${name}: (error) $out".Trim() }
    return "${name}: $($out.Trim() -replace '\r','' -replace '\n+','  ')"
  } catch { return "${name}: not found" }
}

$stamp   = Get-Date -Format "yyyyMMdd_HHmm"
$outFile = "admin/history/OE_Snapshot_$stamp.md"

$lines = @("# OE/BPOE Snapshot — $(Get-Date -Format 'yyyy-MM-dd HH:mm')","","## System","")
$lines += "OS: $([System.Environment]::OSVersion.VersionString)"
$lines += "User: $env:USERNAME"
$lines += ""
$lines += "## PowerShell"
$lines += "PSVersion: $($PSVersionTable.PSVersion.ToString())"
$lines += ""
$lines += "## Tooling"
$lines += TryVer 'git'    'git'
$lines += TryVer 'gh'     'gh'     '--version'
$lines += TryVer 'node'   'node'   '--version'
$lines += TryVer 'npm'    'npm'    '--version'
$lines += TryVer 'python' 'python' '--version'
$lines += TryVer 'dotnet' 'dotnet' '--info'
$lines += ""
$lines += "## Notes"
$lines += "- Captured automatically by admin/tools/bpoe/Record-Env.ps1"

$lines -join "`r`n" | Out-File -Encoding utf8 -Force $outFile
Write-Host "Wrote $outFile"
