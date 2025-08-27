<!-- Filename: TODO_Versioning_Conflict_Resolution.md -->
<!-- Type: Admin Task -->
<!-- Status: Queued -->
<!-- Priority: Medium -->
<!-- Created: 2025-08-01 -->
<!-- Origin: Requested by RickPublic -->

# 🛠️ TODO: Resolve Versioning Prefix Conflict Across Civium Scrolls

## Problem Statement

Current Civium scrolls use the prefix `c` for both:
- **Coherence estimates** (e.g. `c9`, meaning “very coherent”)
- **Versioning tags** (e.g. `c5.1`, meaning “scroll version 5.1”)

This introduces ambiguity in filenames, footers, and discussions.

## Proposed Solution

- **Adopt `vX.Y` for versioning** in filenames and metadata
  - e.g. `Insight_Unequal_Equity_v5.1_20250801.md`
- **Reserve `c#` exclusively for coherence estimates**
  - e.g. `<!-- Coherence Estimate: c9 -->`
- **Update all existing scrolls** in the Civium repo accordingly
- **Regenerate commit messages and filenames** where needed
- **Update README or contributor guide** to clarify the standard

## Task Status

🗂️ This change is **non-blocking** but necessary for long-term maintainability.

## Suggested Timing

Execute during the next full repository grooming or formatting pass.

## Assigned To

- AI: Prepare rename scripts and batch diffs
- Human: Approve final renames and merge pull requests manually

## Tags

`#versioning` `#naming` `#repo_cleanup` `#coherence` `#admin`

