<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# IdeaCard ΓÇö CoStasis: Repo All-Smokes & Health

**Problem / Tension**  
Workflows rot after upgrades or URL drift. We need periodic, repo-initiated smoke runs to detect breakage early.

**Hypothesis**  
Create **CoStasis** (monthly all-smokes). Generate disposable/dummy artifacts, auto-clean after.

**Value / Impact**  
Early detection; resilience; evolutionary pressure toward maintainability.

**Scope**  
- Scriptable smoke matrix (docs, CI, CLI, links).  
- Quarantine namespace for dummy outputs; guaranteed cleanup.

**Next Steps (90d)**  
- [ ] Spec smoke contracts per module.  
- [ ] CI job + local PS7 entrypoint.  
- [ ] Triage dashboard + auto-file issues.

**Tags:** #reliability #ops #ci #smoketests




