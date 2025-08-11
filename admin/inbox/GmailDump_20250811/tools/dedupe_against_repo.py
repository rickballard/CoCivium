
#!/usr/bin/env python3
import argparse, os, sys, csv, hashlib, pathlib, json

TEXT = {"txt","md","csv","json","yml","yaml","xml","ini","log","py","js","ts","html","css","rst"}
def sha256_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1<<20), b""):
            h.update(chunk)
    return h.hexdigest()

def scan_repo(repo_root):
    repo_root = pathlib.Path(repo_root)
    mapping = {}
    for root, dirs, files in os.walk(repo_root):
        # Skip .git and node_modules and typical vendor
        if ".git" in dirs: dirs.remove(".git")
        if "node_modules" in dirs: dirs.remove("node_modules")
        for fn in files:
            p = pathlib.Path(root) / fn
            try:
                digest = sha256_file(p)
            except Exception:
                continue
            mapping.setdefault(digest, []).append(p.as_posix())
    return mapping

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("inbox_root", help="Path to admin/inbox/GmailDump_20250811")
    ap.add_argument("--repo-root", default=".", help="Repo root (default: current directory)")
    ap.add_argument("--verify-only", action="store_true", help="Only verify hashes for originals")
    args = ap.parse_args()

    inbox = pathlib.Path(args.inbox_root)
    manifest_csv = inbox / "manifest" / "Civium_GmailDump_Manifest_20250811.csv"
    out_csv = inbox / "manifest" / "Manifest_with_repo_matches.csv"

    rows = []
    with open(manifest_csv, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for r in reader:
            rows.append(r)

    # Verify originals' hashes
    ok = True
    for r in rows:
        p = inbox / pathlib.Path("originals") / r["original_relpath"]
        try:
            digest = sha256_file(p)
        except Exception as e:
            print(f"[WARN] Could not read {p}: {e}")
            ok = False
            continue
        if digest != r["sha256"]:
            print(f"[MISMATCH] {r['original_relpath']} sha256 differs!")
            ok = False
    if args.verify_only:
        sys.exit(0 if ok else 2)

    # Build repo hash index
    print("[*] Scanning repo for duplicates by SHA-256 ...")
    repo_map = scan_repo(args.repo_root)

    # Annotate matches
    for r in rows:
        matches = repo_map.get(r["sha256"], [])
        r["matches_in_repo_count"] = len(matches)
        r["matches_in_repo_paths"] = "; ".join(matches)

    # Write annotated manifest
    with open(out_csv, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        w.writeheader()
        w.writerows(rows)

    print(f"[*] Wrote {out_csv}")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
