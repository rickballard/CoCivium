# Project LehaneOps

> **Target:** Chris Lehane (VP Global Policy, OpenAI)  
> **Objective:** Secure a 20‑min scoping call to launch a 6‑week pro‑bono **Governance Ops Kit** pilot for OpenAI’s Policy/Safety function.

> This package is a **shelved outreach kit**. Use the DO blocks below to install it into the `CoCivium` repo when you’re ready, run the watcher, and later generate the outreach email & one‑pager.

> ---

## Contents
> - `plans/01_precursor.md` — readiness checklist (InSeed.com, LinkedIn, PoC community, artifacts).  
> - `plans/02_outreach.md` — outreach letter + 1‑pager draft + timeline & KPIs.  
> - `artifacts/` — Governance Ops Kit (decision log template, risk tags, CI gate stub).  
> - `watchers/` — Lehane watcher (sources config, runner, report generator, scheduler setup).  
> - `reports/LehaneWatch.md` — rolling digest updated by the watcher.  

## DO Blocks (ONEBLOCK, copy‑paste in PowerShell 7)
> These assume your working repo is `C:\Users\Chris\Documents\GitHub\CoCivium` and you downloaded `Project-LehaneOps.zip` to `~/Downloads`.

### DO-1: **Install LehaneOps package into CoCivium™**
```powershell
# ONEBLOCK — DO-1 Install LehaneOps
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$Repo = Join-Path $HOME 'Documents\GitHub\CoCivium'
$Zip  = Join-Path $HOME 'Downloads\Project-LehaneOps.zip'
if (!(Test-Path $Repo)) { throw "Missing repo: $Repo" }
if (!(Test-Path $Zip))  { throw "Missing package: $Zip" }
# Extract under docs/outreach/LehaneOps
$Dest = Join-Path $Repo 'docs\outreach\LehaneOps'
New-Item -ItemType Directory -Force -Path $Dest | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($Zip, $Dest, $true)
Set-Location $Repo
git add .
git commit -m "LehaneOps: add shelved outreach kit (plans, artifacts, watcher)" | Out-Null
"✅ Installed to $Dest and committed. Next: DO-2 to configure watcher."
```

### DO-2: **Configure watcher & schedule (runs every 6 hours)**
```powershell
# ONEBLOCK — DO-2 Configure Lehane watcher + scheduled task
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$Repo = Join-Path $HOME 'Documents\GitHub\CoCivium'
$Path = Join-Path $Repo 'docs\outreach\LehaneOps\watchers'
Set-Location $Path

# Create local config from sample if missing
if (!(Test-Path '.\watch.config.json')) { Copy-Item '.\watch.sample.json' '.\watch.config.json' -Force }

# Register Scheduled Task (Windows Task Scheduler)
$TaskName = 'LehaneWatcher'
$Pwsh = (Get-Command pwsh).Source
$Script = Join-Path $Path 'Run-LehaneWatcher.ps1'
$Action = New-ScheduledTaskAction -Execute $Pwsh -Argument "-NoProfile -File `"$Script`""
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(5) -RepetitionInterval (New-TimeSpan -Hours 6) -RepetitionDuration ([TimeSpan]::MaxValue)
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -ExecutionTimeLimit (New-TimeSpan -Minutes 20) -StartWhenAvailable
# Remove existing task if present
if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) { Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false }
Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Settings $Settings | Out-Null

"✅ Watcher scheduled. It will update reports\LehaneWatch.md on each run."
"Next: DO-3 to run once now."
```

### DO-3: **Run watcher once now and update the report**
```powershell
# ONEBLOCK — DO-3 Manual run
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$Repo = Join-Path $HOME 'Documents\GitHub\CoCivium'
$W    = Join-Path $Repo 'docs\outreach\LehaneOps\watchers'
pwsh -NoProfile -File (Join-Path $W 'Run-LehaneWatcher.ps1')
Set-Location $Repo
git add .
git commit -m "LehaneOps: watcher manual run — refresh report" | Out-Null
"✅ Watcher ran and report updated."
```

### DO-4: **Pre‑launch verification (target + context)**
```powershell
# ONEBLOCK — DO-4 Verify target + context before outreach
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$Repo = Join-Path $HOME 'Documents\GitHub\CoCivium'
$W    = Join-Path $Repo 'docs\outreach\LehaneOps\watchers'
pwsh -NoProfile -File (Join-Path $W 'Invoke-PrelaunchCheck.ps1')
Set-Location $Repo
git add .
git commit -m "LehaneOps: prelaunch verification snapshot" | Out-Null
"✅ Prelaunch verification stored under reports/prelaunch/."
"If ✅, proceed to outreach: see plans/02_outreach.md"
```

> ---

## Notes
> - The watcher is **best‑effort** and respectful: minimal frequency, public sources only, and you control it via `watch.config.json`.
> - Nothing runs until you execute DO‑2 to schedule it.
> - You can disable the task via **Task Scheduler** or `Unregister-ScheduledTask -TaskName LehaneWatcher -Confirm:$false`.

