---
policy_kind: ops
policy_id: OP-BP-ASSISTANT-BLOCKS-001
version: 0.3
---

# Assistant Blocks — Working Agreement (v0.3)

**Scope.** Applies to assistant-provided copy/paste shell blocks used in repos, issues, and PRs.

## Dialogue title (outside the code block)
- **Format:** `DO <i>/<n>, <SetName>; [yyyy-MM-dd HH:mm]; <brief description>`
- **Time:** use **local time**; omit timezone.
- Punctuation: comma after the DO counter; semicolons between fields.

## End-of-set demark (printed in PS7 when a set completes)
- **Banner:** `[yyyy-MM-dd HH:mm] [END-SET] ✅ ----- End of DO Set (<SetName optional>) ----- ✅`
- Surround with **three blank lines above and below** so it pops at small font sizes.
- The banner is sufficient; avoid duplicate “ack lines” unless troubleshooting.

## Set / handshake semantics
- **CoPing `<SetName>`** announces a set of `n` DO blocks.
- You will **CoPong `<SetName> complete`** after all DOs, or **`CoPong <SetName> k/n`** for partial.
- **No CoPong ⇒ assume not executed.  Partial CoPong ⇒ assume only those k ran.**

## Execution guardrails
- **No interactive prompts** (avoid the `>>` continuation state). Use array-of-lines + `Set-Content`, or short `.ps1` helpers.
- **Docs-only by default** unless explicitly stated.
- **PR safety:** keep PRs **draft** during freezes and apply labels `do-not-merge`, `migration-safe`.
- **Diff check:** validate docs-only scope with `git diff --name-only origin/main...HEAD`.

