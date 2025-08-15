# Handoff Bundle (2025-08-14)

This folder captures state so a fresh session can resume without the chat log.

## Files
- **CoviumHandoff.odt** — environment, tasks, paste-safety, bug report
- **Backlog.odt** — master backlog & plan
- **cocivium_oneblocks.zip** — scripts (preflight, wiki seed, finance brief PR, labels/meta, paste-safety)
- **run_cocivium_oneblocks.ps1** — orchestrator (runner script included)

## Start here
1. Read \CoviumHandoff.odt\.
2. Review/merge PRs: **#69** (Consenti c2 uplift) and **#70** (Master backlog & plan).
3. Extract \cocivium_oneblocks.zip\ and run \un_cocivium_oneblocks.ps1\ from Downloads.
4. Finish **P0s** in \
otes/master_backlog.md\.
5. Wiki: verify Home / Getting-Started / Decision-Flow / Roles / Domains; link the Finance brief.
6. Funding: switch Sponsor to **Open Collective** when live; remove DogsnHomes notices.
7. CI: link-check (Lychee) is in place; add **markdownlint** and **spell-check** later.

## Known issues
- Chat instruction truncation / prompt pollution — see the bundle’s paste-safety notes and the included bug issue template.
