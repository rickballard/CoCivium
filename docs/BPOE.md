# BPOE / Workflow Record

> Running log of material decisions, guardrails, and ops changes. Newest first.

## 2025-08-16 — Session wrap
- Mini-dashboard enabled (green/red/exclamation) for CoCivium status in chat.
- Succession stub planned: README link -> docs/succession-manifest.md.
- Quiet monitors: CI failures (30m), urgent Issues/PRs (hourly), Discussions by others (hourly).
- Web brand scan: weekly digest; urgent-only fast alerts.
## 2025-08-16 20:53 — Session checkpoint
- Status: all clear (no ❗/❌ shown).
- Added/updated: BPOE link + succession manifest; heartbeat ok.
- Next: continue Matrix→Discussions polish; keep CI green.
## 2025-08-16 21:19 — Session checkpoint
- Governance scaffolding committed (7f942dd): community objectives, ethics, PR safety gate, ops stubs, labels.
- Safety gate active on PRs (blocks high-risk until safety-approved).
- Next: add   ests/smoke + sanity.yml; stage Matrix↔Discussions L4 policy (dry-run).

### Fast start ritual (BPOE)

- One click: Desktop **CoCivium-Workbench.bat**
- Preflight runs silently; see `~/Documents/CoCiviumLogs/preflight_latest.log`
- Browser opens: ChatGPT (left), GitHub repo + **ISSUEOPS** (right)
- Keep extras out of startup (news, extra terminals) to reduce context switching



<!-- BPOE:CoPingPong START -->
### CoPingPong — one way only (keep it simple)
- **One command:** CoPong
  - Copies the last ~200 lines of transcript/history (auto-expands on errors/long tools), **focuses chat, pastes, and presses Enter**.
  - Use CoPong -NoSend to copy only.
- **Sizing heuristics:** base=200, min=120, max=600; adds +80 lines for big cmds (git|gh|npm|dotnet|pip|make|winget|choco), +120 if recent errors/stack traces.
- **Long output:** at MaxChars clamp, CoPong truncates tail (or your CoPong.OneWay can fallback to PNG).
- **No extra variants:** We standardized away CoSend and CoPong150. One true path is easier to teach/support.
<!-- BPOE:CoPingPong END -->


<!-- BPOE:OEHeartbeat START -->
### OE Heartbeat (keep the agent on-policy)
- Operator may send a single **.** heartbeat every ~20 minutes or when drift is suspected.
- Upon heartbeat, the assistant must:
  1. Post **OE Status** (mode, constraints, verbosity).
  2. Re-affirm **BPOE guardrails** (no block leaks, concise default).
  3. Continue, minimizing context churn.
<!-- BPOE:OEHeartbeat END -->


<!-- BPOE:CoSnap START -->
### CoSnap (screenshots, opt-in)
- CoSnap captures **active window** to ~/Downloads/CoCivium-Logs (PNG).
- CoSnapScroll -Pages N stitches PageUp frames vertically.
- CoSnap -Paste (or CoSnapScroll -Paste) copies image, focuses chat, pastes, sends.
- **Privacy:** opt-in only, visible console message, local-only storage.
- **Use when:** UI state matters (dialogs, disabled buttons, diffs) or JS paste is blocked.
<!-- BPOE:CoSnap END -->


<!-- BPOE:CI START -->
### CI: common fail causes → quick mitigations
| Fail name (typical) | Why it fails | Fast fix (CLI) |
|---|---|---|
| **lock-readme/guard** | README changed in a non-README PR | git checkout origin/main -- README.md ; git commit -m "ci: drop README change" |
| **Noname-stubs-check** | Required stubs missing or wrong link | Ensure **both** files exist and point to insights/Insight_Story_Being_Noname_c2_20250801.md:<br>stories/being-Noname.md and insights/story-being-Noname.md |
| **codespell** | Domain words flagged (e.g., Noname) | Add to docs/lexicon/codespell-ignore.txt then commit. |
| **markdownlint** | Long lines / inline HTML in insights | Add <!-- markdownlint-disable MD013 MD033 --> once near top of the file. |
| **yamllint** | Tabs, CRLF, or trailing space in workflow | Convert tabs→spaces, normalize LF; avoid trailing ws. |
| **PR labeler** | Labels missing / pattern mismatch | gh pr edit <N> --add-label docs (and others as needed). |
<!-- BPOE:CI END -->


<!-- BPOE:CoWrap START -->
### CoWrap checklist (end-of-session hygiene)
- Land open doc-only PRs (enable --auto when policy requires).
- Verify main page reflects intended titles/redirects.
- Run git grep -n -I -i -- 'Noname' -- 'docs/**/*.md' 'insights/**/*.md' to catch regressions.
- Keep **BPOE** as source of truth; do not rely on assistant memory.
<!-- BPOE:CoWrap END -->

