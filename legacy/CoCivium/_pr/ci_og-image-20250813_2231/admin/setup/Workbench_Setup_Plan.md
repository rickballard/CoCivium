# CoCivium One-Click Workbench — Setup Plan (v0.1, 2025-08-09)

## Outcomes
- One desktop action opens a **CoCivium** workbench: repos, tools, and ChatGPT prepped with context.
- Durable **Custom Instructions** + a compact **CIVPACK** to rehydrate context quickly.
- Public sidecar (**GIBindex**) for intersession notes (branch protection + CI live).
- Clear **data controls**: what ChatGPT remembers vs what we keep in repos.

---

## Phase 0 — Guardrails
- No secrets in chats/repos; use the browser password manager + Git Credential Manager/SSH.
- Keep ChatGPT Memory minimal; rely on **CIVPACK** + repo pointers.
- Use official **Connectors** (e.g., GitHub); don’t expect site logins via chat.

---

## Phase 1 — ChatGPT configuration
### 1.1 Custom Instructions (overwrite)
- **Who I am**: Rick; builds startups. Scientific, analytical; challenge inconsistencies. TZ: Toronto.
- **How to respond**: Forward-leaning; concise; call out risks; command-ready checklists; link to **CoCivium**/**GIBindex** sources.
- **Canonical context sources**:
  - CoCivium: `README_FOR_AI.md`, `admin/Last_Session_Context.md`, `admin/*_commit.txt`
  - GIBindex: `sessions/` (latest) + `entries/` schema

### 1.2 CIVPACK v1 (paste at session start)
::civpack v1
repo: CoCivium https://github.com/rickballard/CoCivium
repo: GIBindex  https://github.com/rickballard/GIBindex
focus:
  - <today’s #1 goal>
  - <#2>
pointers:
  - CoCivium/admin/Last_Session_Context.md
  - CoCivium/admin/Intersessional_Profile.md
  - CoCivium/admin/*_commit.txt
  - GIBindex/sessions/ (latest)
blockers:
  - <who owns → next step>
next:
  1) <next action>
  2) <next action>
  3) <next action>

### 1.3 Memory & Data Controls
- Memory: keep only essentials (name, tone, repo anchors).
- Data Controls: decide training setting; export if needed.

### 1.4 Connectors
- Connect **GitHub** in ChatGPT (Settings → Connected apps → Connectors → GitHub) and scope to these repos.

---

## Phase 2 — Repos as source of truth
- **CoCivium**: add `admin/ENVIRONMENT.md` (browser profile, extension links, terminals, credential policy, paths); keep `Browser_Setup_and_Launcher.md` current.
- **GIBindex**: `README.md` (how sidecar is used), `sessions/LOG.md` for brief notes.

---

## Phase 3 — Browser workbench (Chrome profile “CoCivium”)
- Extensions: Refined GitHub, Gitako, MarkDownload, SingleFile, Tab Session Manager, AI Prompt Genius.
- Pinned tabs: CoCivium (Code/PRs/Actions), GIBindex (Code/PRs/Actions), `GIBindex/sessions/LOG.md`, ChatGPT, GitHub Notifications.

---

## Phase 4 — One-click launcher (Windows)
- `CoCivium-Workbench.bat`: launch Chrome (CoCivium profile) with tabs; open Windows Terminal with 2 Git Bash tabs (CoCivium & GIBindex); run preflight (`git fetch`, open PRs, CI status hints).
- Optional Task Scheduler at chosen Toronto time.

---

## Phase 5 — Quality of life
- Optional `commit-msg` hook: refresh `admin/*_commit.txt` when admin docs change.
- Optional nightly sidecar scan: append to `GIBindex/sessions/LOG.md` (open PRs, validator status).

---

## Next-session checklist
- Set Chrome profile “CoCivium”; record extensions in `ENVIRONMENT.md`.
- Hook up GitHub connector; confirm repo access.
- Paste Custom Instructions overwrite; test CIVPACK v1.
- Generate `CoCivium-Workbench.bat` and Windows Terminal profile.
- (Optional) Add commit hook + schedule daily sidecar scan.
