# Forward Plan  -  Phases, Owners, and Cutover

## Phase 1  -  Definition of Done (target: complete)
- [x] BP v0.4 canonical on main; tag `v0.4` set.
- [x] Housekeeping: `.gitattributes` (LF), `.editorconfig`, README quick‑links.
- [x] Protected‑docs *scaffolding* PR merged (docs‑only).
- [x] Rollback notes captured.
- [x] Owners listed.

**Owners**
- Migration Lead: @rickballard
- Reviewers: @rickballard (plus whoever you tag on PRs)

---

## Phase 2  -  Cutover (active)
**Checklist (fill in file moves as discovered):**
- [ ] List concrete file moves/renames in `MIGRATION/CUTOVER.md`.
- [ ] Update any CI/scripts (confirm none are impacted).
- [ ] Run smoke tests (line endings, links, sentinel messages).
- [ ] Prepare rollback steps (mirror of moves).
- [ ] Create release tag after merge (e.g., `v0.4.x`).

---

## Phase 3  -  Hardening & GA polish (near‑term)
- [ ] **Protected Docs (GA)**  -  age + Bitwarden flow hardened; step‑by‑step with winget/scoop/choco; example E2E; optional CI guard for plaintext leaks.
- [ ] **CoPong v0.4.4**  -  verify module imports cleanly on PS5/PS7; add Pester tests; lock‑free transcript confirmed.
- [ ] **History hygiene**  -  create [docs/history/INDEX.md](docs/history/INDEX.md) and [docs/history/<YEAR>.md](docs/history/<YEAR>.md); add `.github/ISSUE_TEMPLATE/history_year.yml` with December reminder.
- [ ] **Sentinel messages**  -  keep warnings by default; add “fix in <60s” one‑liners; require links (Idea Issue, Edit‑this‑file, etc.).
- [ ] **CoWrap**  -  keep short checklist up top; “idea pack” behind link; publish template.
- [ ] **Telemetry (opt‑in)**  -  coarse event schema; local buffer; tag‑gated `releases.json`; “not surveillance” footnote.

---

## Phase 4  -  Platform work (mid‑term)
- [ ] GitHub App + VS Code extension (policy sync, dashboards).
- [ ] Decide CoAgent packaging track (GPT extension / middleware / OSS+SaaS).

---

## Status signals (are we co‑evolving?)
**Leading:** small PRs; review latency ≤1 biz day; newcomer‑to‑green ≤15 min.
**Trailing:** low change‑failure; fewer “what broke?” pings; ≥80% sentinel warnings resolved ≤7 days.



