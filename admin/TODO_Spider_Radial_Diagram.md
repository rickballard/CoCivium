# TODO: Spider Radial Diagram – Civium Dev Snapshot View

## Purpose:
Create and maintain a dynamic spider radial chart to visually represent developmental progress across Civium's core philosophical domains.

## Implementation Plan:
- Define radial arms as top-level philosophy domains (e.g. Ontology, Ethics, Consent, etc.)
- Each radius extends from Civium's c0 origin (center) outward toward theoretical domain-congruence (infinite)
- Plot current progress as subjective approximations of maturity for each domain (0–1.0 float)
- Allow manual adjustments by lead editors/developers to nudge focus areas
- Use as both a *logo variant* and *live dev status tracker*
- Optionally export status snapshot JSON for frontend use

## Notes:
- Subjective but transparent
- Acts as soft coordination tool, not formal metric
- Snapshot is interpretive; used to shape focus, not rank value
- Radials = Top-level philosophy domains (e.g. Ontology, Consent, Ethics, Time, etc.)
- Radii extent = Relative developmental maturity / coherence achieved in each domain, within the repo
- Center point = Conceptual seed (e.g. Civium inception, c0 state)
- Outer bounds = Theoretical maximum congruence (unreachable but directionally real)

## Function of the Diagram
- Snapshot for collaborators to see where work is focused vs where gaps remain
- Dynamic tool for prioritization and narrative framing
- Embedded semiotic signature (logo-style use) for visualizing Civium’s evolving soulprint

## Status:
[ ] Draft radial arm definitions
[ ] Agree on update cadence and source authority
[ ] Generate SVG or JSON-based visual for Civium.cc
[ ] Consider API endpoint for public snapshot pull

## Sample JSON:
```json
{
  "Ontology": 0.62,
  "Consent": 0.87,
  "AI Evolution": 0.45,
  "Epistemology": 0.71,
  "Ethics": 0.80,
  "Time": 0.66,
  "Agency": 0.58,
  "Information Integrity": 0.49,
  "Mortality": 0.31,
  "Communion": 0.53
}
