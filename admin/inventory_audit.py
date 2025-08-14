\
#!/usr/bin/env python3
Inventory audit: hash files, count by extension, find dupes, emit CSV + Markdown.
Usage:
  python tools/inventory_audit.py [PATH ...]
If no PATH given, defaults to: admin/inbox admin/hold deprecated/holding

Outputs to ./reports/:
  - inventory_20250811_0657.csv
  - inventory_summary_20250811_0657.md
Exit code: 0 on success, >0 on error.


import argparse, csv, hashlib, os, sys, time
from pathlib import Path
from datetime import datetime
from collections import defaultdict

def sha256_file(p: Path, bufsize=1024*1024) -> str:
    h = hashlib.sha256()
    with p.open('rb') as f:
        while True:
            b = f.read(bufsize)
            if not b:
                break
            h.update(b)
    return h.hexdigest()

def main():
    parser = argparse.ArgumentParser(description="Inventory audit for migration sanity checks.")
    parser.add_argument("paths", nargs="*", help="Directories or files to scan")
    args = parser.parse_args()

    default_paths = ["admin/inbox", "admin/hold", "deprecated/holding"]
    targets = args.paths or default_paths

    report_dir = Path("reports")
    report_dir.mkdir(parents=True, exist_ok=True)

    ts = datetime.now().strftime("%Y%m%d_%H%M")
    csv_path = report_dir / f"inventory_{ts}.csv"
    md_path  = report_dir / f"inventory_summary_{ts}.md"

    rows = []
    ext_counts = defaultdict(int)
    ext_bytes  = defaultdict(int)
    by_hash = defaultdict(list)
    total_files = 0
    total_bytes = 0

    start = time.time()
    scanned_roots = []

    for tgt in targets:
        root = Path(tgt)
        scanned_roots.append(str(root))
        if root.is_file():
            files = [root]
        else:
            if not root.exists():
                continue
            files = [p for p in root.rglob("*") if p.is_file()]
        for p in files:
            try:
                rel = str(p)
                st = p.stat()
                size = st.st_size
                mtime = datetime.fromtimestamp(st.st_mtime).isoformat(timespec="seconds")
                h = sha256_file(p)
                rows.append([rel, str(size), mtime, h])
                ext = p.suffix.lower() or "<none>"
                ext_counts[ext] += 1
                ext_bytes[ext] += size
                by_hash[h].append(rel)
                total_files += 1
                total_bytes += size
            except Exception as exc:
                rows.append([str(p), "-1", "ERROR", f"error:{type(exc).__name__}:{exc}"])

    # Write CSV
    with csv_path.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["path", "size_bytes", "mtime_iso", "sha256"])
        w.writerows(rows)

    # Build summary
    secs = time.time() - start
    dupes = {h: lst for h, lst in by_hash.items() if len(lst) > 1}

    def fmt_bytes(n):
        for unit in ["B","KB","MB","GB","TB"]:
            if n < 1024.0:
                return f"{n:.1f} {unit}"
            n /= 1024.0
        return f"{n:.1f} PB"

    def sha256_file_quick(path: Path) -> str:
        h = hashlib.sha256(path.read_bytes()).hexdigest()
        return h

    with md_path.open("w", encoding="utf-8") as f:
        f.write("# Inventory Summary\n")
        f.write(f"**Generated:** {datetime.now().isoformat(timespec='seconds')}\n\n")
        f.write(f"**Roots scanned:** {', '.join(scanned_roots) if scanned_roots else '(none)'}\n\n")
        f.write(f"**Files:** {total_files}\n\n")
        f.write(f"**Bytes:** {total_bytes} ({fmt_bytes(total_bytes)})\n\n")
        f.write("## By extension (count / bytes)\n")
        for ext in sorted(ext_counts.keys()):
            f.write(f"- {ext} — {ext_counts[ext]} / {ext_bytes[ext]} ({fmt_bytes(ext_bytes[ext])})\n")
        f.write("\n## Duplicate files (same sha256)\n")
        if not dupes:
            f.write("- None found.\n")
        else:
            for h, paths in dupes.items():
                f.write(f"- **{h}**\n")
                for p in paths:
                    f.write(f"  - {p}\n")
        f.write("\n## CSV manifest\n")
        f.write(f"- Path: {csv_path}\n")
        csv_hash = sha256_file_quick(csv_path)
        f.write(f"- sha256: {csv_hash}\n")
        f.write(f"\n_Elapsed: {secs:.2f}s_\n")

    print("Wrote:", csv_path)
    print("Wrote:", md_path)
    return 0

if __name__ == "__main__":
    import sys
    sys.exit(main())
