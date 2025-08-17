# BPOE / Workflow Record

> Running log of material decisions, guardrails, and ops changes. Newest first.

## 2025-08-16 — Pre-launch ops & monitors

**Decisions**
- **Quiet ops:** No emails. Alerts posted here in chat only when urgent.
- **Dashboards:** Mini-table format (✅/❌/❗) for CoCivium status updates.
- **Matrix → Discussions relay:** Approved `card-md` in Matrix publishes under Rick-only authoring; perspective tags: **Rick — Left/Right/Whole Brain**.
- **Web scans:** Weekly digest for brand mentions; urgent-only fast alerts (reputation/security/legal/impersonation spikes).
- **Discussions watch:** Notify when **anyone other than `rickballard`** posts/comments.
- **GitHub emails:** Repo muted at your end; I’m the signal for urgent items.
- **Succession:** One-year-and-a-day trigger; **no secrets ever released**. `user-heartbeat` (manual) + `succession-guardian` (daily) + public `docs/succession-manifest.md`.

**Operational commands (reference)**
```powershell
# Mute repo notifications for your account (requires gh auth login)
gh api -X PUT repos/rickballard/CoCivium/subscription `
  -f subscribed=false -f ignored=true

# Manual heartbeat (starts/refreshes the “year and a day” timer)
gh workflow run user-heartbeat.yml --repo rickballard/CoCivium --ref main

# Sanity (list workflows)
gh workflow list --repo rickballard/CoCivium
