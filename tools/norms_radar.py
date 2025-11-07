import json, math, pathlib
import matplotlib.pyplot as plt

# Input JSON path, output PNG path
import sys
if len(sys.argv) < 3:
    print("usage: norms_radar.py INPUT.json OUTPUT.png"); sys.exit(2)

inp = pathlib.Path(sys.argv[1])
out = pathlib.Path(sys.argv[2])

data = json.loads(inp.read_text(encoding="utf-8"))
axes = ["consent","reversibility","legibility","pluralism","entropy","dignity","harms"]
values = [ float(data.get(k,0)) for k in axes ]

# Radar setup
N = len(axes)
angles = [n / float(N) * 2*math.pi for n in range(N)]
values += values[:1]
angles += angles[:1]

plt.figure(figsize=(6,6))
ax = plt.subplot(111, polar=True)
ax.set_theta_offset(math.pi / 2)
ax.set_theta_direction(-1)
ax.set_thetagrids([a*180/math.pi for a in angles[:-1]], axes)
ax.set_rlabel_position(0)
ax.set_ylim(0, 1.0)

ax.plot(angles, values, linewidth=2)
ax.fill(angles, values, alpha=0.15)

out.parent.mkdir(parents=True, exist_ok=True)
plt.tight_layout()
plt.savefig(out, dpi=144)
print(f"Wrote {out}")
