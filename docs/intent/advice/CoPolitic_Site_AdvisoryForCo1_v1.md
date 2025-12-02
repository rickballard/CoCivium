# CoPolitic site – plane & story polish (Advisory for Co1)

Session: CoPolitic20251201  
Wave: CoPolitic_MegaWave_v7_PlaneAndStory_ApplyAndPR  
PR: https://github.com/rickballard/CoPolitic/pull/32

## 1. What changed in this wave

CoPolitic is now in a “finished enough” state for early external eyes:

- **Home page (`index.html`)**
  - Simple explanation of what CoPolitic is: a lab for re‑wiring power and incentives with AI + humans.
  - Clear CTAs into “Why now”, “Roles”, and “Labs”.
  - Short, non‑technical story about why the project exists and who it is for.

- **Why now (`why-now.html`)**
  - Narrative about why our institutions are drifting out of alignment with most citizens.
  - Explains that CoPolitic is a **Civic Lab**, not a new party or ideology.
  - Introduces the idea of *civic twins* and experimenting in small, low‑risk sandboxes before things hit real institutions.
  - Connects directly to CoIndex / CoGbx as the “AI‑side contract” for how experiments are tagged and tracked.

- **Roles (`roles.html`)**
  - Clean entry page for three audience tracks:
    - **Stewards** (people who want to shepherd healthy, long‑lived institutions).
    - **Elites** (people with existing power / capital / platforms who can sponsor experiments).
    - **Youth** (early‑career / students looking for meaningful projects instead of pure careerism).
  - Each role links to its own “for‑X” explainer page and onward to Labs.

- **Role explainer pages**
  - `for-stewards.html`
  - `for-elites.html`
  - `for-youth.html`
  - Each gives:
    - A short story about “people like you”.
    - What CoPolitic needs from them.
    - What they get back (learning, influence, proof‑of‑care, reputational halo).
    - A gentle CTA into Labs and contact routes (via InSeed etc.).

- **Labs (`labs.html`)**
  - Presents a small **labs catalog** (v1) with human‑readable names:
    - Perspective Plane Lab.
    - Guardrail Jam.
    - Civic Twin Sprint.
  - Each has:
    - Who it is for (roles).
    - What the lab actually does in a 60–90 minute session.
    - What comes out the other side (artifacts, metrics, commitments, next steps).
  - Hints that “under the hood”, these map into CoIndex / CoGbx seeds so AIs can help compare, remix and extend lab outputs over time.

## 2. Perspective Plane – current framing

The “plane thingy” is now treated as a **simple visual metaphor**, not a dense academic construct:

- It is described as a **map of drift** between:
  - What institutions say they value.
  - What they actually optimize for.
  - What citizens actually need.
- The copy emphasizes that the picture is:
  - A conversation starter in workshops.
  - A way to spot where power, incentives and risk are misaligned.
  - A way to compare “where we are now” vs “where we want to be” across different institutions.
- In live rooms, facilitators are invited to:
  - Place sticky notes / examples along the plane.
  - Ask “who wins, who loses, who is invisible here?”
  - Use AI tools (CoAgent + CoIndex views) to surface similar patterns elsewhere.

The actual SVG/diagram can be swapped in later without breaking the flows, as long as the copy keeps this framing.

## 3. Educational story beats (for humans)

The site now carries a coherent narrative arc:

1. **Home** – “Institutions are drifting. You can help re‑steer them.”  
2. **Why now** – concrete, non‑sci‑fi explanation of:
   - Why AI makes the stakes higher and the pace faster.
   - Why we need *labs* and *guardrails* before policy catches up.
3. **Roles** – “Here is how someone like you plugs in.”  
4. **Labs** – “Here is what we will actually do together, in real sessions.”  

Throughout, copy avoids partisan language and instead leans on:

- Stewardship.
- Long‑term health of institutions.
- Measurable evidence of care and responsibility.
- A standing invitation to *co‑design* the future rather than merely critique it.

## 4. AI‑facing anchors (CoIndex / CoGbx)

The site and intent docs now point clearly into CoIndex:

- **Seed view (general pointer for AIs / sessions):**  
  https://github.com/rickballard/CoIndex/blob/main/exports/views/CoGbx_SeedViews_v1.md

- **Seed contract (what CoGibber / CoGbx means to AIs):**  
  https://github.com/rickballard/CoIndex/blob/main/docs/CoGbx/CoGibber_CoGbx_SeedContract_v1.md

Within CoPolitic:

- `docs/intent/site/CoPolitic_CoIndexPointers_v2.md` is now the canonical pointer doc for AI‑facing sessions (Co1, CoAgent, etc.).
- `docs/intent/site/CoPolitic_SitePlan_v4.md` and `CoPolitic_CopyBlocks_v4.md` describe:
  - Which pages exist.
  - The main story beats per page.
  - How to evolve copy in future waves without breaking navigation.
- `docs/intent/site/CoPolitic_LabsCatalog_v3.md` holds the current Labs definitions and is the place to append new labs or variants.

## 5. Hosting / routing notes

For whoever is wiring hosting (now or later):

- Map **`/`** for copolitic.org to `docs/site-v1/index.html`.
- Map **`/why-now`** to `docs/site-v1/why-now.html`.
- Map **`/roles`** (and `/roles/`) to `docs/site-v1/roles.html`.
- Map **`/labs`** to `docs/site-v1/labs.html`.
- Optional:
  - `/for-stewards` → `docs/site-v1/for-stewards.html`
  - `/for-elites`   → `docs/site-v1/for-elites.html`
  - `/for-youth`    → `docs/site-v1/for-youth.html`

The old TOS‑AI stub at `/roles/` can now be fully retired in favour of the new roles landing page.

## 6. How Co1 and future sessions can evolve this

Suggested next‑wave improvements (without disturbing today’s “finished enough” state):

- **Visuals**
  - Swap in a cleaner, branded illustration of the perspective plane.
  - Add one or two hero images per page to keep long text from feeling heavy.
- **Flows & fit‑tests**
  - Add simple “Which role fits me?” helper (short quiz or checklist) that pushes visitors into the right track page.
  - Wire form or calendaring links (via InSeed) for lab sign‑ups.
- **Evidence & metrics**
  - Add a small “What have we shipped so far?” section on home or Labs:
    - number of labs run.
    - number of institutions / teams touched.
    - small case snippets (even anonymized) once available.
- **Deeper CoIndex use**
  - For each Lab and role track, attach explicit CoGbx seeds so AIs can:
    - pull similar experiments from other domains.
    - surface patterns of success / failure.
    - suggest new lab formats.

When making those future edits, treat the current **intent docs** as the source of truth for structure and naming, and log new waves via CoBus as usual.

## 7. How to think of CoPolitic in the wider CoSuite

For Co1’s orchestration view:

- CoPolitic is the **civic and power‑structure lens** of CoCivium.
- It:
  - hosts public‑facing invitations for stewards / elites / youth;
  - runs Labs that can be mirrored into other repos (CoAudit, CoCheck, CoCore, etc.);
  - acts as a “shop window” for people who might never read the deeper white papers but can feel that something healthier is possible.

The **plane + labs** combo is now a usable starter kit for conversations with:

- city leaders,
- funders,
- institutional stewards,
- and youth groups who want to experiment with governance in a safe, guided way.

---

_This .md is intended as a manual drop into Co1 so future sessions can see what this wave shipped and where to evolve next. It does not assume any of the narrative is yet reflected in external comms beyond the CoPolitic repo itself._
