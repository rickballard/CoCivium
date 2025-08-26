# Chat Bloat & CoWrap Workarounds

**Problem**: long sessions become sluggish/blocked; copy timing causes partial pastes; PS7 stalls lead to ambiguous state.

**Symptoms**:
- Partial-render copy hazards; prompts appear to be waiting without telling the user.
- Ctrl+C sometimes returns prompt but job may still be running.
- Need to CoWrap into fresh chat to continue.

**Evidence**: CoWrap handoff zip copied to evidence/

**Mitigations captured so far**:
- Only-Paste Execution + artifact gates (BPOE_NORMS.md).
- CoTip-PS7-001 (Enter → Ctrl+C → restart PS7), CoTip-PS7-002 (Atomic Paste Envelope), CoTip-PS7-003 (Verify by artifact).
- Paste Envelope v2 (UTF8BOM; prefer pwsh; tag START/END).

**Follow-ups (see DIVERSION_LOG.md)**:
- DIV-007 collapsed/ready-to-copy UI.
- DIV-008 guardrails in envelope.
- DIV-006 CI/branch-protection hygiene so tiny PRs can merge.

