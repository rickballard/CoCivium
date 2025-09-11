<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# Workflow Learnings — 2025-08-26

1) **Profile hardening.** Never dot-source missing scripts.  Guard with `Test-Path` + `try/catch`; provide harmless stubs for calls that shouldn’t fail session start.
2) **PowerShell syntax.** Avoid `function Foo([string]="")`.  Use `param([string]$x="")`.
3) **Regex edge.** .NET regex doesn’t support `\Q … \E`.  Prefer literal replace or safe character classes.
4) **Mojibake hygiene.** Keep README headings ASCII.  Use a small Quick-Nav block; avoid emoji in H1.
5) **Line endings.** Enforce LF via `.gitattributes`; use `git add --renormalize .`; pre-commit can refuse CR.
6) **ExecutionPolicy.** Use `pwsh -ExecutionPolicy Bypass` process-scoped for unsigned local fixers (no persistent policy changes).
7) **Buried backlogs.** Use `docs/_backlog/` for advanced/internal indexes; don’t link from README until ready.










