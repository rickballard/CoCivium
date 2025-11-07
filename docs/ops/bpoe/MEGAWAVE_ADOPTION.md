# BPOE — MegaWave Adoption & Retention (Live)

**Intent:** Make “MegaWave (repo-first, megazips + small CoBlocks)” the _default behavior_ across CoSuite sessions and CI, and capture blockers that cause drift back to chat-only workflows.

## Why agents drift off MegaWave after CoSync
- **Context churn / session restarts:** New/rotated sessions lack persisted state; default prompts don’t restate MegaWave unless enforced by repo checks.
- **Tool boundary gaps:** Some models can’t attach files or run background build steps; they regress to inline code dumps unless a prepared megazip pattern exists.
- **Safety/authority uncertainty:** Without explicit GH permissions (e.g., `pull-requests: write`) agents avoid PR-commenting or repo mutations.
- **Here-string & templating hazards:** `${{ }}` and backticks in chat snippets get mangled; agents fall back to shorter, less reliable instructions.
- **CoBloat pressure:** Token/length caps bias toward “just say it” instead of shipping artifacts.
- **Output-channel mismatch:** CI/PRs expect files; chat pastes don’t pass checks or get indexed by Co1.
- **Ambiguity in “required vs advisory” checks:** If Quality/MegaWave checks are advisory-only, agents ship without them to hit time boxes.

## Adoption pattern (BPOE)
1. **Ship artifacts, not pastes:** Prefer megazip + small CoBlock that runs local PS7 to apply changes.
2. **Composite actions over inline blocks:** Encapsulate PR behaviors (e.g., tension table) in `.github/actions/*`.
3. **Permissions upfront:** Ensure top-level workflow `permissions:` allow `pull-requests: write` when commenting.
4. **CoSync notes are mandatory:** Every change ships with `docs/intent/advice/notes/YYYYMMDD/CoSync_*.md` containing pointers, heartbeat, rollback.
5. **BPOE logs updated with every move:** Append to `WORKFLOW_LESSONS.md` and `CONTRIBUTION_FRICTIONS.md`.
6. **Snapshot for Co1 mining:** Capture `actions/permissions`, branch protection, and key workflow runs in JSON under `_snapshots/YYYYMMDD/`.

## Guardrails
- No `pull_request_target`. No write-on-PR beyond comments. Artifact-only on PRs.
- Same-repo PRs only for comment steps. Fork PRs: skip comment with soft note.
- All changes additive + reversible; rollback path in CoSync.

## Signals for Co1
- Presence of `MEGAWAVE_ADOPTION.md`.
- Latest CoSync includes “MegaWave retained: YES/NO” and reason if NO.
- Quality badge + megawave-guard job outcome.

