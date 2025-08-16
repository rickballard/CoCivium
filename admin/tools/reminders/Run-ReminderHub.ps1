# Run-ReminderHub.ps1 — v0.3 (compact, parser-safe)
[CmdletBinding()]
param([switch]$NoBackChats,[switch]$NoCIScan,[switch]$NoPRScan,[switch]$NoOESuggest)
Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"

$stamp = Get-Date -Format "yyyyMMdd_HHmm"
$hist  = "admin/history"; New-Item -ItemType Directory -Force -Path $hist | Out-Null
$out   = Join-Path $hist "Reminder_Run_$stamp.md"
$lines = @("# Reminder Hub — $([datetime]::Now.ToString('yyyy-MM-dd HH:mm'))","")
function Add-Section([string]$t){ $script:lines += "## $t"; $script:lines += "" }

# 1) PR surface
if(-not $NoPRScan){
  Add-Section "PR status"
  try{
    $json  = gh pr list --state open --json number,title,isDraft,createdAt,updatedAt,url
    $items = if($json){ $json | ConvertFrom-Json } else { @() }
    if(!$items){ $lines += "_No open PRs._"; $lines += "" }
    else{
      foreach($p in $items){
        $age   = [int]((New-TimeSpan -Start ([datetime]$p.createdAt) -End (Get-Date)).TotalDays)
        $stale = ($age -gt 21 -and -not $p.isDraft)
        $lines += ("- PR #{0} — {1}  (age:{2}d){3}  {4}" -f $p.number,$p.title,$age, $(if($p.isDraft){" [DRAFT]"}else{""}), $p.url)
        if($stale){ $lines += "  - _Action:_ consider 'gh pr ready --undo $($p.number)' or rebase/close." }
      }
      $lines += ""
    }
  } catch { $lines += "_PR scan error_: $($_.Exception.Message)"; $lines += "" }
}

# 2) CI snapshot
if(-not $NoCIScan){
  Add-Section "CI snapshot"
  try{
    $runs  = gh run list --limit 10 --json workflowName,status,conclusion,createdAt,url
    $items = if($runs){ $runs | ConvertFrom-Json } else { @() }
    if(!$items){ $lines += "_No recent runs._"; $lines += "" }
    else{
      $lines += "| Workflow | Status | Conclusion | Age(d) | URL |"
      $lines += "|---|---|---|---:|---|"
      foreach($r in $items){
        $age = [int]((New-TimeSpan -Start ([datetime]$r.createdAt) -End (Get-Date)).TotalDays)
        $lines += "| $($r.workflowName) | $($r.status) | $($r.conclusion) | $age | $($r.url) |"
      }
      $lines += ""
    }
  } catch { $lines += "_CI scan error_: $($_.Exception.Message)"; $lines += "" }
}

# 3) BackChats sweep (dry run)
if(-not $NoBackChats){
  Add-Section "BackChats sweep (summary)"
  try{
    $dry = pwsh -NoProfile -ExecutionPolicy Bypass -File "admin/tools/BackChats/Run-BackChatsSweep.ps1" -DryRun 2>$null
    if([string]::IsNullOrWhiteSpace($dry)){ $lines += "_BackChats tool produced no output (ok if inbox empty)._"; $lines += "" }
    else{
      $head = ($dry -split "`r?`n") | Select-Object -First 40
      $lines += $head; $lines += "…(truncated)…"; $lines += ""
    }
  } catch { $lines += "_BackChats error_: $($_.Exception.Message)"; $lines += "" }
}

# 4) OE snapshot hint
if(-not $NoOESuggest){
  Add-Section "OE snapshot hint"
  $lines += "- If `admin/tools/*` changed recently or you updated tooling, capture OE:"
  $lines += "  `pwsh -File admin/tools/bpoe/Record-Env.ps1`"
  $lines += "- Weekly cadence reminder lives in docs/academy/BP_OE_WF.md."
  $lines += ""
}

($lines -join "`r`n") | Out-File -Encoding utf8 -Force $out
Write-Host "Reminder Hub wrote: $out"
