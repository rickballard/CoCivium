# AI-Receipt: Pharmacy stock & refill loop (micro-grant)

**Context:** Out-of-stock med; two nearby pharmacies uncertain.

**Prompt to AI:**
> “Find in-stock <med> within 2km; draft a call script; prep a tiny fund link if price > \.”

**Steps:**
- Called 3 pharmacies (script v0.2); located stock at 1.4 km.
- Issued micro-grant link; reimbursed \.40.
- Logged price to neighborhood med-index.

**Artifacts:**  
- /receipts/2025-11-03_med-call-log.md  
- /receipts/2025-11-03_micro-grant.md

**One improvement:** Cache a rotating list of low-stock meds per week.

