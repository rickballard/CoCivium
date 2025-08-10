#!/usr/bin/env python3
# admin/metrics/render_progress_map.py (v1 — prettier)
import json, math, random, hashlib
from pathlib import Path

HERE = Path(__file__).resolve()
REPO = HERE.parents[2]
METRICS = REPO/"admin"/"metrics"/"metrics.json"
OUT = REPO/"site"/"assets"/"progress_map_v0.svg"  # keep same filename for landing page embed

AXES = [
  ("ci", 90,  "Coherence"),
  ("coverage", 45, "Coverage"),
  ("ofs", 0,  "Onramp"),
  ("lsh", 315,"Link/Schema"),
  ("dti", 270,"Decision Trail"),
  ("t_norm", 225,"Throughput"),
  ("lt_norm", 180,"Lead Time"),
  ("ee", 135,"Engagement"),
]

def polar(cx, cy, r, deg):
    rad = math.radians(deg)
    return cx + r*math.cos(rad), cy - r*math.sin(rad)

def clamp01(x): 
    try:
        return max(0.0, min(1.0, float(x)))
    except:
        return 0.0

def seed_rng(metrics):
    s = json.dumps(metrics, sort_keys=True)
    h = hashlib.sha256(s.encode()).hexdigest()
    seed = int(h[:16], 16)
    random.seed(seed)

def soft_curve_path(x1,y1, x2,y2, cx,cy, tension=0.15):
    # control point nudged toward center for a gentle curve
    mx,my = (x1+x2)/2, (y1+y2)/2
    dx,dy = cx-mx, cy-my
    c1x, c1y = mx + dx*tension, my + dy*tension
    return f"M{x1:.1f},{y1:.1f} Q{c1x:.1f},{c1y:.1f} {x2:.1f},{y2:.1f}"

def main():
    data = json.loads(METRICS.read_text(encoding="utf-8"))
    seed_rng(data)

    W, H = 1200, 900
    cx, cy = W/2, H/2 + 10
    R = 360  # outer radius
    rings = 9  # stages
    rd = float(data.get("rd", 0.0))
    dent_frac = min(0.12, rd)  # up to 12% inward dent

    # points for polygon with mild RD dents
    poly_pts = []
    for key, deg, _label in AXES:
        v = clamp01(data.get(key, 0.0))
        # apply a dent proportional to RD near each axis (visual penalty)
        v = max(0.0, v * (1.0 - dent_frac))
        x,y = polar(cx, cy, R*v, deg)
        poly_pts.append((x,y))
    poly_attr = " ".join(f"{x:.1f},{y:.1f}" for x,y in poly_pts)

    # Build SVG
    svg = []
    svg.append(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">')
    # defs: gradient + glow
    svg.append('''<defs>
      <radialGradient id="bgGrad" cx="50%" cy="50%" r="75%">
        <stop offset="0%" stop-color="#0c0f15"/>
        <stop offset="60%" stop-color="#070a0f"/>
        <stop offset="100%" stop-color="#05070b"/>
      </radialGradient>
      <linearGradient id="polyGrad" x1="0%" y1="0%" x2="0%" y2="100%">
        <stop offset="0%" stop-color="#7dd3fc" stop-opacity="0.30"/>
        <stop offset="100%" stop-color="#a78bfa" stop-opacity="0.18"/>
      </linearGradient>
      <filter id="softGlow"><feGaussianBlur stdDeviation="4" result="g"/><feMerge><feMergeNode in="g"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
      <filter id="pointGlow"><feGaussianBlur stdDeviation="1.2" result="g"/><feMerge><feMergeNode in="g"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
    </defs>''')

    # background
    svg.append('<rect x="0" y="0" width="100%" height="100%" fill="url(#bgGrad)"/>' )

    # starfield (deterministic)
    stars = 220
    for _ in range(stars):
        x = random.uniform(0, W)
        y = random.uniform(0, H)
        r = random.uniform(0.3, 1.4)
        o = random.uniform(0.08, 0.4)
        svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{r:.2f}" fill="#ffffff" opacity="{o:.2f}"/>' )

    # rings (stages) + infinite hint
    for i in range(1, rings+1):
        r = R * i/rings
        op = 0.08 if i < rings else 0.20
        dash = ' stroke-dasharray="4,6"' if i == rings else ""
        svg.append(f'<circle cx="{cx}" cy="{cy}" r="{r:.1f}" stroke="#cbd5e1" stroke-opacity="{op}" fill="none"{dash}/>' )
    # minor ring ticks
    for i in range(1, rings*2, 1):
        r = R * i/(rings*2)
        svg.append(f'<circle cx="{cx}" cy="{cy}" r="{r:.1f}" stroke="#94a3b8" stroke-opacity="0.04" fill="none"/>' )

    # radials + labels
    for key, deg, label in AXES:
        x,y = polar(cx, cy, R, deg)
        svg.append(f'<line x1="{cx}" y1="{cy}" x2="{x:.1f}" y2="{y:.1f}" stroke="#e2e8f0" stroke-opacity="0.12"/>' )
        lx,ly = polar(cx, cy, R+34, deg)
        svg.append(f'<text x="{lx:.1f}" y="{ly:.1f}" fill="#cbd5e1" font-size="14" text-anchor="middle" dominant-baseline="middle">{label}</text>')

    # fungal filaments (concept links)
    links = data.get("links", [])
    id_to_point = {}
    for sp in data.get("starpoints", []):
        deg = float(sp.get("theta_deg", 0.0))
        r  = float(sp.get("r", 0.0))
        x,y = polar(cx, cy, R*clamp01(r), deg)
        id_to_point[sp.get("id","?")] = (x,y)
    for a,b in links:
        if a in id_to_point and b in id_to_point:
            x1,y1 = id_to_point[a]
            x2,y2 = id_to_point[b]
            path = soft_curve_path(x1,y1,x2,y2,cx,cy, tension=0.18)
            svg.append(f'<path d="{path}" stroke="#93c5fd" stroke-opacity="0.18" stroke-width="1.2" fill="none"/>' )

    # polygon
    svg.append(f'<polygon points="{poly_attr}" fill="url(#polyGrad)" stroke="#7dd3fc" stroke-opacity="0.55" stroke-width="2" filter="url(#softGlow)"/>' )

    # starpoints with shooting trails
    for sp in data.get("starpoints", []):
        deg = float(sp.get("theta_deg", 0.0))
        r  = float(sp.get("r", 0.0))
        v  = float(sp.get("velocity", 0.0))
        x,y = polar(cx, cy, R*clamp01(r), deg)
        # trail (short backwards along the radial)
        if v > 0:
            tlen = min(40 + 200*v, 140)
            bx,by = polar(cx, cy, R*clamp01(r) - tlen, deg)
            svg.append(f'<line x1="{bx:.1f}" y1="{by:.1f}" x2="{x:.1f}" y2="{y:.1f}" stroke="#fde68a" stroke-opacity="0.35" stroke-width="1.6"/>' )
        # point
        svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="3.6" fill="#fde68a" filter="url(#pointGlow)"/>' )
        lbl = sp.get("id","").replace("_"," ")
        svg.append(f'<text x="{x+10:.1f}" y="{y-8:.1f}" fill="#fef3c7" font-size="12">{lbl}</text>')

    # title + legend
    title = "CoCivium Progress Map — v1"
    svg.append(f'<text x="{cx}" y="{34}" fill="#e2e8f0" font-size="20" text-anchor="middle">{title}</text>')
    # RD badge
    rd_pct = int(round(clamp01(rd)*100))
    svg.append(f'<rect x="{W-220}" y="24" width="196" height="62" rx="10" fill="#0b1220" opacity="0.6"/>' )
    svg.append(f'<text x="{W-120}" y="48" fill="#cbd5e1" font-size="14" text-anchor="middle">Redundancy Debt</text>')
    svg.append(f'<text x="{W-120}" y="70" fill="#fca5a5" font-size="16" text-anchor="middle">{rd_pct}%</text>')

    svg.append('</svg>')
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text("\n".join(svg), encoding="utf-8")

if __name__ == "__main__":
    main()

