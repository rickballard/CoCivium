<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# ISSUEOPS (refreshed)
- **One CoPong command** only; defaults to ~200 lines with overflow handling.
- **CoAgent** is the CoPingPong enabler; **RepoAccelerator** (deprecated), `???` shortcut (deprecated), and other legacy shorthands removed. Use the single CoPong path.
- **DO blocks**: keep brief/title on the first line; include timestamp in the title (YYYYMMDDHHmm).
- **Ack/heartbeat**: rely on the visible heartbeat rather than extra “CoPong ack” lines.
- **Bloat hygiene**: split at natural boundaries; prefer reseeding a fresh session when watchdogs warn.

See `/scripts/CoPingHeartbeat.ps1` and `/scripts/CoBloatWatch.ps1` for heartbeat & bloat monitoring.





