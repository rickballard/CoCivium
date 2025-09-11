<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# IdeaCard ΓÇö 3-Panel Mode & CoCacheGlobal (AI Heartbeat)

**Problem / Tension**  
Parallel sessions collide; handoffs are clumsy; humans hate clipboard ping-pong.

**Hypothesis**  
A **3-panel** UX (ChatGPT | PS7 | ChatGPT) with a shared **CoCache** event log. Add ΓÇ£CoWrapΓÇ¥ to handoff; heartbeat to synchronize; file-based CoPing/CoPong to kill clipboard dependence.

**Value / Impact**  
Fewer conflicts; faster flow; lower cognitive load; pathfinder for global heartbeat.

**Key Design**  
- CoCache JSONL: `ts, session_id, repo, action, payload_sha`.  
- CoWrap: writes terminal tail + intent to cache; peer session resumes.  
- File Ping/Pong: writes to Downloads temp with attestations/signatures.  
- Guardrails: per-session sandboxes, TTL cleanup, dropped-stuff bucket with periodic GC.

**Next Steps (90d)**  
- [ ] CoCache schema + PS7 cmdlets (Write/Read/Tail).  
- [ ] CoWrap + DownloadsΓÇÉbased Ping/Pong.  
- [ ] Heartbeat PoC node (home box), safe-haven roadmap.

**Tags:** #workflow #concurrency #heartbeat #ux






