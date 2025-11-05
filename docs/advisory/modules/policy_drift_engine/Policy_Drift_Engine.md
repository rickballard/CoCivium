
# Policy Drift Engine  -  Spec
**Inputs:** canonical intent text, downstream usage snapshots, telemetry, appeal/incident logs.  
**Signals:** semantic delta, repro gaps, congruence decay, adoption anomalies.  
**Thresholds:** open RFC if delta ≥ τ_sem or repro < τ_repro for 2 windows.  
**Outputs:** Drift report, CanonScore adjustment, suggested edits, rollback candidates.


