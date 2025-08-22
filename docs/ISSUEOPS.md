# IssueOps – quick cheat sheet

**Goal:** smallest useful change → visible, reviewable, reversible.

## 1) Say hi (2 minutes)
Open New issue → “Hello CoCivium”. One line about what you care about.
- https://github.com/rickballard/CoCivium/issues/new/choose

## 2) Share an idea (10 minutes)
Use the **Idea** form. Describe the problem and one smallest useful change.
- https://github.com/rickballard/CoCivium/issues/new?template=idea.yml

## 3) Start a post (PR) (30–60 minutes)
Draft under \/proposals/\ using the stub template, then open a PR.
- View template: https://github.com/rickballard/CoCivium/blob/main/proposals/stub_proposal-template.md
- Edit template in-browser: https://github.com/rickballard/CoCivium/edit/main/proposals/stub_proposal-template.md

**Labeling:** PRs that touch \/proposals/**\ are auto-labeled **post**.  
Add **docs** for documentation changes.

## Daily Workbench (one-click start)
Use **CoCivium-Workbench.bat** (Desktop). It runs a silent preflight and opens:
- ChatGPT
- Repo home: https://github.com/rickballard/CoCivium
- This cheat sheet: docs/ISSUEOPS.md

Logs: \~/Documents/CoCiviumLogs/preflight_latest.log\

## Common git one-liners
- See what changed: \git status\
- Stage everything: \git add -A\
- Commit: \git commit -m "docs: <message>"\
- Push: \git push\

## Troubleshooting
- “not a git repository” → you’re not in the repo. Run:
  \Set-Location "C:\Users\Chris\Documents\GitHub\CoCivium"\
- Windows wrote to System32 → always use absolute paths or \Set-Location\ first.

— end —