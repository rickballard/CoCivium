# Megazip Waves

**Definition.** A scheduled burst of curated, zip-first deliverables (scripts, docs, CI configs) shipped as auditable bundles with .sha256 sidecars and a Violet Receipt. Each wave is idempotent, repo-first, and CoBlock-actionable.

**Why.** Speed onboarding, de-risk demos, and standardize BPOE upgrades without chat latency.

**Default contents.**
- 	ools/ runnable CoBlocks (PS7), non-interactive
- .github/workflows/ CI guards/lints
- docs/ quickstarts + checklists
- erify/ .CoVerify.ps1 and smoke tests
- eceipts/ Violet Receipt template

**Lifecycle.** Plan → Package → Verify → Ingest to CoCache/advice/inbox → PR → Squash-merge → Receipt.

**Signals.** Wave tag: mw/<YYYYMMDD-HHMMSSZ>. NeedsFullCoSync: False by default.
