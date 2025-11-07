import json, os, re, sys, subprocess, pathlib, urllib.request

ROOT = pathlib.Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"

def iter_md_files():
    for p in DOCS.rglob("*.md"):
        yield p
    # also scan references.json if present
    ref = ROOT / "docs/insights/luminaries/references.json"
    if ref.exists():
        yield ref

def urls_in_text(text):
    # crude but robust
    return re.findall(r'https?://[^\s)>\]]+', text)

def check_url(u, timeout=15):
    try:
        req = urllib.request.Request(u, method="HEAD")
        with urllib.request.urlopen(req, timeout=timeout) as r:
            return (r.status, r.reason)
    except Exception as e:
        return (0, str(e))

bad = []
for f in iter_md_files():
    data = f.read_text(encoding="utf-8", errors="ignore")
    if f.suffix.lower()==".json":
        try:
            obj=json.loads(data)
            cand=[x.get("url","") for x in obj.get("references",[])]
        except Exception:
            cand=[]
    else:
        cand=urls_in_text(data)
    for u in sorted(set(cand)):
        if "doi.org" in u or "arxiv.org" in u or u.startswith("http"):
            status,reason = check_url(u)
            if status==0 or status>=400:
                bad.append((str(f), u, status, reason))

if bad:
    print("Broken/unstable links detected:")
    for f,u,s,r in bad:
        print(f"- {f} -> {u} [{s}] {r}")
    sys.exit(1)
print("All DOI/arXiv/general links OK.")
