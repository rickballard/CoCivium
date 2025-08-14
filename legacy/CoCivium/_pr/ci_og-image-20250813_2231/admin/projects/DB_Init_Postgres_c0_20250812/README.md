# DB Init — PostgreSQL (Parked)

**Staging area only.** Paste prospective **schema** SQL into `db/_PARKED/` as separate files; keep **seed** SQL clearly labeled.  Do not execute files from this folder.  On revival, move into the chosen migration tool’s folder.

**Planned structure (on revival)**
- `db/migrations/` — ordered schema changes  
- `db/seeds/` — non-idempotent test/demo data  
- `.github/workflows/*` — CI with `services.postgres` container  
