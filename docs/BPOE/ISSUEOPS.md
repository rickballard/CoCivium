<!-- status: stub; target: 150+ words -->
# CoLex — CoVibe Workflow Lexicon

Use these single words in issues/PRs/chat to trigger standard actions (humans & bots):

- **CoPush** — Commit staged changes, push branch, open PR if needed.
- **CoBake** — Kick minimal CI (e.g., README smoke/link check) for the current branch.
- **CoSync** — Fetch & rebase current branch onto `origin/main`.
- **CoRescue** — Temporarily relax main protection, merge the target PR, restore protection.
- **CoProtect** — Apply branch-protection per `docs/bpoe/prefs.yml`.
- **CoCheck** — Print branch-protection summary for our repos.
- **CoPrefs** — Show where to edit CoVibe prefs (checkbox doc + YAML).
- **CoLog** — Append a short “lesson learned” line to `docs/bpoe/LESSONS.md`.
- **CoSet** — Use `CoSetStart/CoSetEnd` to wrap an instruction set (single snip at end).
- **CoSnip** — Print the copy delimiter only when a whole instruction set succeeded.

_Amend freely; this file is the ground truth of meanings._


See **[Workflow Tips](docs/bpoe/TIPS.md)** for copy/paste hygiene.
## Why this exists

This workflow packaging (CoVibe) is meant to **co-evolve** how humans and AI work together. Over time we may add **opt-in, privacy-first** metrics (e.g., counts of successful runs and recoveries—no source content) to keep improving speed, clarity, and **guardrails**. Using it helps shape safer, more capable tools for everyone.
- **CoPingPong** — The playful copy–run–paste loop. Copy after snip + `SET ... END`.

- **CoChat** — The parallel chat lane. Talk while blocks run; copy only after the snip + SET ... END.

- **CoSession** — Start a named session (sets a SID) so CoChat/blocks correlate across teammates.
- **CoMark** — Opens the trademark checklist & brand status docs.

<details>
<summary><strong>CoTip — share what you see (screenshots)</strong></summary>

Press **PrtScn** to copy the screen to clipboard, **Win+PrtScn** to save to *Pictures\Screenshots*, or **Win+Shift+S** to snip an area.
Then drag the image into ChatGPT so we can see exactly what you see.

</details>


