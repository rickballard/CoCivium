#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import json, math, os, datetime, pathlib, random

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
METRICS = REPO_ROOT / "admin" / "metrics" / "metrics.json"
OUT_SVG = REPO_ROOT / "site" / "assets" / "progress_map_v0.svg"
OUT_SVG_THUMB = REPO_ROOT / "site" / "assets" / "progress_map_thumb_v1_1.svg"

AXES = [
    ("SCO", "Scope/Complexity/Orderliness"),
    ("CI",  "CI Pass Rate"),
    ("COV", "Coverage"),
    ("OFS", "Open File Standards"),
    ("LSH", "Linked Semantic Hubs"),
    ("DTI", "Decision Traceability Index"),
    ("TP",  "Throughput"),
    ("LT",  "Lead Time (lower=better)"),
]

def load_metrics():
    data = {
        "ci_pass_rate": 0.80, "coverage_pct": 60, "ofs_score": 0.5,
        "lsh_score": 0.3, "dti_score": 0.4, "throughput_norm": 0.4,
        "lead_time_hours": 48, "lead_time_max": 72, "sco_score": 0.5, "rd": {}
    }
    if METRICS.exists():
        try:
            incoming = json.loads(METRICS.read_text(encoding="utf-8"))
            g = incoming.get
            data["ci_pass_rate"]    = float(g("ci_pass_rate", data["ci_pass_rate"]))
            data["coverage_pct"]    = float(g("coverage_pct", data["coverage_pct"]))
            data["ofs_score"]       = float(g("ofs_score", data["ofs_score"]))
            data["lsh_score"]       = float(g("lsh_score", data["lsh_score"]))
            data["dti_score"]       = float(g("dti_score", data["dti_score"]))
            data["throughput_norm"] = float(g("throughput_norm", data["throughput_norm"]))
            data["lead_time_hours"] = float(g("lead_time_hours", data["lead_time_hours"]))
            data["lead_time_max"]   = float(g("lead_time_max", data["lead_time_max"]))
            data["sco_score"]       = float(g("sco_score", data["sco_score"]))
            if isinstance(g("rd", {}), dict):
                data["rd"] = {k: max(0.0, min(1.0, float(v))) for k,v in g("rd", {}).items()}
            if not data["rd"] and "duplication_ratio" in incoming:
                dup = max(0.0, min(1.0, float(incoming["duplication_ratio"])))
                data["rd"] = {k[0]: round(0.5*dup, 3) for k in AXES}
        except Exception:
            pass
    return data

def normalize(d):
    vals = {}
    vals["SCO"] = max(0, min(1, d["sco_score"]))
    vals["CI"]  = max(0, min(1, d["ci_pass_rate"]))
    vals["COV"] = max(0, min(1, d["coverage_pct"]/100.0))
    vals["OFS"] = max(0, min(1, d["ofs_score"]))
    vals["LSH"] = max(0, min(1, d["lsh_score"]))
    vals["DTI"] = max(0, min(1, d["dti_score"]))
    vals["TP"]  = max(0, min(1, d["throughput_norm"]))
    denom = d["lead_time_max"] if d["lead_time_max"] > 0 else max(1.0, d["lead_time_hours"])
    vals["LT"]  = 1.0 - max(0.0, min(1.0, d["lead_time_hours"]/denom))
    return vals

def polar_to_xy(cx, cy, r, theta):
    return (cx + r*math.sin(theta), cy - r*math.cos(theta))

def build_svg(data):
    W = H = 1000
    cx = cy = W/2
    R = 400
    rings = [0.15, 0.3, 0.45, 0.6, 0.75, 0.9, 1.0]
    axes = AXES
    n = len(axes)
    vals = normalize(data)
    rd = data.get("rd", {})
    rdv = {k: max(0.0, min(1.0, float(rd.get(k, 0.0)))) for k,_ in axes}

    ts = datetime.datetime.utcnow().replace(microsecond=0).isoformat()+"Z"
    out = []
    out.append(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" role="img" aria-labelledby="title desc">')
    out.append(f'  <title id="title">CoCivium Progress Map — v1.1 — {ts}</title>')
    out.append('  <desc id="desc">8-axis radial map with per-axis Redundancy-Debt dents and tooltips.</desc>')
    out.append('  <defs><filter id="glow" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="4" result="coloredBlur"/><feMerge><feMergeNode in="coloredBlur"/><feMergeNode in="SourceGraphic"/></feMerge></filter></defs>')
    out.append('  <rect width="100%" height="100%" fill="#05060a"/>')

    random.seed(42)
    for _ in range(150):
        x = random.randint(0,W); y = random.randint(0,H); a = random.choice([0.15,0.25,0.35])
        out.append(f'<circle cx="{x}" cy="{y}" r="1.2" fill="white" opacity="{a}"/>')

    for ring in rings:
        rr = R*ring
        if ring < 1.0:
            out.append(f'<circle cx="{cx}" cy="{cy}" r="{rr}" fill="none" stroke="#6ee7ff" stroke-opacity="0.08" stroke-dasharray="2,4"/>')
        else:
            out.append(f'<circle cx="{cx}" cy="{cy}" r="{rr}" fill="none" stroke="#22d3ee" stroke-opacity="0.35"/>')

    for i,(key,label) in enumerate(axes):
        theta = (2*math.pi*i)/n
        x2,y2 = polar_to_xy(cx,cy,R,theta)
        out.append(f'<line x1="{cx}" y1="{cy}" x2="{x2}" y2="{y2}" stroke="#94a3b8" stroke-opacity="0.45"/>')
        lx,ly = polar_to_xy(cx,cy,R+32,theta)
        out.append(f'<text x="{lx}" y="{ly}" fill="#e2e8f0" font-size="14" text-anchor="middle">{label}<title>{key}</title></text>')
        v = vals[key]
        tip_r = R*(v*0.98)
        tx,ty = polar_to_xy(cx,cy,tip_r,theta)
        dent_pct = int(rdv[key]*100)
        out.append(f'<circle cx="{tx:.1f}" cy="{ty:.1f}" r="3.2" fill="#22d3ee"><title>{label}: {round(v*100):d}% (RD dent {dent_pct}%)</title></circle>')

    def dent_profile(angle_diff, width=math.radians(20)):
        return math.exp(- (angle_diff**2) / (2*(width**2)))

    coords = []
    fine_steps = 360
    for s in range(fine_steps):
        theta = (2*math.pi*s)/fine_steps
        axis_idx = int(round((theta/(2*math.pi))*n)) % n
        key,_ = axes[axis_idx]
        v = vals[key]
        base_r = R*(v*0.98)

        dent = 0.0
        for i,(k,_) in enumerate(axes):
            axis_theta = (2*math.pi*i)/n
            dtheta = math.atan2(math.sin(theta-axis_theta), math.cos(theta-axis_theta))
            dent += rdv[k] * dent_profile(abs(dtheta))
        dent = min(1.0, dent)
        dent_depth = 0.15
        r = base_r * (1.0 - dent_depth*dent)
        coords.append(polar_to_xy(cx,cy,r,theta))

    path_d = "M " + " L ".join(f"{x:.2f},{y:.2f}" for x,y in coords) + " Z"
    out.append(f'<path d="{path_d}" fill="#22d3ee" fill-opacity="0.22" stroke="#67e8f9" stroke-opacity="0.8" filter="url(#glow)"><title>Progress polygon with RD dents</title></path>')

    out.append('<g transform="translate(40,40)"><rect x="0" y="0" width="280" height="120" rx="12" ry="12" fill="#0b1220" stroke="#1f2937" opacity="0.9"/><text x="16" y="24" fill="#e2e8f0" font-size="16">Legend</text><circle cx="20" cy="48" r="6" fill="#22d3ee"/><text x="36" y="52" fill="#cbd5e1" font-size="13">Axis tip (value %)<title>Numeric axis tip</title></text><rect x="14" y="64" width="16" height="10" fill="#22d3ee" fill-opacity="0.22" stroke="#67e8f9"/><text x="36" y="72" fill="#cbd5e1" font-size="13">Progress polygon<title>Higher is better</title></text><path d="M14,96 h16" stroke="#94a3b8" stroke-opacity="0.45"/><text x="36" y="100" fill="#cbd5e1" font-size="13">Axis (with RD dent inward)<title>Redundancy-Debt notch reduces radius</title></text></g>')
    out.append('</svg>')
    svg = "\n".join(out)

    OUT_SVG.parent.mkdir(parents=True, exist_ok=True)
    OUT_SVG.write_text(svg, encoding="utf-8")
    OUT_SVG_THUMB.write_text(svg.replace('width="1000" height="1000"', 'width="640" height="640"'), encoding="utf-8")
    print(f">> Wrote {OUT_SVG}")
    print(f">> Wrote {OUT_SVG_THUMB}")

if __name__ == "__main__":
    data = load_metrics()
    build_svg(data)
