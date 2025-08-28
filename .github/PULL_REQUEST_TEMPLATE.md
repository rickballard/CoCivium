# PR Checklist (Ops/Product Integration)
- [ ] If `???` trigger was enabled by tooling, it is **disabled on shutdown** (call `Disable-CoPongTrigger`).
- [ ] Session gates cleared on exit (`REPOACCEL_ACTIVE` / `COAGENT_ACTIVE`).
- [ ] No profile writes for `???` (session-only).
- [ ] For CoAgent: enabled only with CoCivium sentinel or `.coagent-allow-copong` present.
