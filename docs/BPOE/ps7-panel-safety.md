# PS7 panel safety (BPOE note)

Many CoStewards work with **PS7 tabs** and **markdown docs** open side by side.
It is easy – especially with tired eyes – to paste **README snippets or prose**
directly into a PS7 panel and hit <Enter>.

That causes PS7 to try to execute markdown as code:

- leading > are treated as unknown commands
- list items - ... become parse errors
- HTML comments <!-- ... --> blow up
- long narrative blocks flood the history

## BPOE guidance

- Keep **DO Blocks** in dedicated .ps1 scripts under 	ools\ whenever possible.
- When a DO Block is shown in a doc or chat:
  - Only paste the **pure PowerShell fenced block** into PS7.
  - Avoid pasting surrounding markdown headings, quotes, or comments.
- If a DO Block is long, consider:
  - saving it as 	ools/CoBlock_<Name>.ps1
  - and running it via:  
    pwsh -NoProfile -File .\tools\CoBlock_<Name>.ps1

## For future CoStewards

As the contributor base ages, **visual ergonomics** matter:

- Prefer short, clearly marked DO Blocks.
- Avoid mixing prose and code in ways that are easy to mis-copy.
- When in doubt, ship a .ps1 plus a one-line invocation instead of a long inline script.

This note exists so that “pasted markdown explosions” are treated
as a **design failure**, not a user failure.
