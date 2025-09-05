# CoCivium Best Practices: Operating Environment & Workflow (v1.0)

**Who:** any contributor/editor.  **Why:** get productive fast, avoid foot-guns.

## 0) TL;DR
1) Install PS7, git, gh, node, python (dotnet optional).
2) Record your OE and commit it with tool bumps:  `pwsh -File admin/tools/bpoe/Record-Env.ps1`
3) Work in small branches; open PRs early; Draft anything stale >21d.
4) Keep raw dumps in `admin/inbox/backchats/` (ignored). Promote only distilled docs.

## 1) Baseline Operating Environment (BPOE)
- Windows + **PowerShell 7.x**.
- **git** + **GitHub CLI** (`gh auth login`).
- **node** + **npm**, **python**; **dotnet** optional.
- Secrets stay local (DPAPI). **Never** paste passwords into chat or repo.

## 2) Daily workflow
```powershell
Set-Location "$HOME\Documents\GitHub\CoCivium"
git fetch origin
git switch main
git reset --hard origin/main
git switch -c "<topic>/<slug>-$(Get-Date -Format 'yyyyMMdd_HHmm')"
# …edit…
git add <paths>
git commit -m "<type>(scope): <message>"
git push -u origin HEAD
gh pr create --fill
```

## 3) Hygiene tools (run ad hoc)
- OE snapshot → `pwsh -File admin/tools/bpoe/Record-Env.ps1`
- CI snapshot → `pwsh admin/tools/CI/Run-CIStatusSnapshot.ps1`
- BackChats sweep → `pwsh admin/tools/BackChats/Run-BackChatsSweep.ps1` (finds `DO …`, `[PASTE IN POWERSHELL]`, TODO/checkbox/action)

## 4) PR & branch policy
- Small, reviewable PRs; descriptive titles.
- Branches auto-delete on merge.
- Draft PRs older than 21 days unless actively updated.

## 5) Secrets & tokens
- Matrix via `CoBus.ps1` uses local DPAPI token cache. Rotate by changing your Matrix password. No secrets in repo, ever.

## 6) Ready checklist
- [ ] OE snapshot exists in this PR if tools changed.
- [ ] CI snapshot captured or CI passing.
- [ ] BackChats sweep reviewed for TODO/DO lines.

