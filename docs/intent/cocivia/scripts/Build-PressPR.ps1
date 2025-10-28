# Build-PressPR.ps1
param([Parameter(Mandatory=$true)][string]$Repo)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
git -C $Repo switch -c "feat/press-launch-$(Get-Date -Format yyyyMMddHHmm)"
git -C $Repo add docs/intent/cocivia/press
git -C $Repo commit -m "press: brief + op-ed + Q&A + calendar"
git -C $Repo push -u origin HEAD
try { gh -C $Repo pr create -B main -t "Press: CoCivia launch pack" -b "Adds brief skeleton, op-ed draft, Q&A, comms calendar" } catch {}
