# MegaWave  -  Canonical Wave Workflow

**Goal:** Standardize “waves” (Megazip/AdviceBomb/ContentWave/…) as **manifested bundles** with **CI gates**, **receipts**, and **promotion lanes** across repos.

## Wave types
- `advicebomb`, `contentwave`, `indexwave`, `assetwave` (extensible)

## Layout (zip or folder)
- `_spanky/`  -  provenance, hashes
- `payload/`  -  primary content
- `notes/`  -  CoSync notes, human rationale
- `receipts/`  -  VIOLET receipts, CI artifacts
- `manifest/wave.manifest.json`  -  required schema

## Lifecycle
draft → candidate → approved
- **draft**: may contain placeholders; CI warns only
- **candidate**: must pass schema + safety + links + AA contrast (if images referenced)
- **approved**: published; cross-repo handoff recorded (CoSync note + PR ref)

## Required receipts
- `VIOLET_*` receipts in `receipts/`
- SHA-256 for the container (sidecar) + per-file hashes

## CI (must-pass)
- Schema validate `wave.manifest.json`
- No forbidden paths (e.g., site using `candidates/`)
- Link check/lint
- Safety/nasties guard
- Optional: image AA contrast gate for referenced assets

## CoSync bus
Every handoff writes a short note under `docs/intent/advice/notes/YYYYMMDD/CoSync_<UTCSTAMP>.md`
with: wave id, type, PRs opened/merged, next steps.

