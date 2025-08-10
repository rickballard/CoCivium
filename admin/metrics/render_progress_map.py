#!/usr/bin/env python3
# admin/metrics/render_progress_map.py
import json, math
from pathlib import Path

HERE = Path(__file__).resolve()
REPO = HERE.parents[2]
METRICS = REPO/"admin"/"metrics"/"metrics.json"
OUT = REPO/"site"/"assets"/"progress_map_v0.svg"

AXES = [
  ("ci", 90),
  ("coverage", 45),
  ("ofs", 0),
  ("lsh", 315),
  ("dti", 270),
  ("t_norm", 225),
  ("lt_norm", 180),
  ("ee", 135),
]

def polar_point(cx, cy, r, deg):
    rad = math.radians(deg)
    return cx + r*math.cos(rad), cy - r*math.sin(rad)

def clamp01(x): 
    return max(0.0, min(1.0, float(x)))

def main():
    data = json.loads(METRICS.read_text(encoding="utf-8"))
    W, H = 900, 900
    cx, cy = W/2, H/2
    R = 360  # outer radius
    rings = 9  # stages 1..9

    # Build polygon points
    pts = []
    for key, deg in AXES:
        v = clamp01(data.get(key, 0.0))
        x,y = polar_point(cx, cy, R*v, deg)
        pts.append(f"{x:.1f},{y:.1f}")
    poly = " ".join(pts)

    # SVG
    svg = []
    svg.append(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">')
    svg.append('<defs><filter id="glow"><feGaussianBlur stdDeviation="3" result="coloredBlur"/><feMerge><feMergeNode in="coloredBlur"/><feMergeNode in="SourceGraphic"/></feMerge></filter></defs>')
    svg.append('<rect x="0" y="0" width="100%" height="100%" fill="black"/>')

    # Rings
    for i in range(1, rings+1):
        r = R * i/rings
        opacity = 0.08 if i < rings else 0.15
        svg.append(f'<circle cx="{cx}" cy="{cy}" r="{r:.1f}" stroke="white" stroke-opacity="{opacity}" fill="none"/>' )

    # Radials and labels
    for key, deg in AXES:
        x,y = polar_point(cx, cy, R, deg)
        svg.append(f'<line x1="{cx}" y1="{cy}" x2="{x:.1f}" y2="{y:.1f}" stroke="white" stroke-opacity="0.12"/>')
        lx,ly = polar_point(cx, cy, R+24, deg)
        lbl = key.upper()
        svg.append(f'<text x="{lx:.1f}" y="{ly:.1f}" fill="white" font-size="12" text-anchor="middle" dominant-baseline="middle">{lbl}</text>')

    # Polygon
    svg.append(f'<polygon points="{poly}" fill="white" fill-opacity="0.12" stroke="white" stroke-opacity="0.4" filter="url(#glow)"/>')

    # Title
    svg.append(f'<text x="{cx}" y="{40}" fill="white" font-size="18" text-anchor="middle">CoCivium Progress Map (v0)</text>')
    svg.append('</svg>')
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text("\n".join(svg), encoding="utf-8")

if __name__ == "__main__":
    main()

