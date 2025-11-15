# Replication (Seed Harness)
- Harness scripts live in `tools/academia-shock/harness/`
- Run a demo: `pwsh -NoProfile -File tools/academia-shock/harness/run-demo.ps1 -Task demo-br`
- Receipts conform to `receipts.schema.json` and include SHA256s of produced artifacts.
- Replace synthetic metrics with real evaluations in MW6.x; keep receipts immutable.
