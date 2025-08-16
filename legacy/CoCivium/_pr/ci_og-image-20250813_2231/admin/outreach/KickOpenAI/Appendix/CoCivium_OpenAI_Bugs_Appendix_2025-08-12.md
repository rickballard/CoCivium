# CoCivium → OpenAI: Workflow Bugs, Blocks, and Requests for Fixes  
**Date:** 2025-08-12  
**Authors:** Rick (user) and ChatGPT (assistant)  

---

## 0) Executive Summary
We rely on ChatGPT Plus (GPT‑5 Thinking / GPT‑5 / GPT‑4o) for day‑to‑day repository grooming, documentation authoring, and governance design under the **CoCivium** initiative.  Over the past weeks we have hit recurring workflow blockers that slow basic operations (reporting bugs, memory hygiene, file artifact delivery, repo reading, and model selection).  This appendix documents **repro steps, impact, and concrete fixes** we’re requesting.  A short public post will link to this file.

---

## 1) Environment
- **OS:** Windows 11 Version 24H2 (Build 26120.5733)  
- **Browser:** Chrome 139.0.7258.67 (64‑bit) — stable channel  
- **Location / TZ:** Ontario, Canada (America/Toronto, UTC‑4)  
- **User plan:** ChatGPT Plus  
- **Typical session pattern:** multiple concurrent chats, long‑form repo work, file creation/downloads, frequent use of code‑execution and browsing tools.  

---

## 2) High‑Priority Issues (with Repro & Impact)

### A. Help Center chat widget intermittently missing → cannot file support tickets
**Repro (intermittent):**
1. Navigate to `https://help.openai.com/` while logged in to ChatGPT (Plus).  
2. Expected: a chat bubble appears bottom‑right for support.  
3. Observed: no chat widget, no obvious fallback to reach a human.  
**Impact:** We cannot submit bug reports when the widget is absent; this blocks escalation.  
**Requests:**  
- Provide a stable “Submit a ticket” URL that works even when widget fails.  
- Offer an authenticated fallback email form for Plus users.  
- Add a visible “Support status” banner when the widget is degraded.

---

### B. “Saved memory full” friction and unclear controls
**Repro:** Memory reaches capacity during heavy multi‑project usage.  A banner or state indicates fullness, but tools to **inspect, bulk‑prune, export, and re‑import** memories are unclear or laborious.  
**Impact:** Models stop learning new long‑term facts, causing regressions across projects.  
**Requests:**  
- Show **clear usage meter** with soft and hard limits.  
- Provide **bulk operations** (merge, tag, archive, export/import).  
- Add **per‑project memory partitions** and a “workspace‑scoped memory” mode.  

---

### C. File artifact delivery is unreliable for complex tasks
**Repro:** Assistant produces download links or external script links (e.g., ONEBLOCK installers).  Some links 404, expire, or are session‑scoped.  
**Impact:** We must re‑request artifacts or manually reconstruct them, wasting cycles and causing trust drops.  
**Requests:**  
- Provide **persistent, shareable artifact hosting** with SHA‑256 and expiry controls.  
- Allow **artifact regeneration** by ID without re‑running the whole conversation.  
- Expose a **per‑chat artifact browser** with lifecycle (created, replaced, expired).  

---

### D. Repo reading / large context ingestion is missing
**Repro:** We often need the assistant to read public GitHub repos and large zips.  Current browsing/file limits prevent end‑to‑end analysis.  
**Impact:** The assistant can’t see the live repo state, leading to instructions that don’t match reality.  
**Requests:**  
- Add **GitHub OAuth “read‑only workspace”** so the assistant can index specific repos selected by the user.  
- Permit **on‑demand zip ingestion** with progress, deduping, and size quotas.  
- Provide a **repo snapshot view** with search and citations into files/lines.  

---

### E. Multi‑chat project management
**Repro:** Complex work happens across multiple chats (e.g., “CoCivium repo migration,” “Branding,” “Bug reports”).  No native “project” container.  
**Impact:** Context fragmentation, repeated instructions, human copy‑paste overhead.  
**Requests:**  
- Introduce **Projects/Workspaces**: a named container for chats, files, memory partition, repo links, and settings (model pin, rate limits).  
- Allow **role‑based sharing** (read/comment) to collaborate with others or future AI helpers.  

---

### F. Model selection stickiness and regressions
**Repro:** After model changes, preferred models (e.g., GPT‑4o) disappear or are auto‑replaced.  Users need stability for ongoing operations.  
**Impact:** Breaks carefully tuned workflows.  
**Requests:**  
- Add **per‑project model pinning** with graceful fallback and change logs.  
- Publish **model deprecation timelines** and offer opt‑in “compat mode” windows.  

---

### G. UI: intrusive “submit file… chunk size 15000” pane
**Repro:** A persistent file‑submit box overlays the UI in some sessions, without an obvious way to hide it when not needed.  
**Impact:** Obstructs screen space and causes user confusion.  
**Requests:**  
- Add a **Hide/Show** toggle and remember the setting per chat.  
- Provide **contextual tips** explaining when and why the pane appears.

---

### H. Looping / silent tool errors during long operations
**Repro:** During long doc refactors or multi‑file edits, the assistant appears to loop or silently fail tool steps.  
**Impact:** Time loss, duplicate edits, human frustration.  
**Requests:**  
- Surface **transparent tool logs** with error messages and retry counts.  
- Add **“Stuck?” breaker** to reset tool state without losing chat history.  

---

## 3) Medium‑Priority Requests
- **Burst credits / higher message caps** for time‑boxed migration sprints.  
- **Better diff‑aware writing** for long Markdown docs and repos (patches against current repo state).  
- **Built‑in ONEBLOCK script packager** (idempotent, signed, with SHA‑256 and human‑readable install notes).  

---

## 4) Why this matters
We’re building **CoCivium**: a public‑interest governance and tooling project.  The assistant is our primary copilot.  Fixing the above would materially increase throughput, reduce error rates, and showcase ChatGPT as a serious partner for complex, multi‑month work.

---

## 5) Contact & Collaboration
- GitHub (public profile): `github.com/rickballard`  
- Will monitor replies on the forum thread that references this appendix.  

---

## 6) Appendix A — Observed incidents (selected)
- Help Center widget missing when attempting to submit bug report; fallback path unclear.  
- “Saved memory full” message and degraded continuity across sessions; no bulk prune/export.  
- Downloaded artifacts occasionally unavailable later (expired or 404); re‑generation required.  
- Assistant could not directly read large public repos; users forced to paste fragments.  
- Multi‑chat fragmentation during repo migration and grooming; no single project view.  
- Model availability changed mid‑work without stable pin or clear timeline.  
- Persistent UI pane (“submit file … chunk size 15000”) with unclear dismissal.  
- Long‑running tool loops during repo/content updates; limited visibility into tool state.

---

## 7) Appendix B — Acceptance tests (what “fixed” looks like)
- We can open a **reliable ticket** even when the Help widget fails.  Ticket ID is shown in‑product and via email.  
- Memory shows **usage %, bulk operations, and per‑project partitions**.  
- Artifacts have **stable URLs** and a **library UI** to retrieve any file produced in a chat.  
- The assistant can **index a selected GitHub repo** (read‑only) and cite files/lines.  
- A **Project** groups chats, artifacts, memory, and settings (including pinned model).  
- Model changes **respect our pins** and provide a **deprecation banner** with dates.  
- The file pane is **hideable**.  
- Tool failures are **visible**, debuggable, and recoverable without losing context.

---

_Thanks for taking this seriously.  We’re willing to pilot fixes and provide structured feedback._
