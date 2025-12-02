# CoBus Events Spec v1

Role: Define how repos emit human-readable "events" as markdown entries.

Minimal shape (markdown):

```markdown
#### CoBusEvent CB_YYYYMMDD_Label

- when      : 2025-11-28T06:11:54Z
- session   : CoPrime20251128
- kind      : cocivia_heartbeat_processed
- repo      : CoCivium
- heartbeat : docs/intent/advice/heartbeat/CoCivia/Heartbeat_20251128T055009Z.md
- cosync    : CoSync_CoCiviaHeartbeat_20251128T061154Z.md
- summary   : Short human summary of what happened.
```

Notes:
- Keep CoBus markdown append-only.
- Later, tools may mirror these as JSON for machine consumption.
- Start with a CoCivium-local CoBus_Events.md, then expand to other repos.
