#!/usr/bin/env python3
# admin/metrics/collect_metrics.py
import os, re, json, subprocess, datetime, statistics, math
from pathlib import Path

HERE = Path(__file__).resolve()
REPO = HERE.parents[2]  # admin/metrics -> admin -> repo root
ASSETS = REPO / "site" / "assets"
HISTORY = REPO / "admin" / "metrics" / "history"
OUT = REPO / "admin" / "metrics" / "metrics.json"

def sh(cmd):
    return subprocess.check_output(cmd, shell=True, cwd=REPO, text=True).strip()

def list_files(exts=(".md", ".mdx")):
    for p in REPO.rglob("*"):
        if p.is_file() and p.suffix.lower() in exts:
            yield p

def coherence_index():
    # average of _cX_ tags found in filenames (X in 0..9), weighted by file type heuristic
    weights = []
    scores = []
    pat = re.compile(r"_c(\d)_")
    for p in list_files():
        m = pat.search(p.name)
        if not m: 
            continue
        x = int(m.group(1))/10.0
        w = 1.0
        sp = str(p.as_posix()).lower()
        if "scroll" in sp or "cognocarta" in sp: w = 5.0
        elif "protocol" in sp or "govern" in sp: w = 4.0
        elif "insight" in sp: w = 3.0
        elif p.name.lower().startswith("readme"): w = 4.0
        weights.append(w); scores.append(x)
    if not weights:
        return 0.0
    num = sum(w*s for w,s in zip(weights, scores))
    den = sum(weights)
    return max(0.0, min(1.0, num/den))

def onramp_fitness():
    # presence checks
    checks = 0; total = 6
    if (REPO/"README.md").exists(): checks += 1
    if (REPO/".github"/"ISSUE_TEMPLATE").exists(): checks += 1
    if (REPO/"CONTRIBUTING.md").exists(): checks += 1
    # start-here path
    for cand in ["docs/START_HERE.md","docs/Start-Here.md","docs/start-here.md","START_HERE.md"]:
        if (REPO/cand).exists(): checks += 1; break
    # quickstart presence
    for cand in ["docs/QUICKSTART.md","docs/Quickstart.md","QUICKSTART.md"]:
        if (REPO/cand).exists(): checks += 1; break
    # evomap/legend presence (placeholder file)
    for cand in ["site/README.md","site/LEGEND.md","admin/assets/admin_CoCivium_Progress_Map_Plan_20250810.md"]:
        if (REPO/cand).exists(): checks += 1; break
    return checks/total

def link_schema_health():
    # Check relative links in markdown resolve to files/anchors (files only)
    md_files = list(list_files())
    if not md_files: 
        return 0.0
    link_pat = re.compile(r"\]\((?!http)([^)#\s]+)")
    ok, total = 0, 0
    for p in md_files:
        text = p.read_text(encoding="utf-8", errors="ignore")
        for m in link_pat.finditer(text):
            total += 1
            target = (p.parent / m.group(1)).resolve()
            if target.exists():
                ok += 1
    if total == 0:
        return 1.0
    return ok/total

def decision_trail_integrity():
    # crude: last 20 commits; score messages containing rationale keywords or longer messages
    try:
        log = sh('git log --since="30 days ago" --pretty=format:%s%n%b --max-count=50')
    except subprocess.CalledProcessError:
        return 0.0
    msgs = [m.strip() for m in log.split("\n\n") if m.strip()]
    if not msgs: 
        return 0.0
    keys = re.compile(r"\b(rationale|why|derived_from|decision|because)\b", re.I)
    scores = []
    for m in msgs[:20]:
        s = 0.0
        if len(m) >= 60: s += 0.5
        if keys.search(m): s += 0.5
        scores.append(min(1.0, s))
    return sum(scores)/len(scores)

def throughput_per_month():
    try:
        n = int(sh('git rev-list --count --since="30 days ago" HEAD'))
        return n
    except:
        return 0

def t_norm(t):
    return 1.0/(1.0 + math.exp(-(t - 20)/5.0))

def lead_time_days_norm():
    # TODO: requires issues/PRs. placeholder to 0.5
    return 0.5, None

def external_engagement():
    # TODO: requires API. placeholder 0.0
    return 0.0

def redundancy_debt():
    # count duplicate stems ignoring _cX_ and date-like tokens
    stems = {}
    for p in list_files():
        name = p.stem
        name = re.sub(r"_c\d_", "_", name)
        name = re.sub(r"_\d{8,}", "_", name)
        name = name.lower()
        stems.setdefault(name, 0)
        stems[name] += 1
    dupes = sum(1 for k,v in stems.items() if v>1)
    topics = max(1, len(stems))
    return dupes/topics

def coverage():
    # If a manifest exists, compute; else 0.0
    manifest = REPO/"admin"/"manifest.json"
    if manifest.exists():
        try:
            data = json.loads(manifest.read_text(encoding="utf-8"))
            mt = len(data.get("must", [])); st = len(data.get("should", []))
            mh = sum(1 for p in data.get("must", []) if (REPO/p).exists())
            shh = sum(1 for p in data.get("should", []) if (REPO/p).exists())
            denom = mt + 0.5*st
            return ((mh + 0.5*shh)/denom) if denom>0 else 0.0
        except Exception:
            return 0.0
    return 0.0

def main():
    ci = coherence_index()
    cov = coverage()
    ofs = onramp_fitness()
    lsh = link_schema_health()
    dti = decision_trail_integrity()
    tp = throughput_per_month()
    tN = t_norm(tp)
    ltN, lt_days = lead_time_days_norm()
    ee = external_engagement()
    rd = redundancy_debt()

    now = datetime.datetime.now(datetime.UTC).replace(microsecond=0).isoformat()+"Z"
    data = {
        "timestamp": now,
        "ci": round(ci,3),
        "coverage": round(cov,3),
        "ofs": round(ofs,3),
        "lsh": round(lsh,3),
        "dti": round(dti,3),
        "throughput_per_month": tp,
        "t_norm": round(tN,3),
        "lead_time_days": lt_days,
        "lt_norm": round(ltN,3),
        "ee": round(ee,3),
        "rd": round(rd,3),
        "starpoints": [
            { "id":"MeritRank_Demo", "theta_deg":270, "r":0.5, "stage":5, "velocity":0.05 },
            { "id":"Opename_Stub",   "theta_deg":135, "r":0.3, "stage":4, "velocity":0.02 }
        ],
        "links":[ ["MeritRank_Demo","Opename_Stub"] ]
    }

    HISTORY.mkdir(parents=True, exist_ok=True)
    ASSETS.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(data, indent=2), encoding="utf-8")
    stamp = datetime.datetime.now(datetime.UTC).strftime("%Y%m%d_%H%M%SZ")
    (HISTORY/f"metrics_{stamp}.json").write_text(json.dumps(data, indent=2), encoding="utf-8")

    # Render SVG
    import subprocess, sys
    subprocess.check_call(["python", str(HERE.parent/"render_progress_map.py")])

if __name__ == "__main__":
    main()

