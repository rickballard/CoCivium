# BPOE Lessons — Browser Resilience (v1.0)

**Context:** Chrome stalled (pages never finishing, cache stuck). Root causes included AV web filtering and profile corruption.
**Goal:** Keep workflows fast & deterministic without turning CoCivium into a system tweaker.

## Lessons
- Default to **clean temp profile** for diagnostics; if it works, the profile is the problem.
- Safe-restore **only content** (Bookmarks, dictionary); reinstall extensions clean.
- Treat AV web-filter hooks and proxy/WPAD as first-class risk factors.
- Don’t rely on a single browser during critical ops; provide fallbacks (Edge/Brave).
- HealthGate should **report**, not mutate, browser/system state.

## Checklist (Runbook)
1. Close browser → launch temp profile with `--disable-extensions --disable-quic --disable-gpu`.
2. If good: restore Bookmarks & dictionary only; reinstall minimal extensions.
3. If bad: verify no proxy/WPAD; winsock/ip reset; check AV filters; nuke stale firewall rules.
4. If still bad: full uninstall → reinstall (enterprise MSI), start clean, then safe-restore.

