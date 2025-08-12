# PromptQ — Product Card (_c0_) — 2025-08-12
**Status:** Parked (concept).  **Owner:** Rick.  **Repo:** CoCivium.  **Revisit by:** 2025-09-15.

## Elevator pitch
A prompt queue + orchestration layer for distributed teams and multiple LLMs (ChatGPT, Claude, Gemini, local).  Coordinate concurrent sessions, routing, retry, and audit.

## Target users
Teams coordinating many AI + humans; solo power users needing deterministic queues.

## Core value
Reduce friction, dead time, and duplication.  Provide auditable, rate-limit-aware prompt pipelines.

## Scope (MVP)
- Queue + prioritization + dedupe
- Providers: OpenAI, Anthropic, Google; HTTP plugin to extend
- Team board (web): submit, approve, rerun, diff outputs
- Audit log (JSONL) + export
- GitHub MCP/MCP Server integration (TBD)

## Exit criteria (ship MVP)
1) End-to-end route to 2 providers with fallback.  
2) Web board shows queued/processing/done with replay.  
3) JSONL audit persisted and exportable.  

## Kill criteria
If vendors ship equivalent orchestration with open hooks, or adoption < 5 teams in 60 days.

## Notes
Brand: “PromptQ (PQ)”.  License: AGPL/SSPL (TBD) with paid modules option.
