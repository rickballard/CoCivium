# BPOE Laws (v0.1)

**Law 1  -  Answer first.**  
Every deliverable must present tangible outputs *before* any ask or clarification.  
- Outputs include: files, code, links, exact commands, or an on-repo generator that reproduces outputs.
- “Definition of Done (DoD) for Advisors”: (a) deliverables exist and are locatable, (b) commit/push block provided, (c) only then ask for decisions.

**Law 2  -  Coevolve externally to ChatGPT.**  
All non-trivial artifacts must be reproducible *outside* the chat:
- Prefer generators that read sources-of-truth (CSV, code in repo) and produce artifacts deterministically.
- Never rely on ephemeral chat attachments; always provide a script to re-generate.

**Law 3  -  Diversify growth paths.**  
For new capabilities, maintain at least two paths:
- (A) repo-native scripts/tools; (B) optional chat assist.
- If (B) fails, (A) still ships.

**Law 4  -  Self-heal by default.**  
Each workflow must include a “rescue path” (how to rebuild outputs locally) and a one-liner commit block.

**Law 5  -  Guardrails are code.**  
Codify checks (answer-first, file existence, path sanity) as scripts or CI where possible.

## Implementation notes
- Provide “deliverables” section headers *above* any “questions/clarifications”.
- Include a commit-ready PowerShell block with absolute paths for Windows env.
- Ship generators under `tools/` and document usage in the README/playbook.

