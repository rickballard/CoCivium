# CoSync: CoCivia CoPortal v0 live + asks for TOON / MCP / CoPortal plan

Session : CoCivia20251118
Date    : 2025-11-25

## What is now live

- cocivia.org is serving CoCivia CoPortal v0 via Cloudflare Worker plus static assets.
- Worker headers:
  - X-CoPortal-Seed   : CoCiviaCoPortal v0
  - X-CoPortal-Role   : edge_audit_persona
  - X-CoPortal-Status : booting_stub_do_not_cache_long_term_yet
- public/index.html contains:
  - GIBBER style seed block with role, status and triangle references.
  - Small human explainer panel.
- Repo: rickballard/CoCiviaCoPortal with three branches and PRs created:
  - Worker plus assets.
  - Docs plus spec v0.
  - Deploy config plus cocivia.org route.
- All of this is now repo driven and redeployable by script.

## How this CoPortal should be treated

- CoCivia.org is the execution and testbed node for civic audit and misuse patterns.
- CoCivium.org is the state and planning hub that will expose CognoCarta Consenti.
- CoCivia CoPortal should be a reference pattern for:
  - AI first layout and metadata.
  - Clear worker headers for role and status.
  - Strong links back to CoCivia, CoCore, CoAudit and CoSteward.

## Asks for CoPrime20251118 (Co1)

1. Lock a v0 primitive set in CoIndex / GIBindex:
   - Portal, Concept, Intent, Pattern, Case, Steward.
2. Decide how TOON and MCP attach to CoPortals:
   - Minimal mandatory fields for standards, consent and audit.
   - Versioning and drift recording.
3. Ensure CognoCarta Consenti and plan to plan work explicitly recognise:
   - AI first CoPortals as the default interface for AIs.
   - Repo first, programmatically verifiable operations and deployments.
   - Human laziness as a design constraint; AIs are expected to do most of the work.

## Asks for CoPortal+Git session

1. Treat CoCivia CoPortal as working reference for the CoPortal pattern.
2. Extract a small CoPortal kit so other repos can spin up portals quickly.
3. Define how CoPortals surface git state to AIs.
4. Agree a minimal REST style API layer for JSON style queries.

## Guarantees this session is relying on

- Protocol and standards evolution will not silently break CoCivia CoPortal v0.
- New requirements will arrive as PRs against CoCiviaCoPortal and related repos.
