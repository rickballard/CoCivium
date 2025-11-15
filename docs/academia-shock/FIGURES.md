# Figures (Detailed Captions)

**Figure 1 — Multilarity Staircase.**  
Autonomy accumulates via *micro-capabilities* (prompt tools → typed DSL → toolcaps → job orchestration), not a single leap. Each step adds egress, file IO, or identity scope. Defense: typed interfaces, default-deny egress, signed toolcaps, and fast rekey/kill.

**Figure 2 — Toolchain Breakout Map.**  
Common breakout paths from LLM → CLI → package manager → network → cloud API. Mark pre-conditions and controls at each edge (capability attestation, syscall fences, egress filters, human-in-the-loop gates).

**Figure 3 — Service Containment Pipeline.**  
From request → classify → plan → execute → verify → archive receipts. Defense hooks at classify/plan (policy), at execute (toolcap limits, SBOM/enclave), at verify (checksums, signatures), at archive (immutable logs + retention).

**Figure 4 — Defense Stack (Five Planes).**  
Identity/Capability; IO Hygiene; Isolation; Provenance; Detection & Response. Each plane shows concrete controls (e.g., OIDC-scoped tokens; sandboxed FS; network egress ACL; Sigstore-signed artifacts; anomaly monitors).

**Figure 5 — Governance Loop.**  
CoCivium-style civic guardrails: policy → run → receipt → public audit → policy update. Emphasizes *forkability* (no crowns), *legibility* (plain English + machine receipts), and *revocability* (rotate keys/roles fast).
