# CoBus Events (append-only log)
#### CoBusEvent CB_20251128_CoCiviaHeartbeat_20251128T061154Z

- when      : 20251128T061154Z
- session   : CoPrime20251128
- kind      : cocivia_heartbeat_processed
- repo      : CoCivium
- heartbeat : docs\intent\advice\heartbeat\CoCivia\Heartbeat_20251128T055009Z.md
- cosync    : CoSync_CoCiviaHeartbeat_20251128T061154Z.md
- summary   : Scaffolded CoSync note for latest CoCivia heartbeat; human to fill in intent decisions and actions, then commit via normal BPOE.


#### CoBusEvent CB_20251128_CoCiviaHeartbeat_20251128T072417Z

- when      : 20251128T072417Z
- session   : CoPrime20251128
- kind      : cocivia_heartbeat_processed
- repo      : CoCivium
- heartbeat : docs\intent\advice\heartbeat\CoCivia\Heartbeat_20251128T072411Z.md
- cosync    : CoSync_CoCiviaHeartbeat_20251128T072417Z.md
- summary   : Scaffolded CoSync note for latest CoCivia heartbeat; human to fill in intent decisions and actions, then commit via normal BPOE.


## EVT-CoIndex-SeedHelpers-20251128T083646Z – CoIndex seed helpers wave

- timestamp_utc: 20251128T083646Z
- session_label: CoIndex20251128
- kind: index-update
- repos:
  - CoIndex
  - CoSteward
  - CoPlan
  - CoCivium
  - InSeed
- notes:
  - Auto-generated helper entries from CoIndex/docs/intent/CoIndex_SeedAssets_v1.md
    into the latest CoIndex_SeedHelpers_*.md file.
  - See CoIndex/docs/helpers/CoIndex_SeedHelpers_*.md for details.
  - See CoSteward/docs/intent/CoStatus_Pulses_v1.md for the related CoIndex pulse.
## EVT-CoIndex-AcademiaShockPilot-20251128T151500Z – CoIndex academia-shock pilot export

- timestamp_utc: 20251128T151500Z
- session_label: CoIndex20251128
- kind: index-export
- lane_id: academia-shock
- repos:
  - CoIndex
  - CoSteward
  - CoCivium
  - InSeed
- artifacts:
  - CoIndex/exports/work/CoIndex_academia-shock_Harvest_v1.json
  - CoIndex/exports/work/CoIndex_academia-shock_Annotated_v1.json
  - CoIndex/exports/pointees/CoIndex_AcademiaShock_Pilot_v1.json
- notes:
  - First CoIndex HARVEST H/A/E pipeline run for academia-shock lane.
  - Export shape is "CoIndex_ExportSchema_v2-pilot" pointees for System.Func`2[System.Text.RegularExpressions.Match,System.String] consumption.
## Session scopes snapshot (2025-12-02T10:38:02Z)

- Session: AcademiaShock_Zenodo
  - Repo: CoCivium
  - Focus: Academia Shock preprint, DOIs, Zenodo integration, artifacts and workflows.
  - Feeds: Academia Shock PDF, CoTheory of Civilization citations, CoBus history.

- Session: CoPolitic20251201
  - Repo: CoPolitic
  - Focus: Public facing civic and political narrative for edge balanced hybrid society.
  - Feeds: Messaging and visuals for policymakers, civic leaders and the public.
  - Draws from: CoTheory of Civilization, Academia Shock, CoGuard, CoIndex.

- Session: InSeed_more
  - Repo: InSeed
  - Focus: Strategy and commercial framing of the same futures for execs and innovators.
  - Feeds: InSeed.com copy, client decks and workshops.
  - Draws from: CoTheory of Civilization, Academia Shock, CoPolitic narratives.

- Session: CoPrime20251128 (Co1)
  - Repo: CoSteward / CoPrime constellation
  - Focus: Orchestrator for cross-repo intent, CoBus, GIBindex and MegaWaves.
  - Feeds: Handoffs, session summaries, index updates and guardrail specs.
  - Draws from: all active sessions as listed above.

## Session plan update (2025-12-02T11:19:03Z) – CoPolitic20251201

- Session: CoPolitic20251201
  - Repo: CoPolitic
  - Current wave:
    1) Upstream theory: CoTheory of Civilization article suite in CoCivium.   [THIS SESSION]
    2) Bridge: align CoPolitic.org and InSeed.com futures via bridge paper.   [THIS SESSION]
    3) CoPolitic.org site rebuild:
       - New IA / page map.
       - Core messages derived from CoTheory + Academia Shock.
       - Draft hero + CTA copy.
       - Stub key pages in CoPolitic repo (Home, Why Now, For Stewards, For Elites, For Youth).
    4) Sync back to Co1 / CoPrime:
       - Note which artifacts are canonical for narrative reuse.
  - Related sessions:
    - AcademiaShock_Zenodo (CoCivium, preprint + DOI flow).
    - InSeed_more (InSeed.com strategy copy).
    - CoPrime20251128 (Co1 orchestrator).

## Event (2025-12-02T16:57:22Z) – CoPolitic MegaWave v2 site

- Session: CoPolitic20251201
- Repo: CoPolitic
- Change:
  - Applied CoPolitic_MegaWave_v2 (static site v1 + intent + Labs + CoBus note).
  - PR: https://github.com/rickballard/CoPolitic/pull/27
- Notes:
  - CoPolitic.org now has a coherent near-final static v1:
    - Home, Why now, For stewards, For elites, For youth, Labs.
    - Perspective Plan explained in plain language (commons power, stewardship, truth alignment).
    - Labs catalog wired as both HTML and intent docs for future experiments.
## Event (2025-12-02T17:31:33Z) – CoPolitic MegaWave v4 CoIndex-aware labs & plane

- Session: CoPolitic20251201
- Repo: CoPolitic
- PR: (fill once created)  # e.g. https://github.com/rickballard/CoPolitic/pull/29
- Change:
  - Updated docs/site-v1/why-now.html with a practical "How to use the perspective plane" section.
  - Wired why-now and labs pages to canonical CoIndex / CoGbx views for AI-facing tools.
  - Rewrote docs/site-v1/labs.html around three named labs (Perspective Plane Lab, Guardrail Jam, Civic Twin Sprint).
  - Added docs/intent/site/CoPolitic_CoIndexPointers_v1.md as a stable pointer doc for Co1 and CoAgent sessions.
  - Added CoBus_Note_CoPolitic_MegaWave_v4.md under docs/intent/bus.

- Canonical CoIndex / CoGbx links:
  - Seed view: https://github.com/rickballard/CoIndex/blob/main/exports/views/CoGbx_SeedViews_v1.md
  - Seed contract: https://github.com/rickballard/CoIndex/blob/main/docs/CoGbx/CoGibber_CoGbx_SeedContract_v1.md
## Event (2025-12-02T18:37:10Z) – CoPolitic MegaWave v5 roles landing

- Session: CoPolitic20251201
- Repo: CoPolitic
- PR: https://github.com/rickballard/CoPolitic/pull/29
- Change:
  - Added docs/site-v1/roles.html as the new canonical roles landing page.
  - Clarified how stewards, elites, and youth are expected to use the site and Labs.
  - Documented the change in CoBus_Note_CoPolitic_MegaWave_v5_Roles.md under CoPolitic docs/intent/bus.

- Notes:
  - Hosting can route /roles or /roles/ to docs/site-v1/roles.html to replace the deprecated TOS-AI stub mentioned in CoPolitic20251201.
## Event (2025-12-02T18:37:31Z) – CoPolitic MegaWave v5 roles landing

- Session: CoPolitic20251201
- Repo: CoPolitic
- PR: https://github.com/rickballard/CoPolitic/pull/30
- Change:
  - Added docs/site-v1/roles.html as the new canonical roles landing page.
  - Clarified how stewards, elites, and youth are expected to use the site and Labs.
  - Documented the change in CoBus_Note_CoPolitic_MegaWave_v5_Roles.md under CoPolitic docs/intent/bus.

- Notes:
  - Hosting can route /roles or /roles/ to docs/site-v1/roles.html to replace the deprecated TOS-AI stub mentioned in CoPolitic20251201.
## Event (2025-12-02T18:44:05Z) – CoPolitic MegaWave v5 roles landing

- Session: CoPolitic20251201
- Repo: CoPolitic
- PR: https://github.com/rickballard/CoPolitic/pull/30
- Change:
  - Added docs/site-v1/roles.html as the new canonical roles landing page.
  - Clarified how stewards, elites, and youth are expected to use the site and Labs.
  - Documented the change in CoBus_Note_CoPolitic_MegaWave_v5_Roles.md under CoPolitic docs/intent/bus.

- Notes:
  - Hosting can route /roles or /roles/ to docs/site-v1/roles.html to replace the deprecated TOS-AI stub mentioned in CoPolitic20251201.
## Event (2025-12-02T19:59:32Z) – CoPolitic MegaWave v6 roles polish

- Session: CoPolitic20251201
- Repo: CoPolitic
- PR: https://github.com/rickballard/CoPolitic/pull/31
- Change:
  - Updated docs/site-v1/roles.html as a clearer, near-final roles landing page.
  - Clarified how stewards, elites and youth are expected to move through the site and into Labs.
  - Documented the change in CoBus_Note_CoPolitic_MegaWave_v6_RolesPolish.md under CoPolitic docs/intent/bus.

- Notes:
  - Hosting can continue to route /roles or /roles/ to docs/site-v1/roles.html
    as the canonical roles entry point for CoPolitic.
## Event (2025-12-02T20:46:07Z) – CoPolitic MegaWave v7 plane and story polish

- Session: CoPolitic20251201
- Repo: CoPolitic
- PR: https://github.com/rickballard/CoPolitic/pull/32
- Change:
  - Refined the public CoPolitic site to a "finished enough" state for early external use.
  - Clarified the perspective plane and drift patterns.
  - Tightened the roles, Labs and track pages for stewards, elites and youth.
  - Updated intent docs (site plan, copy blocks, Labs catalog, CoIndex pointers).
  - Logged this wave in CoBus_Note_CoPolitic_MegaWave_v7_PlaneAndStory.md under CoPolitic docs/intent/bus.

- Notes:
  - Hosting can continue routing /roles or /roles/ to docs/site-v1/roles.html.
  - Future waves can add visual assets without breaking these flows.
