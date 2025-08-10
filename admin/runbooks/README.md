# Admin Runbooks

This folder contains operational runbooks that can be pasted into a separate ChatGPT window (“sidecar”) to perform heavy or long-running operational tasks without blocking the main session.

## Contents
- `ChatGPT_Sidecar_Housekeeping_v1.txt` — Keep GPT up-to-date on CoCivium, CoCache, GIBindex (Civium legacy). Produces sync report, workqueue, commands, PR texts, and a Gibberlink summary for handoff.

## Usage
1. Open a new ChatGPT window.
2. Paste the entire runbook text.
3. Upload repo ZIPs or provide diffs + SHAs as requested.
4. When finished, copy the “Sync Phrase” back into the main session.
