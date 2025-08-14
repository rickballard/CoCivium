---
title: "Domain Brief: Finance & Budgeting"
canonical_slug: domain-finance-budgeting
source:
  repo: CoCivium
  original_path: ./domains/finance.md
  imported_on: 2025-08-14
  version: c1
  date: 20250814
supersedes: []
---

# Finance & Budgeting — Consentful Patterns

**Goal:** fund work with dignity and transparency while avoiding power capture.

## Context
Money flows shape incentives and trust. We keep ledgers open, roles separated, and decisions reviewable.

## Practices worth copying
- **Open ledgers** with monthly notes (cash in/out, cash on hand).
- **Ring-fenced grants** tied to obligations & review dates.
- **Separation of concerns:** proposer vs implementer vs approver vs auditor.
- **Budget caps** and default sunsets; renew on evidence.
- **Public caps on steward discretion**; larger spends require stronger signals.
- **Portable records** (plain files, hashable when needed).

## Minimum Viable Flow
1) Proposal: context → options → risks → obligations → review date
2) Consent check → if stalled, escalate to risk-scaled vote
3) Record outcome + ledger entry + steward owner
4) Review on date; renew/retire; publish note
## Diagram
```mermaid
flowchart TD
  P[Proposal] --> C{Consent?}
  C -- yes --> L[Ledger entry + Obligations + Review date]
  C -- no --> V[Vote (proportional to risk)]
  V --> L
  L --> R[Review → renew/retire → publish note]
```
## Experiments we'll run
- Publish a monthly transparency note format (inflow/outflow/cash on hand).
- Pilot a small grant with "cap + sunset" and review on evidence.

## How we'll measure
- # of decisions with review dates
- % of expenses linked to decisions
- On-time review rate per month

