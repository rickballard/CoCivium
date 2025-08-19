# CoCivium — Community Objectives (v0.1)

## Constraints (Non-Negotiables)
- Human safety first; no features that plausibly increase risks to life/liberty/societal resilience.
- Reversible by default; irreversible steps require explicit safety review.
- Least privilege, explicit consent, visible kill switch.
- No partisan capture; no commercial lock-in.
- Transparent, auditable operations.

## Objectives (ordered)
1. Reduce contributor cognitive load (quiet ops, single source of truth).
2. Continuity under absence (succession manifest; no secret release).
3. Human-quality discourse & onboarding (Discussions that feel human; clear docs).
4. Proof-of-function beyond lint (runtime sanity).
5. Frictionless idea→discussion pipeline with human gates.
6. Reputation & abuse monitoring (digest + urgent spikes only).

## Decision Rules
- Blocker: any credible increase in human-harm risk.
- Prefer reversible paths; if irreversible, require safety label + approver.
- Choose least-privilege integration; document permissions & uninstall.
- Every action leaves a trace (BPOE, issues, PR notes, logs).

## Metrics (lightweight)
- 100% of irreversible changes carry **safety-approved**.
- Weekly sanity pass rate ≥ 95% rolling 4 weeks.
- Median time idea→Discussion ≤ 48h.
- Zero unresolved credible abuse/impersonation reports > 72h.
