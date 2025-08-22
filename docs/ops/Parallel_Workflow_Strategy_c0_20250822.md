# Parallel Workflow Strategy (Experimental)
_Coherence tag: c0_  
_Version: 2025-08-22_  
_Lineage: Proposed by Rick; session-tested in “Continue CoCivium Migration” chat_  
_Status: Experimental (not yet standard in BPOE)_

## Purpose
To enable higher throughput during multitasking by splitting a session into two named parallel streams:
- **Stream A**: low-risk, straightforward tasks (e.g. PS7 pastes, boilerplate moves)
- **Stream B**: high-impact, high-context tasks requiring feedback or judgment (e.g. doc design, refactors, decisions)

## Structure
Each stream receives its own thread of attention and may include:
- Distinct identifiers (e.g. `StreamA:StatusUpdate`)
- Prepackaged instructions for Stream A (can proceed without discussion)
- Blocking gates for Stream B (discussion required)

## Usage
1. Tag workflows and pasted outputs as either A or B.
2. Use stream keywords or problem flags (`I saw red`) to flag failures or merge risks.
3. When in doubt, elevate from Stream A to B and pause execution.

## Notes
- Track experiment effectiveness before promoting to BPOE.
- Naming individual streams improves coordination and traceability.
- Use Matrix/CoCivBus as signal path when tabs diverge.

