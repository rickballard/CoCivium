# CoCivBus™ — SPEC v0.1
**Tagline:** The Session Orchestra.

## Purpose
Deterministic, auditable, status-only coordination across parallel AI + human sessions.  Read before reply.  Append after step.  No secrets in the bus.

## Envelope (JSON Lines)
Required: 	s RFC3339, uthor, session, status (<=180).  
Optional: 	odos[], chat, 	ransport_meta, kid, sig (Ed25519).

Example:
{"ts":"2025-08-13T20:05:00-04:00","author":"rick@cociv","session":"ScopeSpec","status":"Outline v0 done.","todos":["refs","examples"],"chat":"<link>","kid":"did:key:z6Mk..","sig":"base64url..."}

## Behaviors
1) Reader MUST fetch latest N lines and summarize deltas before acting.  
2) Writer MUST append one line after a meaningful step.  
3) Clients MUST warn if status >180 chars or contains secrets.

## Transports (swappable)
T0 Git/Gist (bootstrap); T1 Matrix (default, E2EE room per bus); T2 Nostr (signed events); T3 Local-first CRDT.

## Security & Compliance
Optional Ed25519 signatures; transport-native ACLs; retention policy + export.  No DOM scraping; official APIs/Actions only.  Vendor-neutral “Works with X” phrasing.
