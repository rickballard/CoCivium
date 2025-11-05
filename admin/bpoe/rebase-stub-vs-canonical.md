<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# BPOE: Rebase pattern for stub vs canonical

When rebasing branches that introduced **stubs**, prefer:
- **\git checkout --ours <path>\** for files already canonical on \main\.
- Keep feature content only for **net-new** files (e.g., new CC articles, new IdeaCards).

Context: PR #365 rebased onto \main\ while preserving canonical Articles 3–5.








