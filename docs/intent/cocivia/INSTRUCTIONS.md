# Integration Instructions (Repo-first)

## Target paths
- `docs/intent/cocivia/**` → all docs from this package (press, schemas, vendor, policy, etc.)
- `.github/workflows/*.yml` → from `advice/ci/`

## DO: copy, commit, PR
```powershell
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$R = "$HOME\Documents\GitHub\CoCivium"
git -C $R switch main; git -C $R pull --ff-only
$B = "feat/cocivia-launch-prep-v1.0-20251027_232056Z"
git -C $R switch -c $B

$src = "<unzipped_path>\AdviceBomb_CoCiviaOutreach_v1.0_LaunchPrep_20251027_232056Z\advice"
$dst = Join-Path $R 'docs\intent\cocivia'
robocopy $src $dst /E /NFL /NDL /NJH /NJS /NP | Out-Null

# CI workflows
Copy-Item "<unzipped_path>\AdviceBomb_CoCiviaOutreach_v1.0_LaunchPrep_20251027_232056Z\advice\ci\cocivia-validate.yml" (Join-Path $R ".github\workflows\cocivia-validate.yml") -Force
Copy-Item "<unzipped_path>\AdviceBomb_CoCiviaOutreach_v1.0_LaunchPrep_20251027_232056Z\advice\ci\cocivia-freshness.yml" (Join-Path $R ".github\workflows\cocivia-freshness.yml") -Force
Copy-Item "<unzipped_path>\AdviceBomb_CoCiviaOutreach_v1.0_LaunchPrep_20251027_232056Z\advice\ci\cocivia-scorer.yml" (Join-Path $R ".github\workflows\cocivia-scorer.yml") -Force

git -C $R add .
git -C $R commit -m "docs/ci: CoCivia launch-prep v1.0 (press, schemas, procurement, vendor ratings, policy maps, CI)"
git -C $R push -u origin $B
try { gh -C $R pr create -B main -H $B -t "CoCivia launch-prep v1.0" -b "Press kit, governance, procurement pack, vendor ratings, policy maps, CI pipelines" } catch {}
```

## After merge (CoSync note)
Create `docs/intent/advice/notes/20251027/CoSync_20251027_232056Z.md` with:
- Pointers to merged paths on **main**
- Inbox paths on CoCache + `INBOX_LOG` tail
- Pilot targets & editor targets
- Next-step owners & dates
