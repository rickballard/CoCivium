# Asset B — Counter-Harmony & Red-Team Scenarios

**Claim:** Harmony can be maladaptive when it suppresses necessary dissent, creates brittle consensus, or invites capture.

## Steelman Counter-Arguments
- **Consensus brittleness:** shared scaffolding risks correlated failure; pluralism must be enforced.
- **Capture risk:** centralized canon can be gamed; require objection windows + rollback criteria.
- **Overfitting to evals:** metric myopia; diversify evals and rotate challenges.

## Red-Team Scenarios (with rollback triggers)
1. **Monoculture failure:** two providers simultaneously regress → freeze auto-merge; require human ACK.
2. **Citation erosion:** PRs drift from pinned commits → CI fails “pinned-citation” check.
3. **Scope creep:** agents exceed caps → auto-revert and open incident → new test before retry.

## What to Measure (anti-capture)
- Provider diversity (% of critical paths).  
- Incident rate + time-to-new-test.  
- Citation validity % (pinned & resolvable).  
- Auto-rollback efficacy (MTTR).

## Prompt for the Luminaries
- **Counter-Harmony (steelman):** “Write the strongest case against harmony and specify testable guardrails + rollback criteria.”
