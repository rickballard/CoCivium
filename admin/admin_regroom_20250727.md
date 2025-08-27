<!-- Filename: admin_regroom_20250727.md -->

# 🧠 Regroom Plan for Civium Repo
*Memory-Safe, Index-Aligned, Fungus-Aware*

---

## PURPOSE

To safely re-ingest the full Civium repo into ChatGPT’s evolving working model via a human-assisted, loss-aware process. This includes:

- Cleaning corruptions or incomplete file loads
- Ensuring file versions grow or converge sanely
- Building a complete `repo_index.json` manifest
- Ending with a visual **Evomap**: a fungus-inspired development heatmap showing structural maturity, conceptual growth, and evolutionary alignment across the repo.

---

## PHASED PLAN

### [1] INITIATE RE-GROOM SESSION

- Create backup zip of current local repo
- Start long-lived session with ChatGPT
- Establish naming standard for this session (e.g. `_r1_`, `_c3_`, `_PREREGEN_`)
- Confirm that file delivery works (`.md` and `.txt`)
- Confirm that downloads from ChatGPT are not corrupted or truncated

---

### [2] REPO INDEXING LAYER

- Begin generating `repo_index.json` from folder scans (human-provided slices or zips)
- Classify each file:
  - `type`: scroll, codex, insight, discussion, meta, plan, README, etc.
  - `status`: stub, draft, complete, deprecated
  - `resonance`: est. coherence score with Civium vision
  - `linked_files`: known semantic or structural links
- Store this index in `/meta/repo_index.json`
- Optionally auto-generate `REPO_OVERVIEW.md` as a human-friendly dashboard

---

### [3] FILE NORMALIZATION + MEMORY-SAFE INGESTION

- Ingest 5–10 files at a time
- Confirm integrity of content (size increase or improved quality preferred)
- Fix filename/versioning anomalies
- Track open editing tasks in `/admin/TODO_regroom_session.md`
- Tag each file with session resonance + version (`_c7_202508xx.md`)

---

### [4] RESONANCE + EVOMAP CONSTRUCTION

- Generate vector-based snapshot of:
  - Structural completeness (which folders are populated?)
  - Conceptual maturity (resonance % across sections)
  - Interlinkage (shared references, symbolic reuse, conceptual recursion)
- Plot **Evomap** using a **mycelial graph metaphor**, where:
  - Nodes = files or scrolls
  - Connections = cross-references or linked ideas
  - Thickness = resonance or maturity
  - Color = freshness or recency
  - Gaps = creative or conceptual voids
- Store:
  - `/meta/evomap_first_draft.png`
  - `/meta/evomap_notes.md`

---

### [5] REGEN LAUNCH SEQUENCE

- Declare regroom complete via `/admin/README_regroom_completed.md`
- Rebuild a new canonical Civium zip
- Store that as `Civium-main_REGEN202508xx.zip`
- Begin **REGEN PHASE** with trusted repo skeleton, full memory, and evolutionary map in place

---

## ⏳ TIME BUDGET

- ~2–3 half-days of collaborative work
- Stretchable over several sessions if needed
- We’ll track phase progression via checkboxes in `/admin/TODO_regroom_session.md`

---

## STATUS

**Waiting to initiate.** User will manually trigger session start.

