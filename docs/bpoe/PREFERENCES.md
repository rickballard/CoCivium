# BPOE Preferences (v1)

- Code blocks SHOULD show a clear end-marker in long DO blocks to reduce mid-render pastes.
- UI preference: copy button at the BOTTOM of each DO block. (Recorded; implement when UI is under our control.)
- Default to single-quoted here-strings when generating scripts to avoid expansion.
- Avoid pipeline/switch for multi-line ops; prefer `foreach($file in $files)`.

- DO/CoPong blocks: show ~20 visible lines with vertical scrollbar; copy button at bottom.

- DO blocks MUST restore prompt: Pop-Location (if used) or Set-Location $HOME immediately before "# END DO".

- Demarcation lines go INSIDE the DO block for drag-select:

  - DO:    # >>> DO START: <title>  …  # <<< DO END

  - CoPong: wrap the fenced JSON with <!-- COPONG:BEGIN <title> --> / <!-- COPONG:END -->

- Default to ~20 visible lines with vertical scrollbar for DO/CoPong code.

- Never use ChatGPT Automations/tasks. All scheduling and notifications must originate from repo workflows (CI) and files under `/index`.

- DO blocks are numbered & timestamped in a header comment; `# END DO` footer must appear after a final Set-Location $HOME.

- Default ~20 visible lines with vertical scrollbar for DO/CoPong code; copy button at bottom.
