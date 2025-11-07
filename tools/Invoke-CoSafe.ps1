# CoSafe: non-interactive guardrails for CoBlocks
$ErrorActionPreference='Stop'
$PSNativeCommandUseErrorActionPreference = $true
$ProgressPreference='SilentlyContinue'
$env:GIT_PAGER=''; $env:GH_PAGER='cat'; $env:GH_PROMPT='disabled'; $env:GH_NO_UPDATE_NOTIFIER='1'
if(-not (Get-Command Invoke-CoRun -ErrorAction SilentlyContinue)){
  function Invoke-CoRun {
    param([Parameter(Mandatory)][string]$FilePath,[string[]]$Args=@(),[int]$TimeoutSec=180,[switch]$NoThrowOnTimeout)
    $psi=[System.Diagnostics.ProcessStartInfo]::new(); $psi.FileName=$FilePath
    foreach($a in $Args){ $null = $psi.ArgumentList.Add($a) }
    $psi.RedirectStandardOutput=$true; $psi.RedirectStandardError=$true; $psi.UseShellExecute=$false
    $p=[System.Diagnostics.Process]::Start($psi)
    if(-not $p.WaitForExit($TimeoutSec*1000)){
      try{$p.Kill($true)}catch{}; if(-not $NoThrowOnTimeout){ throw "Timeout $TimeoutSec s: $FilePath $($Args -join ' ')" }
      Write-Warning "Timeout $TimeoutSec s (killed): $FilePath $($Args -join ' ')"
    }
    $out=$p.StandardOutput.ReadToEnd(); $err=$p.StandardError.ReadToEnd()
    if($p.ExitCode -ne 0){ throw "Exit $($p.ExitCode): $FilePath $($Args -join ' ')\n$err\n$out" }
    if($err){ Write-Information $err }; $out
  }
}
function CoStep { param([string]$Msg) Write-Host "• $Msg" }
function git! { git --no-pager @Args }
function gh!  { gh  --no-ansi  @Args }
CoStep "CoSafe ready (no pagers, prompts, or TTY holds)."
