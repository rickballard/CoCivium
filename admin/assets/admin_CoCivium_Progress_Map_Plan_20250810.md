# CoCivium Progress Map (Spider Web) — Plan

**Path:** `CoCivium/admin/assets/admin_CoCivium_Progress_Map_Plan_20250810.md`  
**Created:** 2025-08-10  
**Coherence Estimate:** c6  
**Maintainers:** RickPublic & ChatGPT

> **Asset handling note.** When assembling documents that include images, all graphic files must be stored in the current session directory.  If the session ends or files are not reuploaded, previously used images may be missing from the final output.  Please re-upload any essential images when returning to a project.

---

## 1) Purpose

Design an extensible **spider-web (radar) diagram** for **CoCivium.org** that visualizes repository progress across core metrics, maps major milestones to **concentric rings** (stages), and places **concept nodes** on the web.  The diagram must look organic (fungal network / starfield / neural-net motifs), be legible at a glance, and be architected for later **interactivity** and eventual **3D**.

---

## 2) Concept & Layout

### 2.1 Visual metaphor

- **Web lattice**: primary polar grid (radar) rendered as a stylized mycelial/stellar lattice.  

- **Rings**: concentric circles = **evolution stages** (Section 5).  Rings extend beyond Stage 9 with dashed lines to imply **“progress to infinity.”**  

- **Polygon fill**: the area spanned by metric values = current progress “envelope.”  

- **Starpoints (“flies”)**: small luminous nodes marking **key concepts/files** (e.g., MeritRank demo, Opename stub).  **Shooting-star trails** denote recent velocity on those items.  

- **Fungal filaments**: faint bezier threads connecting related starpoints (concept graph preview).

### 2.2 Compass & radials (8 axes)

Orient the chart like a compass for intuitive reading:

- **E (90°)** — **Coherence/Resonance Index (CI)**  ⇢ proxy for “Godstuff congruence.”  

- **NE (45°)** — **Canonical Coverage (Coverage)**.  

- **N (0°)** — **Onramp Fitness Score (OFS)**.  

- **NW (315°)** — **Link & Schema Health (LSH)**.  

- **W (270°)** — **Decision-Trail Integrity (DTI)**.  

- **SW (225°)** — **Throughput (T)** (normalized).  

- **S (180°)** — **Lead Time (LT)** (inverted; lower is better).  

- **SE (135°)** — **External Engagement (EE)**.

> **Where did Redundancy Debt go?** RD renders as **voids** cut out of the polygon (small inward dents along affected radials), plus a numeric badge in the legend.  This keeps the 8-axis symmetry and still penalizes duplication.

---

## 3) Metric mapping (normalization)

All axes map to **[0, 1]** before plotting.  Suggested transforms:

1. **CI (E):** weighted roll-up of `_cX_` tags.  Already 0–1 after dividing X by 10.  

2. **Coverage (NE):** `Coverage = (Must_hit + 0.5*Should_hit)/(Must_total + 0.5*Should_total)`.  Clamp to [0,1].  

3. **OFS (N):** six checks worth ≈0.167 each: README clarity, Start-Here path, Quickstart works, CONTRIBUTING, issue templates, evomap/legend presence.  

4. **LSH (NW):** percent of link/lint/schema checks passing.  

5. **DTI (W):** sample 20 recent changes; presence/quality of rationale/lineage → average score.  

6. **Throughput (SW):** logistic vs target.  `T_norm = 1/(1+exp(-(T_per_month - 20)/5))`.  

7. **Lead time (S):** invert with saturation.  `LT_norm = 1 - tanh((LT_days - 7)/10)`, clamp [0,1].  

8. **EE (SE):** composite of non-owner issues/mo, PRs/mo, first-timer return rate, visitors/clones.  Normalize each to [0,1], average with weights (issues 0.3, PRs 0.3, returns 0.3, traffic 0.1).

**RD (void):** `RD = conflicts_or_dupes / canonical_topics`.  Render visually as **indent depth = min(0.15, RD)`** applied near radials where duplication is detected.

---

## 4) Data pipeline (nightly)

- **Source:** GitHub API + repo scans.  

- **Job:** GitHub Action `admin/metrics/build_metrics.yml` outputs `admin/metrics/metrics.json`.  

- **Schema (example):**

```json
{
  "timestamp": "2025-08-10T12:00:00Z",
  "ci": 0.62,
  "coverage": 0.81,
  "ofs": 0.55,
  "lsh": 0.97,
  "dti": 0.61,
  "throughput_per_month": 14,
  "t_norm": 0.59,
  "lead_time_days": 9,
  "lt_norm": 0.86,
  "ee": 0.32,
  "rd": 0.18,
  "starpoints": [
    { "id":"MeritRank_Demo", "theta_deg":270, "r":0.52, "stage":5, "velocity":0.08 },
    { "id":"Opename_Stub",   "theta_deg":135, "r":0.34, "stage":4, "velocity":0.03 }
  ],
  "links":[ ["MeritRank_Demo","Opename_Stub"] ]
}
```

---

## 5) Rings = evolution stages (exit gates condensed)

**Stage 1** Scaffold & Standards · **Stage 2** Migration (CoCache-Enabled Regrooming) · **Stage 3** Normalization & Coherence · **Stage 4** Public Alpha · **Stage 5** Onboarding & Review Discipline · **Stage 6** Governance Hardening · **Stage 7** Tooling & Site Layer · **Stage 8** Ecosystem & Labs · **Stage 9**. Steady State & Scale · **∞** dashed extensions.  
Place **ring labels** subtly on the north arc.  Show the **current stage** as a brighter ring.

---

## 6) Rendering plan (phased)

### Phase A — Static SVG (MVP)

- **Generator:** small Python script (`admin/metrics/render_progress_map.py`) that reads `metrics.json` and emits `site/assets/progress_map_v0.svg`.  

- **Design:**  

  - Grid: 8 radials, 10 minor rings per stage with subtle falloff.  

  - Polygon: filled with low-alpha glow; RD voids cut via path subtraction.  

  - Starpoints: small gaussian blur; velocity >0 draws a short motion trail.  

  - Fungal filaments: thin, semi-random bezier curves between linked starpoints.  

- **Color:** monochrome base, automatic accent derived from CI (higher CI → warmer accent).  Accessibility first.  

- **Deliverable:** static asset embedded on CoCivium.org landing page.

### Phase B — Interactive 2D (SVG/D3, React + Tailwind)

- **Controls:** hover tooltips, toggle layers (RD voids, filaments, starpoints), time scrubber across nightly snapshots, export PNG.  

- **Data:** `metrics.json` series in `admin/metrics/history/*.json`.  

- **Tech:** Next.js (or Astro) + D3 for the radar layer.  Keep logic modular.

### Phase C — 3D (Three.js/WebGL)

- **Depth:** rings extruded; starpoints as particles; shooting-star trails animated.  

- **Interaction:** orbit controls, click to open the related file/issue.  

- **Performance:** progressive enhancement (fallback to Phase B on low-end devices).

---

## 7) Placement & copy on landing page

- **Above the fold:** the canvas/SVG with a short caption:
  
  *“This living map shows CoCivium’s real progress across coherence, coverage, onboarding, hygiene, decision integrity, cadence, responsiveness, and community signal.  The brighter the weave, the healthier the organism.”*  

- **Legend:** compact compass legend at bottom-right.  

- **CTA:** “Open issues” and “Contribute” buttons directly under the chart.

---

## 8) File & folder structure

```
admin/
  metrics/
    build_metrics.yml        # GitHub Action (nightly)
    metrics.json             # latest snapshot
    history/                 # rolling snapshots
    render_progress_map.py   # Phase A generator
assets/
  admin_CoCivium_Progress_Map_Plan_20250810.md
site/
  assets/
    progress_map_v0.svg      # output of Phase A
  components/
    ProgressMap.tsx          # Phase B (future)
```

---

## 9) Risks & guardrails

- **Vanity risk:** pretty web that hides poor hygiene.  Keep **LSH/OFS/DTI** honest; do not smooth bad scores.  
- **RD denial:** duplication must visibly dent the polygon.  No design override.  
- **Over-theming:** fungal/stellar motif must never reduce legibility.  Contrast and keyboard nav first.

---

## 10) Action checklist (numbered)

1. Create `admin/metrics/build_metrics.yml` (nightly at 02:00 UTC).  

2. Implement metric collectors (CI, Coverage, OFS, LSH, DTI, T, LT, EE, RD).  

3. Emit `metrics.json` and append to `history/` with datestamp.  

4. Write `render_progress_map.py` to generate `site/assets/progress_map_v0.svg`.  

5. Embed the SVG on the landing page with alt text and legend.  

6. Add two demo **starpoints** (MeritRank_Demo, Opename_Stub) wired to real links.  

7. Ship.  Then start Phase B (interactive) on a separate branch.

---

## 11) Educational notes (optional reading)

- **Why CI ≈ “Godstuff congruence.”** Until we formalize an Ethical Alignment Score, CI (coherence/resonance to the stated vision and recursive ethics) is the least-bad proxy.  The east radial will later multiply CI × EAS.  

- **Why 8 axes.** Human legibility and compass mapping beat maximal completeness.  RD as dents keeps duplication painful without breaking symmetry.

