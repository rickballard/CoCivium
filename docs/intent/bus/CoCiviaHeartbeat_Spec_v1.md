# CoCivia Heartbeat · Spec v1

Role  : Nudge Co1 to remember CoCivia regularly.
Scope : CoCivium repo only. Co1 reads outputs when it wakes.

## Inputs

- CoSync notes that mention CoCivia:
  - docs/intent/advice/notes/**/CoSync_CoCivia*.md
- Optional repo signals (future):
  - PRs or issues tagged with "CoCivia" or "CoPortal".

## Output

- A heartbeat file written by automation:
  - docs/intent/advice/heartbeat/CoCivia/Heartbeat_<UTCSTAMP>.md

Each heartbeat MUST include:

- Timestamp (UTC).
- Pointers to the most recent CoSync_CoCivia* notes.
- A simple CoStatus line:
  - CoStatus [Bus:CoCiviaHeartbeat][Outcome:NudgeCo1IfOpened]
- One or more suggested next intents for Co1, such as:
  - "Spawn CoCiviaREST session to add /api/portal/meta"
  - "Revisit CoCivia CoPortal v0 spec and align with latest CoPortal standards."

## Consumer

- CoPrime session (Co1) MUST:
  - On start, look for the latest heartbeat under
    docs/intent/advice/heartbeat/CoCivia/.
  - Treat recent suggestions as candidates for new CoCivia-focused sessions.
  - Write a CoSync note back once those suggestions are acted on.

For now this is a simple weekly nudge, not a hard scheduler.
