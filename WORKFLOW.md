
# CoCivium · Workflow & Guardrails

This document captures the encoding, image, and README hygiene we just set up so future work (and new chat sessions) wastes less time.

---

## 1) Encoding & Newlines

- **All text files are UTF‑8, LF, with a final newline.** Enforced by `.editorconfig` in repo root:

```
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
```

### Mojibake guard
- The pre-commit hook runs `scripts/check-encoding.ps1` and **rejects commits** that contain typical mojibake (`Ã`, `Â`) or the replacement char `U+FFFD` in `README.md`. Extend to other files as needed.

```powershell
# scripts/check-encoding.ps1
param([string]$Path = "README.md")
$fffd = [string][char]0xFFFD
$txt = Get-Content -Raw $Path
if($txt -match 'Ã|Â' -or $txt.Contains($fffd)){
  Write-Host "✗ Encoding check failed: found mojibake tokens in $Path." -ForegroundColor Red
  exit 1
}
Write-Host "✓ Encoding looks good in $Path." -ForegroundColor Green
```

> **Tip:** To share hooks with collaborators and CI, put them under a versioned folder and point Git to it:
>
> ```bash
> git config core.hooksPath .githooks
> ```
> Then save the hook as `.githooks/pre-commit` (same content as in `.git/hooks/pre-commit`) and commit it.

---

## 2) Images and asset paths

- **Hero image:** `assets/hero/hero.jpg` (present). If missing locally, add a placeholder and commit; replace later.
- **Status graphic:** `assets/status/two-eyes.png` (present).
- Use these Markdown/HTML patterns:
  - Markdown: `![Alt text](./path/to/file.png "Optional title")`
  - HTML: `<img src="./path/to/file.png" alt="Alt" width="..." height="...">`

**Check for missing assets** from README:
```powershell
$repo = "$HOME\Documents\GitHub\CoCivium"; $P = Join-Path $repo 'README.md'
$md = Get-Content $P -Raw
$mdLinks   = [regex]::Matches($md,'!\[[^\]]*\]\(([^)\s]+)(?:\s+"[^"]*")?\)') | % { $_.Groups[1].Value }
$htmlLinks = [regex]::Matches($md,'<img[^>]+src=["'']([^"'']+)["'']') | % { $_.Groups[1].Value }
$paths = @($mdLinks + $htmlLinks) | ? { $_ -like './*' -or $_ -like 'assets/*' } | % { $_.Trim() -replace '^\./','' }
$paths | % { $local = Join-Path $repo $_; [pscustomobject]@{ Referenced=$_; Exists=(Test-Path $local) } } | Format-Table -AutoSize
```

---

## 3) Commit flow

1. Make your edits (UTF‑8/LF editors: VS Code, Cursor, etc.).
2. `git add -A`
3. `git commit -m "..."` → pre-commit will block if mojibake creeps in.
4. `git push`
5. Verify README renders correctly on GitHub (images load and quote block looks right).

> If you see: **`[pre-commit] inkscape not found; skipping local PNG render`** — that’s expected from the other local hook; it’s non-blocking.

---

## 4) Recovery quick-reference

- **Accidental mojibake:** don’t “fix” by opening/saving in old editors. Instead, recover from Git history, or ask the repair script to try recoding. Prefer recovering a clean historical commit if available.
- **Line endings weirdness:** ensure your editor uses LF, and `git config core.autocrlf false` (or let `.editorconfig` + editor manage it).

---

## 5) Extending the guardrails (optional)

- Add a CI check that runs `scripts/check-encoding.ps1` under PowerShell on Ubuntu/Windows to fail PRs with mojibake.
- Expand the checker to scan other user-facing docs (`*.md`, `docs/**/*.md`).

---

**Status (now):**
- README.md: clean (no mojibake).
- `assets/hero/hero.jpg`: present.
- `assets/status/two-eyes.png`: present.
- `.editorconfig`: present.
- Pre-commit guard: active locally; consider migrating to `.githooks` for team-wide sharing.
