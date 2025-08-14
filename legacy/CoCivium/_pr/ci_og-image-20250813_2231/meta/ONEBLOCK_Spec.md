# ONEBLOCK Spec
**Definition:** A downloadable `.tar.gz` or `.sh` payload plus a single Git Bash line that installs/updates files and commits/pushes. Idempotent. Windows Git Bash–safe. Includes sidecar commit messages. Defaults are non-destructive.

## Expectations
- Idempotent: safe to re-run.
- Windows Git Bash compatibility.
- Echo actions performed.
- Rollback notes when sensible.
- Commit message includes a clear summary.

## Run Pattern
```
cd "$HOME/Downloads" && tar -xzf <payload>.tar.gz && bash ./<script>.sh "$HOME/Documents/GitHub/<RepoName>"
```
