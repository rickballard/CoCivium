param([switch]$InstallTask)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Ensure repo root even when launched by Task Scheduler (starts in System32)
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
Set-Location $RepoRoot

$IsMonday = ((Get-Date).DayOfWeek -eq 'Monday')

function Get-StalePRs {
  try {
    gh pr list --state open --json number,isDraft,updatedAt,title,url |
      ConvertFrom-Json |
      Where-Object { -not $_.isDraft -and ((Get-Date) - [datetime]$_.updatedAt).Days -gt 21 }
  } catch { @() }
}

function Write-ReminderSummary {
  $checklist = @(
    '- [ ] PR surface'
    '- [ ] CI snapshot'
    '- [ ] BackChats sweep'
    '- [ ] OE snapshot (Mon only)'
  )

  $body = @()
  $body += '# Reminder Hub'
  $body += ''
  $body += 'Run `cc-hub` (or `pwsh -NoProfile -ExecutionPolicy Bypass -File "$HOME\Documents\GitHub\CoCivium\admin\tools\reminders\Run-ReminderHub.ps1"`).'
  $body += 'Then I''ll skim the generated `admin/history/Reminder_Run_*.md`.'
  if ($IsMonday) {
    $body += 'If today is Monday, also remind me to capture an OE snapshot with `pwsh -File admin/tools/bpoe/Record-Env.ps1`.'
  }
  $body += 'If any PRs are >21 days and not Draft, suggest `gh pr ready --undo <num>` or closing.'
  $body += ''
  $body += '## Hygiene'
  $body += ($checklist -join "`n")

  $stale=@();$tmp=Get-StalePRs; if($null -ne $tmp){ $stale=@($tmp) }
  if ($stale.Length -gt 0) {
    $body += ''
    $body += '### Stale PRs (>21d, not Draft)'
    $body += ($stale | ForEach-Object {
      "- #$($_.number): $($_.title) — $($_.url) → consider `gh pr ready --undo $($_.number)` or close"
    })
  }

  $outDir = Join-Path $RepoRoot 'admin/history'
  if (!(Test-Path $outDir)) { New-Item -Type Directory -Force $outDir | Out-Null }
  $out = Join-Path $outDir ("Reminder_Run_{0}.md" -f (Get-Date -Format 'yyyyMMdd_HHmmss_fff'))
  ($body -join "`n") | Set-Content $out -Encoding utf8
  Write-Host "Wrote $out"

  # keep only the latest 30 hub logs
  Get-ChildItem $outDir -Filter 'Reminder_Run_*.md' -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending |
    Select-Object -Skip 30 |
    Remove-Item -Force -ErrorAction SilentlyContinue
}

if ($InstallTask) {
  $taskName = 'CoCivium-ReminderHub'

  # Remove differently-named duplicates
  Get-ScheduledTask -TaskName "$taskName*" -ErrorAction SilentlyContinue |
    Where-Object { $_.TaskName -ne $taskName } |
    Unregister-ScheduledTask -Confirm:$false -ErrorAction SilentlyContinue

  # Register/replace canonical task (idempotent)
  $pwsh = (Get-Command pwsh -ErrorAction SilentlyContinue)?.Source
  if (-not $pwsh) { $pwsh = (Get-Command powershell).Source }

  $action    = New-ScheduledTaskAction -Execute $pwsh -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
  $trigger   = New-ScheduledTaskTrigger -Daily -At 08:30
  $settings  = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -MultipleInstances IgnoreNew
  $principal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive -RunLevel Highest

  $task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -Principal $principal
  Register-ScheduledTask -TaskName $taskName -InputObject $task -Force | Out-Null
  Write-Host "Installed/updated scheduled task '$taskName'."
  return
}

# Normal run (single-instance guard — literal, no expansion)
$mutex = New-Object -TypeName System.Threading.Mutex -ArgumentList @($false,'Global\CoCivium-ReminderHub')
if (-not $mutex.WaitOne(0)) { Write-Host 'ReminderHub already running; exit.'; exit 0 }
try { Write-ReminderSummary } finally { $mutex.ReleaseMutex(); $mutex.Dispose() }

