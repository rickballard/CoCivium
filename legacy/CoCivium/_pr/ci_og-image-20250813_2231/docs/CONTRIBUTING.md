# Contributing (Quick Start)

- **All changes land via Pull Request to `main`.** No direct pushes.
- **Squash merges only.** One clean commit per PR (repo is configured for squash).
- **Maintainer review required.** Authors can’t approve their own PR. CODEOWNERS enforces a maintainer review.
- **First-time contributor workflows require approval.** On public repos, Actions won’t run until a maintainer approves the run.
- **IssueOps:** Comment `/run` with a single fenced `bash` block to execute reviewed tasks on our self-hosted Windows runner. Prefer calling checked-in scripts under `scripts/tasks/` over long inline bash.

## Typical flow
1. `git switch -c feat/your-thing` from `main`
2. Commit in small, focused chunks
3. Open a PR; fill the template and link related docs
4. Wait for review/CI; address feedback
5. Maintainer **squash-merges** and deletes the branch
