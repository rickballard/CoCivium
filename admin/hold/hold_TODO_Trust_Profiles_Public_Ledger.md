<!-- Filename: TODO_Trust_Profiles_Public_Ledger.md -->
<!-- Location: /admin/ -->
<!-- Created: 2025-07-25 01:12 UTC -->

# TODO: Trust Profiles on Public Ledger (Opename)

## Summary
Design and propose a system for storing anonymous user trust profiles on a public ledger—ideally blockchain-based—to support accountability and tamper-resistance without violating privacy.

This service could be hosted or prototyped at **Opename.com**, allowing identity-linked trust signals to be anchored cryptographically, yet accessed in pseudonymous or anonymous ways.

## Purpose
To provide decentralized reputation infrastructure for systems like Civium, GroupBuild, or third-party platforms needing:
- Persistent pseudonymous credibility
- Community auditability
- Anti-Sybil mechanisms without centralized control

## Tasks
- Determine minimum schema for a trust profile (e.g., vote weight, verification count, alignment deltas)
- Explore blockchain storage options (e.g., IPFS + chain hash, L2 rollups, public append logs)
- Define API/service boundary for reading/writing trust state
- Draft possible UX flow for Opename-integrated issuance & verification
- Assess abuse potential, rate-limiting, and sybil-resistance

## Status
🟡 Parked — Phase 2 priority (Opename backend service strategy)

## Notes
This may intersect with Civium identity, RepMod/MeritRank delegation, or AI moderation visibility. Likely needs technical concept paper + legal/data ethics review.


