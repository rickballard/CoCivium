# DB Init — PostgreSQL — Parking Card (_c0_) — 2025-08-12

**Status:** Parked (Maybe).  **Owner:** Rick.  **Repo:** CoCivium.  **Reason:** Overload / deprioritized.  **Revisit by:** 2025-09-15.

## Scope when revived
Establish a Postgres baseline for CoCivium: choose a migration tool, define seed strategy, add CI service, lock env contracts.

## Exit criteria
1) Single migration tool chosen.  2) `DATABASE_URL` contract documented.  3) CI: fresh DB → apply migrations → tests pass.

## Kill criteria
If CoCivium adopts non-relational persistence across all services, or another module owns relational state.

## Risks of delay
Low.  Only blocks DB-dependent modules.

## Links
– Add issues/PRs here when revived.
