---
policy_kind: ops
policy_id: OP-BP-ASSISTANT-BLOCKS-001
version: 0.2
---

# Assistant Blocks — Working Agreement (v0.2)

**Scope.** Applies to assistant-provided copy/paste shell blocks used in repos, issues, and PRs.

## Dialogue titles (outside the code block)
- Format: `DO <SessionCode> (<i>/<n>) [YYYY-MM-DD HH:mm ET] — <imperative title>. (CoPing <SessionCode>; CoPong after all <n> DOs.)`
- Example: `DO A7 (1/5) [2025-08-27 19:42 ET] — Ensure Purpose + link to Ops BP in README.assistant.md. (CoPing A7; CoPong after all 5.)`

## Set / handshake semantics
- **CoPing** `<SessionCode>` means a set of numbered DO blocks is being proposed.
- You will **CoPong `<SessionCode> complete`** after executing *all* DOs, or **`CoPong <SessionCode> k/n`** for a partial.
- If you **do not CoPong**, the assistant assumes the set was **not executed**.
- If you **CoPong partial** (e.g., `CoPong A7 3/5`), the assistant assumes **only those k blocks ran** and will not assume the rest.
- The assistant **does not chain dependent steps** until you CoPong (complete or explicit partial).

## Execution guardrails
- **No interactive prompts** (`>>`). Use array-of-lines + `Set-Content` (or small `.ps1` helpers) to avoid continuation mode.
- **Docs-only by default.** Keep changes in `README*` and `docs/**` unless explicitly requested.
- **PR safety.** During migration freeze keep PRs **draft** and labeled `do-not-merge`, `migration-safe`.
- **Timestamps.** Use ET, 24h clock in dialogue titles.
- **Diff check.** Validate branch diff is docs-only before/after edits: `git diff --name-only origin/main...HEAD`.

## Quick ET stamp helper
```powershell
[TimeZoneInfo]::ConvertTime([DateTimeOffset]::UtcNow,
  [TimeZoneInfo]::FindSystemTimeZoneById("Eastern Standard Time")).ToString("yyyy-MM-dd HH:mm 'ET'")
```
