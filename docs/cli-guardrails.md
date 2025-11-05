<!-- status: stub; target: 150+ words -->
# CLI Guardrails (PowerShell)

**Always re-orient PS7 before any new instruction set.** Use:

```powershell
C:\Users\Chris\Documents\GitHub\CoModules = Join-Path $HOME 'Documents\GitHub\CoCivium'
if(!(Test-Path -LiteralPath $repo)){ throw "Repo not found: $repo" }
Set-Location -LiteralPath $repo; git status -sb;
```

See `scripts/enter.ps1` for the repo-scoped mutex and `-Force` pattern.


## One-liner bounce guard
- High-end mice can double-paste a single line.
- Prefer multi-line blocks; **or** add a no-op line before/after the one-liner:
```powershell
''|Out-Null
# your one-liner here
''|Out-Null
```
- Also end one-liners with `;`.



