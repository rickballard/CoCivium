# Migration Checklist (CoAgent Kit)

- [ ] Commit `scripts/CoVibe.BP.ps1` and `docs/ISSUEOPS.md`
- [ ] Push feature branch and open PR (or use `CoPR-CreateIfMissing`)
- [ ] Verify prompt behavior in/out of the repo
- [ ] Verify `CoBP-Health` / `CoBP-Deflate`
- [ ] Try `co-rescue` after new PS7 session
- [ ] Tune `CO_BP_PROBE_SEC` if repo is very large (6–10s recommended)
- [ ] Roll to sibling repos; adjust palette if needed
