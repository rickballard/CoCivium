# CoCivBus™ / CoCivChat™ — Product Plan v0.1
**Tagline:** *The Session Orchestra.*  

**Summary.** CoCivBus is a vendor‑neutral session bus and protocol for coordinated, human‑in‑the‑loop AI work.  It gives parallel chats a deterministic, auditable way to share *status‑only* state: “read before reply; append after step.”  CoCivChat is the human‑facing client UX that rides CoCivBus and integrates with assistants via official connectors (e.g., OpenAI Actions).  No UI scraping.  No central choke point.  Privacy by minimization.  Interop by design.

---

## 1) Naming & messaging
- **Protocol/substrate:** **CoCivBus™**.  
- **Human UI:** **CoCivChat™**.  
- **Dev codename:** PromptQ.  
- **Positioning:** Human‑first coordination for AI + teams.  *Works with ChatGPT/Claude/Gemini.*  Not affiliated with vendors.

## 2) Problem & thesis
Parallel AI sessions lack a shared, deterministic state.  Memory and “projects” help recall but do not guarantee **ordering** or **cross‑chat awareness**.  CoCivBus supplies a minimal, signed event stream that any session can read/append, producing clean trails and preventing thrash.  Humans remain the primary readers and approvers.  Assistants use official connectors only.

## 3) Core principles
1. **Human‑in‑the‑loop.** No silent actions.  Status‑only entries, explicit handoffs.  
2. **ToS‑safe.** Integrations via official APIs/Actions.  Zero DOM scraping or UI automation.  
3. **Privacy by minimization.** No secrets in the bus.  Short, structured notes only.  
4. **Portability.** Plain JSON Lines with optional signatures.  Exportable and diff‑able.  
5. **Progressive decentralization.** Start simple, enable federated and P2P transports.  
6. **Auditability.** Immutable history + human‑readable Decision Records.

## 4) Personas & use cases
- **Solo power user:** Two tabs (Draft/Implement) kept in lockstep.  
- **Internal platform team:** Multi‑model experiments share status and next actions.  
- **Consultancies:** Cross‑vendor coordination with clients; Slack digest for humans.  
- **CoCivAI circle:** Governed multi‑agent collaboration with HumanGate.

## 5) Architecture (overview)
**Beacon** (small JSON pointer) → **Bus** (JSONL stream) → **Clients** (CLI/PS/Node + CoCivChat UI) → **Connectors** (OpenAI Action, others) → **Transports** (swappable).  

```
[Assistant/Chat] <--Action--> [CoCivBus API or Transport Adapter] <---> [Transport: Matrix | Nostr | Git/Gist | CRDT]
                                     ^                         ^
                                     |                         |
                               [CoCivChat UI]           [CLI/PS clients]
```

## 6) Protocol v0.1 (envelope)
- **Media:** JSON Lines (one event per line).  
- **Fields (required):** `ts` (RFC3339), `author` (id or label), `session` (slug), `status` (≤ 180 chars).  
- **Fields (optional):** `todos[]`, `chat` (shared link), `transport_meta` (opaque), `sig` (Ed25519), `kid` (key id).  

**Example (signed line):**
```json
{"ts":"2025-08-13T19:40:02-04:00","author":"rick@cociv","session":"ScopeSpec","status":"Outline v0 done.","todos":["refs","examples"],"chat":"https://chatgpt.com/c/...","kid":"did:key:z6M...","sig":"base64url..."}
```

**Signing (optional, recommended for T2/T3):**
- Ed25519 keypair per human/agent.  
- `sig = Ed25519(serialize_without_sig)`; verify on read.  
- Keys stored locally; rotation supported via `kid`.

## 7) Transports (swappable)
**T0 — Git/Gist (bootstrap).** Zero infra, fastest demo.  Public read via `raw.githubusercontent.com` or secret Gist.  Centralized and not private.  Use for trials only.  
**T1 — Matrix (default).** Federated, E2EE rooms.  One locked room per bus.  Self‑host Synapse/Conduit or pick a trusted server.  Media = small JSONL notes as text messages; signatures optional; read‑before‑reply discipline enforced at client.  
**T2 — Nostr (relay network).** Signed events across multiple relays.  Censorship‑resistant.  Good for open communities.  
**T3 — Local‑first CRDT (Yjs/Automerge).** True P2P semantics.  Volunteer relays forward encrypted blobs.  Best when offline/edit concurrency is key.

## 8) Security & privacy
- **Data class:** status‑only operational notes.  Strict rule: never put secrets in CoCivBus.  
- **Integrity:** optional Ed25519 signatures.  Replay protection by monotonic `ts` + per‑transport IDs.  
- **Retention:** per‑bus policy (e.g., 90 days).  Export to ZIP/JSON on rotation.  
- **Access:** transport‑level ACLs (Matrix room membership; Nostr pubkeys; private repos).  
- **Compliance:** clear privacy notice; no collection of sensitive personal data; minimal telemetry (opt‑in only).

## 9) Product surfaces
- **CLI/PS clients.** PS7 first, Node CLI for cross‑platform.  
- **CoCivChat UI.** Minimal desktop/window that shows bus tail, lets humans append, and previews diffs.  
- **OpenAI Action (ChatGPT).** `bus.append`, `bus.feed`, `bus.pin`.  Discovery via Custom GPT.  
- **Companion browser extension (optional).** Handles Beacons, shows status, opens Action‑enabled chat.  No DOM scraping.  
- **Slack/MS Teams digests.** Summaries of last N entries, configurable cadence.

## 10) Distribution
- **No centralized hosting required.** Default transport = Matrix.  We ship a small Matrix adapter and a quick self‑host guide.  
- **Installers:** GitHub Releases + checksums/signatures.  Winget/Homebrew later.  
- **Extension:** Chrome/Edge stores.  Source is public for auditability.  
- **Docs:** “5‑minute Quickstart,” “Transport choices,” “Threat model.”

## 11) Legal & compliance
- **ToS/Policy:** Official connectors only.  No UI scraping or automation.  
- **Licensing:** OSS core under Apache‑2.0 or MIT.  Transport adapters permissively licensed.  
- **Trademarks:** Start using **CoCivBus™**/**CoCivChat™** now.  Clearance search → intent‑to‑use filings (classes 9, 42).  
- **Marks:** “Works with X” phrasing only.  Explicit vendor disclaimers.  
- **Data:** Users own their content.  We store nothing centrally by default.

## 12) Roadmap
- **v0 (MVP):**  
  - Protocol v0.1 (JSONL + optional Ed25519).  
  - T0 Git/Gist + **T1 Matrix** adapters.  
  - PS7 and Node CLI clients; Beacon generator.  
  - OpenAI Action (append/feed/pin).  
  - Slack digest webhook.  
- **v1:**  
  - Nostr adapter; signed‑entry verification UI.  
  - Local key mgmt + rotation tool.  
  - Org “workspace” conventions (naming, retention).  
- **v2:**  
  - Local‑first CRDT transport.  
  - Policy controls (org RBAC), analytics (local, opt‑in), SOC2‑lite guide.  

## 13) Success metrics
- Setup in < 5 minutes without admin help.  
- ≥ 80% of steps logged during pilots.  
- “Delta‑catch accuracy” ≥ 95% (human survey).  
- 0 ToS violations; 0 PII leakage incidents.

## 14) Risks & mitigations
- **Users leak secrets.** Strong UI warnings; content lints; private transports; redaction helper.  
- **Vendor feature catch‑up.** We remain the interop/history layer across vendors.  
- **Adoption friction.** One‑liner installers + Beacons + no accounts.  
- **Regulatory climates.** Matrix/Nostr give federation and relay diversity.

## 15) Repo layout (proposal)
```
admin/
  products/
    CoCivBus/
      PLAN_v0.1.md
      SPEC_v0.1.md      # protocol details
      ACTION_openapi.yaml
      transports/
        matrix.md
        nostr.md
        git_gist.md
      ux/
        beacon_format.md
        quickstart.md
        extension_scope.md
```

## 16) Quickstart (operator)
1. Create a bus with the installer (PS7).  It writes a Beacon to Desktop.  
2. Drag the Beacon into your main chat, then into each parallel chat.  
3. Use `CoCache-Append` or the Action to log short status lines.  Keep entries terse and non‑sensitive.

## 17) Beacon format (v0.1)
```json
{
  "type": "cocivbus/beacon",
  "version": "0.1",
  "transport": "matrix|nostr|git|crdt",
  "bus_url": "public_read_url_or_room_addr",
  "session": "ShortName",
  "chat_shared_link": ""
}
```

## 18) OpenAI Action (sketch)
See `ACTION_openapi.yaml` alongside this plan.  Scopes: read/write minimal notes, no secrets.  Clear privacy notice in the GPT card.

## 19) Brand motif
Technical cues: waveform, harmonics, frequency grids.  No “musical instrument” visuals.  Colorway: desaturated neutrals + a single accent frequency line.

---

**Appendix A — Example DR stub**
```
# DR-YYYYMMDD-cocivbus-mvp
Decision: Approve CoCivBus MVP scope (v0).  
Rationale: Deterministic cross-session sync, ToS-safe, distributed-ready.  
Alternatives: Projects/Memory only; team clones; custom multi-agent app.  
Guardrails: HumanGate on; no secrets in bus; official connectors only.
```

**Appendix B — SESSION RULES (paste atop active chats)**
```
1) When I paste a CoCivBus beacon or send: CoCache:<URL>, treat that URL as the *session bus*.
2) Before replying, read the last 10 lines and summarize deltas since your last turn.
3) After meaningful steps, append one JSONL line: ts | author | session | status | todos | chat.
4) Never put secrets in the bus.  Keep lines terse.
```
