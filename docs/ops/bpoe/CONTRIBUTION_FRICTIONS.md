
- **GitHub CLI tip:** \gh api\ **does not** take \-R\. Use endpoints like \epos/\rickballard/CoCivium/... \, or set \GH_REPO\.

- **Branch protection 404:** \gh api repos/\rickballard/CoCivium/branches/main/protection\ can return **404** if branch protection is **not configured**. Treat as snapshot signal, not a hard error.
- **GitHub CLI tip:** \gh api\ **does not** take \-R\; include the repo in the endpoint (e.g., \epos/\rickballard/CoCivium/... \) or set \GH_REPO\.
