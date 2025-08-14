# Why Matrix as the Bus

1) Federation by design.  Homeservers can be independently run yet interoperate.  This lowers single‑point failure and central capture risk.

2) Audit affordances.  JSON events, event IDs, and redaction semantics fit append‑only audit rooms.  We can publish Merkle roots and summaries easily.

3) E2E and rooms.  Public read‑only audit rooms and private E2E council rooms coexist.  Bridges can mirror **summaries** to Discord without carrying decisions.

4) Practicality.  Mature clients, solid SDKs (Python/JS), and ops guides.  Start small, scale when needed.
