# Civium legacy snapshot 20250826

Artifacts:
- Civium-full-20250826.bundle   (complete git history, all refs/tags)
- Civium-full-20250826.refs.txt
- Civium-full-20250826.sha256.txt (SHA256 of bundle)

Restore hint:
git clone --mirror <CoCivium-url> tmp && cd tmp
git bundle verify ..\Civium-full-20250826.bundle
git clone ..\Civium-full-20250826.bundle Civium-restore
