# Open Collective — CoCivium Setup Guide

This guide walks through creating and operating the **CoCivium** collective.

## 1) Choose a Fiscal Host
A Fiscal Host holds funds, issues payouts, and handles compliance.
Common options:
- **Open Collective Foundation (US 501c3)** — charitable scope; donations may be tax-deductible in the US.
- **Open Source Collective (global OSS)** — for open-source projects.
- **Local/Regional hosts** — if you want jurisdiction-specific coverage.

**Pick one that matches your scope** (civic/public-interest), fees, and geography.

## 2) Create the Collective
- Go to https://opencollective.com/ and click **Create a collective**.
- Name: **CoCivium**
- Slug: **cocivium** (recommended)
- Description: Consentful, polycentric governance playbook & tooling.
- Upload logo/banner (optional for now).
- Connect to GitHub repo for nice badges later.

## 3) Configure Policies
- **No-strings-attached gifts** (link in README to docs/FUNDING.md).
- Transparency note (we publish bands/notes by default).
- Expense categories: writing, research, engineering, design, operations.
- Approval rules: ≥1 steward (maintainer) must approve each expense.

## 4) Payouts
- Enable reimbursements (contributors), invoices (freelancers), and grants (if supported by host).
- Add your legal name + payout method in your own contributor profile.

## 5) Products → Collective (optional pattern)
- Run product checkouts via Stripe/PayPal (outside OC).
- Transfer a share of net proceeds to **cocivium** as a donation (visible on the ledger).
- Alternatively, contributors invoice the Collective for eligible work.

## 6) Fees & Taxes (overview)
- Hosts take a platform/host fee (varies).
- OC platform fee may apply.
- Check your jurisdiction’s tax obligations.
- For deductible receipts, prefer a 501(c)(3) host (like OCF).

## 7) Go Live
- Publish the page.
- Share the **/cocivium** URL with the community.
- Update repo: `.github/FUNDING.yml` to `open_collective: cocivium`, README badge, etc.

## 8) Ongoing Ops
- Monthly transparency note in `notes/finances/` (incoming, outgoing, cash on hand).
- Tag expenses to issues/PRs for provenance.

