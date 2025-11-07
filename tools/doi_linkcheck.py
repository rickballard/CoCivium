import json, re, sys, urllib.request, urllib.error, pathlib
ROOT = pathlib.Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"

UA = "CoCivium-Linkcheck/1.0 (+https://github.com/rickballard/CoCivium)"
OK_RANGE = set(list(range(200,300)) + list(range(300,400)))

def iter_targets():
    for p in DOCS.rglob("*.md"):
        yield p, p.read_text(encoding="utf-8", errors="ignore")
    ref = ROOT / "docs/insights/luminaries/references.json"
    if ref.exists():
        yield ref, ref.read_text(encoding="utf-8", errors="ignore")

def urls_in_text(text):
    return re.findall(r'https?://[^\s)>\]]+', text)

def check_url(u, timeout=20):
    # HEAD first (some hosts allow), then GET fallback
    for method in ("HEAD","GET"):
        try:
            req = urllib.request.Request(u, method=method, headers={"User-Agent": UA})
            with urllib.request.urlopen(req, timeout=timeout) as r:
                if r.status in OK_RANGE:
                    return (r.status, "ok:"+method)
                return (r.status, "bad:"+method)
        except urllib.error.HTTPError as e:
            # Accept redirects; otherwise surface code
            if e.code in OK_RANGE:
                return (e.code, "redir:"+method)
            last = (e.code, f"http:{method}")
        except Exception as e:
            last = (0, f"err:{method}:{e}")
    return last

bad = []
for f, data in iter_targets():
    if f.suffix.lower()==".json":
        try:
            obj=json.loads(data); cand=[x.get("url","") for x in obj.get("references",[])]
        except Exception:
            cand=[]
    else:
        cand=urls_in_text(data)
    for u in sorted(set(cand)):
        if u.startswith("http"):
            s,reason = check_url(u)
            if s==0 or (s not in OK_RANGE):
                bad.append((str(f), u, s, reason))

if bad:
    print("Broken/unstable links detected:")
    for f,u,s,r in bad:
        print(f"- {f} -> {u} [{s}] {r}")
    sys.exit(1)
print("All links OK (2xx/3xx accepted).")
