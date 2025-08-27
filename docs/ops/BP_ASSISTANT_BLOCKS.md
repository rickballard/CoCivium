# Assistant Blocks — Working Agreement (v0.1)

**Scope.** Applies to assistant-provided shell blocks in PRs/issues/notes.

## DO headers
- Format: `[YYYY-MM-DD HH:mm ET] DO-<n> — <title>`
- Timezone: ET; 24h clock.

## No interactive prompts
- Avoid PowerShell here-strings or constructs that leave the console at the continuation prompt `>>`.
- Prefer writing multi-line files via array-of-lines: `Set-Content -Value @(...)`.
- Prefer short, idempotent steps or dedicated `.ps1` helpers over long inline blocks.

## Copy/paste safety
- Default to docs-only changes unless explicitly stated.
- Label PR edits clearly; never touch protected branches from ad-hoc blocks.

## Example (no `>>`)
```powershell
$lines = @('line one','line two')
Set-Content -Path 'docs/example.md' -Value $lines -Encoding UTF8
```
