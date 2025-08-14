#!/usr/bin/env python3
# Render simple SVG "eyes" from TOML metrics. No external deps.

import tomllib, pathlib

def bar(value, maxv, x, y, w, h, label):
    pct = 0 if maxv == 0 else min(value / maxv, 1.0)
    filled = int(w * pct)
    return (
        f'<text x="{x}" y="{y-6}" font-size="10" fill="#aaa">{label}: {value}</text>'
        f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="3" fill="#222"/>'
        f'<rect x="{x}" y="{y}" width="{filled}" height="{h}" rx="3" fill="#00d4ff"/>'
    )

def render_mission(m):
    svg = [
        '<svg xmlns="http://www.w3.org/2000/svg" width="420" height="150">',
        f'<text x="12" y="20" font-size="12" fill="#fff">Mission Eye — {m.get("period","")}</text>'
    ]
    items = [
        ("Adopters", m.get("adopters",0), 100),
        ("Published Logs", m.get("published_logs",0), 300),
        ("Median Days", m.get("median_time_to_decision_days",0), 30),
        ("Referral %", m.get("referral_rate_pct",0), 100),
    ]
    y = 40
    for label, val, maxv in items:
        svg.append(bar(val, maxv, 12, y, 360, 12, label))
        y += 28
    svg.append("</svg>")
    return "\n".join(svg)

def render_cred(c):
    svg = [
        '<svg xmlns="http://www.w3.org/2000/svg" width="420" height="170">',
        f'<text x="12" y="20" font-size="12" fill="#fff">Credibility Eye — {c.get("period","")}</text>'
    ]
    items = [
        ("DII Verified", c.get("dii_verified_count",0), 50),
        ("Case Studies", c.get("case_studies_published",0), 50),
    ]
    y = 40
    for label, val, maxv in items:
        svg.append(bar(val, maxv, 12, y, 360, 12, label))
        y += 28
    y += 6
    svg.append(f'<text x="12" y="{y}" font-size="10" fill="#aaa">Top Risks</text>')
    x = 90
    for r in c.get("top_risks", [])[:5]:
        rpn = r.get("rpn", 0)
        color = "#19c37d" if rpn <= 4 else "#f5a623" if rpn <= 9 else "#ff4d4f"
        svg.append(f'<circle cx="{x}" cy="{y-4}" r="6" fill="{color}"></circle>')
        x += 20
    svg.append("</svg>")
    return "\n".join(svg)

def main():
    base = pathlib.Path(".")
    mission = tomllib.loads(base.joinpath("metrics/mission.toml").read_text(encoding="utf-8"))
    cred = tomllib.loads(base.joinpath("metrics/credibility.toml").read_text(encoding="utf-8"))
    outdir = base.joinpath("docs/img")
    outdir.mkdir(parents=True, exist_ok=True)
    outdir.joinpath("mission_eye.svg").write_text(render_mission(mission), encoding="utf-8")
    outdir.joinpath("credibility_eye.svg").write_text(render_cred(cred), encoding="utf-8")
    print("Rendered mission_eye.svg and credibility_eye.svg")

if __name__ == "__main__":
    main()
