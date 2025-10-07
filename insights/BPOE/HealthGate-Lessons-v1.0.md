# BPOE Lessons — Host Health & Workflow Hygiene (v1.0)

**Context:** Repeated slowdowns and UI glitches were traced primarily to input hardware faults, AV exclusions, and power-plan throttle.  
**Objective:** Reduce spurious failures by codifying light preflight checks and clear hand-offs.

## Lessons
- Guard all dot-sources in profiles (`Test-Path`); forbid auto-launch lines.
- Add “HID hardware hygiene” (clean/replace keyboard/mouse) to first-tier troubleshooting.
- Prefer **read-only** preflight checks (HealthGate) before heavy workflows.
- Detect active AV and recommend **correct** exclusions (Defender vs MBAM).
- Keep CoAgent lean; hand off deep tuning to trusted tools on consent.

## Standard Checks (read-only)
CPU/Power, Storage (free space, TRIM, SMART OK), Network link+errors, Memory idle %, AV product detection, Hotkey storm detection, Git hygiene, 7-day Reliability offenders.

## Escalation
Offer “Fix / Learn More” with explicit consent; log Pass/Fail and reasons per run.

