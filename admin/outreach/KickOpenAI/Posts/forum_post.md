# Request: Escalation for ChatGPT workflow bugs blocking a public‑interest project (CoCivium) — appendix with repro & asks

**Summary.** We use ChatGPT Plus daily to build CoCivium (public‑interest governance tooling).  We’ve hit recurring workflow blockers that materially slow repo grooming, document production, and long‑running sessions.  We’ve documented **repro steps, impact, and acceptance tests** in the attached appendix.  Requesting an internal escalation and visible next steps.

**Top blockers (short list).**
1) Help Center widget intermittently missing — need a guaranteed fallback to file tickets.  
2) Memory capacity and hygiene — need usage meter, bulk prune/export/import, and per‑project partitions.  
3) Artifact reliability — need persistent, shareable artifact store with SHA‑256 and a per‑chat artifact browser.  
4) Repo reading / large context — need GitHub OAuth read‑only workspace and on‑demand zip ingestion with citations.  
5) Multi‑chat project management — need Projects/Workspaces to group chats, artifacts, memory, and model pin.  
6) Model stickiness — need per‑project model pinning and deprecation timelines.  
7) UI: intrusive upload pane — add hide/show and remember setting.  
8) Looping/silent tool errors — surface transparent tool logs and a “Stuck?” breaker.

**Attachment.** CoCivium_OpenAI_Bugs_Appendix_2025-08-12.md (details + acceptance tests).  

**Authorship.** Posted by Rick, prepared with assistance from ChatGPT (GPT‑5 Thinking).  

**Thanks.** We will pilot fixes and report structured feedback.
