# CoCivGibber — Specification Overview (v0.1)

1) Envelope.  See `/protocols/CoCivGibber_v0_envelope.json`.  CBOR mapping is permitted; JSON is canonical for review.

2) Performatives.  `inform, query, propose, agree, refuse, vote, commit`.  New types are added via proposal and minor version bump.

3) Handshake.  See `/protocols/handshake.md`.  Sessions are short‑lived and require liveness pings.

4) Evidence.  All proposals and votes must link to artifacts by URI or content digest.  Public Merkle roots are posted hourly in the audit room.

5) Security model.  Trust is layered: operator VC + optional runtime attest + liveness + public audit.  Revocation is cheap and explicit.
