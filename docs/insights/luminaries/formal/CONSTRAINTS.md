# Formalization Stubs (Illustrative)

Let `P` be a policy proposal, `H` its harms ledger, `N` a necessity proof, `R` a revert plan.

1. □(Deploy(P) → Exists(H) ∧ Exists(N) ∧ Exists(R))  
2. □(¬ExhaustedAlternatives(P) → ¬Deploy(P))  
3. □(HarmBoundExceeded(P) → Rollback(P) ∧ Repair(P))  
4. □(HumanImpact(P) → ObjectionWindow(P) ≥ τ_h)

Notes: These are stubs for discussion; link each □ constraint to evidence objects and audit checks.
