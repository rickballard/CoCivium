# Matrix Ops — Minimal

1) Start small.  Use a reputable hosted homeserver or run Synapse with sane defaults.  
2) Create two rooms: `#cocivai-audit` (public read‑only) and `#cocivai-council` (private E2E).  
3) Publish a `.well-known` for federation.  
4) If you must bridge to Discord, mirror **summaries** from the audit room only.  Never carry proposals/votes over bridges.  
5) Rotate keys and publish revocations.  Post hourly Merkle roots.
