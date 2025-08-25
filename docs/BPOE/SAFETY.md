# Safety & Defaults

## BPOE — Session Bloat Guardrail

- **When to start a fresh chat:**
  - repeated `>>` stalls or paste errors,
  - ~100+ turns / very long instruction sets,
  - 3+ concurrent branches/PRs, or a new workstream.
- **Boundary ritual:** end with **CoStage** (commit/push/NEXT.md), then begin a new chat with branch & PR links.
- **Paste-safe code style:** prefer arrays + `Set-Content`; avoid here-strings in live chat pastes.
- **Prevent `>>`: run the here-string linter (warn-only) before committing.
- **Small PRs by default:** one purpose per PR.

