---
policy_kind: ops
policy_id: OP-BP-ASSISTANT-BLOCKS-001
version: 0.4
---

# Assistant Blocks — Working Agreement (v0.4)

**Scope.** Applies to assistant-provided copy/paste shell blocks used in repos, issues, and PRs.

## Dialogue title (outside the code block)
- **Format:** `DO <i>/<n>, <SetName>; [yyyy-MM-dd HH:mm]; <brief>`
- **Time:** use **local time**; omit timezone.
- **Punctuation:** comma after DO counter; semicolons between fields.

## Handshake semantics
- **CoPing `<SetName>`** proposes a set of `n` DO blocks.
- **CoPong `<SetName> complete`** after all DOs, or **`CoPong <SetName> k/n`** for partial.
- **No CoPong ⇒ assume not executed.  Partial ⇒ only those k ran; no dependent chaining beyond k.**
- **Manual paste of PS7 output counts as a CoPong** for the active set.

## End-of-set demark banner (printed by tooling on completion or `???`)
```
[yyyy-MM-dd HH:mm] [END-SET] ✅ ----- End of DO Set (<SetName optional>) ----- ✅
```
- Surround with **three blank lines above and below** so it stands out at small font sizes.

## Planned-delay banner (no silent sleeps)
```
[yyyy-MM-dd HH:mm] ? ----- Planned wait: <Ns> (not stuck) -----
```
- One blank line above & below. Never `Sleep` without this banner.

## Execution guardrails
- **No interactive prompts** (avoid the `>>` continuation). Use array-of-lines + `Set-Content` or short `.ps1` helpers.
- **Docs-only by default** unless explicitly stated.
- **PR safety:** keep PRs **draft** during freezes and apply labels `do-not-merge`, `migration-safe`.
- **Diff check:** validate scope with `git diff --name-only origin/main...HEAD`.

## `???` Enter-trigger (session-only, product-gated)
- Trigger fires only when the current line is **exactly** `???` (no spaces) and Enter is pressed.
- **Session-only:** enabled/disabled by RepoAccelerator/CoAgent; no profile edits; auto “wash-away” on PS7 exit.
- **Hard gate:** requires **(a)** env flag `REPOACCEL_ACTIVE=1` or `COAGENT_ACTIVE=1`, **and** **(b)** CoCivium sentinel in the repo (any of:
  - `docs/ops/policy/BP_ASSISTANT_BLOCKS.md`
  - `docs/ISSUEOPS.md`
  - `README.assistant.md`
  )
- **Extra guardrail for CoAgent:** allow only when sentinel exists **or** a repo-root opt-in `.coagent-allow-copong` is present.
- On trigger: tail `.reports\ps7-transcript.log` (150 lines), scrub noise, copy to clipboard, and print the End-of-Set banner.
- **Overlapping CoPongs are fine**; each paste is an independent snapshot and helps monitor progress via timestamps.

## Maintainer notes
- Products must enable the trigger per-session (no profile writes) and disable it on shutdown.
- Provide an explicit uninstall that removes any legacy profile lines, if users had added them before v0.4.

## Integration Advisory — Product Shutdown
- Products (RepoAccelerator/CoAgent) must **disable the session trigger on shutdown** and ensure no residue:
  - Call `Disable-CoPongTrigger` during product exit/cleanup.
  - Clear session gates: unset `REPOACCEL_ACTIVE` / `COAGENT_ACTIVE`.
  - Do **not** write profile entries for `???` (session-only, wash-away on PS exit).
- CoAgent extra guardrail: enable only when a CoCivium sentinel exists **or** repo has `.coagent-allow-copong`.
