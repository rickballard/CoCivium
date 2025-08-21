\# ISSUEOPS — Quick Start (PS7)



\*\*Purpose:\*\* tiny, copy-pasteable CLI for routine CoCivium repo ops.  

\*\*Prereqs:\*\* PowerShell 7+, Git, GitHub CLI (`gh auth login`).



---



\## 0) Set repo + lookback window

```powershell

$Repo    = "rickballard/CoCivium"

$Minutes = 120

$Cutoff  = (Get-Date).AddMinutes(-$Minutes)



