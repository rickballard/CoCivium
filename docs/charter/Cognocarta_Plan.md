# Cognocarta Consenti — Plan & Decisions (as of today)

## Decisions
- **Hefty single scroll** as the canonical constitution; **Annexes** hold procedures/playbooks.
- Separate **Maxims (Quotables)** from **Articles (Directives)** to keep quotes stable.
- Adopt **civitude** as the rallying ethic (see /docs/brand/TERMS.md).
- **Symbol hooks (GIBindex)** embedded inline (online = SVG; print = text fallback).
- **Visual skin** keeps a constitution vibe; headings right-aligned; timeless motifs (no faces/chips).
- Preserve ALL legacy scrolls under `scroll/legacy/` before edits/merges.

## Canonical structure (outline)
1. **Preamble** (quotable)
2. **Maxims** (short, quotable aphorisms; slow-to-change)
3. **Articles I–VIII** (rights, governance, interop, accountability, commons, agents, amendment…)
4. **Annexes** (Concordia, Operandi, Custodia, Commons, …) — living companions.

## Visual system
- Symbol slugs: `consent`, `interop`, `pluralism`, `commons`, `evidence`, `rollback`, `agent`, `forkrejoin`.
- SVGs live at `site/assets/gib/<slug>.svg`. 24x24 viewBox, stroke-only, no fills; inherits `currentColor`.
- Print fallback shows the slug text if SVGs aren’t available.

## Assets & social
- Current social preview = scroll artwork. Replace the “chip-tile” variant later with a **fungal-neural scroll** concept.
- Stick to crop-to-fill (no letterboxing); see ImageMagick one-liners already in repo history.

## Process & safety
- **Migrate legacy CoCivium texts** into `scroll/legacy/`.
- Draft **Maxims** separately; require higher threshold to change than ordinary Articles.
- Keep tracked diffs (PRs) for any constitutional edits.

## Next actions
- [ ] Drop legacy scrolls into `scroll/legacy/` (no deletion yet).
- [ ] Define first pass of symbol set (see /docs/symbols/GIBINDEX_TODO.md) and wire into headings.
- [ ] Draft “Maxims” section from legacy quotables.
- [ ] Replace chip-tile social image with fungal-scroll variant.
