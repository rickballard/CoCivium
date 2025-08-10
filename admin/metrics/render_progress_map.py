#!/usr/bin/env python3
import json, math, random, hashlib
from pathlib import Path
HERE = Path(__file__).resolve(); REPO = HERE.parents[2]
METRICS = REPO/"admin"/"metrics"/"metrics.json"; OUT = REPO/"site"/"assets"/"progress_map_v0.svg"
AXES=[("ci",90,"Coherence"),("coverage",45,"Coverage"),("ofs",0,"Onramp"),("lsh",315,"Link/Schema"),("dti",270,"Decision Trail"),("t_norm",225,"Throughput"),("lt_norm",180,"Lead Time"),("ee",135,"Engagement")]
DESC={"ci":"Weighted coherence/resonance (proxy for alignment).","coverage":"Canon coverage (must/should manifest).","ofs":"Newcomer onramp fitness (README/Quickstart/etc.).","lsh":"Link & schema hygiene (lint, anchors, metadata).","dti":"Decision-trail integrity (rationale/lineage).","t_norm":"Change cadence vs target (normalized).","lt_norm":"Responsiveness (lower lead time ⇒ higher score).","ee":"External engagement (issues/PRs/returns/traffic)."}
def polar(cx,cy,r,deg): rad=math.radians(deg); return cx+r*math.cos(rad), cy-r*math.sin(rad)
def c01(x): 
  try: return max(0.0,min(1.0,float(x)))
  except: return 0.0
def seed(m): random.seed(int(hashlib.sha256(json.dumps(m,sort_keys=True).encode()).hexdigest()[:16],16))
def soft(x1,y1,x2,y2,cx,cy,t=0.18):
  mx,my=(x1+x2)/2,(y1+y2)/2; dx,dy=cx-mx,cy-my; c1x,c1y=mx+dx*t,my+dy*t; return f"M{x1:.1f},{y1:.1f} Q{c1x:.1f},{c1y:.1f} {x2:.1f},{y2:.1f}"
def txt(s,x,y,size=12,color="#cbd5e1",anchor="start"): return f'<text x="{x}" y="{y}" fill="{color}" font-size="{size}" text-anchor="{anchor}">{s}</text>'
def main():
  if not METRICS.exists():
    METRICS.parent.mkdir(parents=True,exist_ok=True)
    METRICS.write_text(json.dumps({"timestamp":"(missing)","ci":0,"coverage":0,"ofs":0,"lsh":0,"dti":0,"t_norm":0,"lt_norm":0,"ee":0,"rd":0,"rd_axes":{},"starpoints":[],"links":[]},indent=2),encoding="utf-8")
  data=json.loads(METRICS.read_text(encoding="utf-8")); seed(data)
  W,H=1280,920; cx,cy=W/2,H/2+20; R=380; rings=9; rd_axes=data.get("rd_axes",{})
  pts=[]; tips=[]
  for key,deg,label in AXES:
    v=c01(data.get(key,0.0)); dent=float(rd_axes.get(key,0.0)); v2=max(0.0, v*(1.0-min(0.22,dent)))
    x,y=polar(cx,cy,R*v2,deg); pts.append((x,y)); tips.append((x,y,key,v))
  poly=" ".join(f"{x:.1f},{y:.1f}" for x,y in pts)
  svg=[]
  svg.append(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">')
  svg.append('''<defs><radialGradient id="bgGrad" cx="50%" cy="50%" r="75%"><stop offset="0%" stop-color="#0c0f15"/><stop offset="60%" stop-color="#070a0f"/><stop offset="100%" stop-color="#05070b"/></radialGradient><linearGradient id="polyGrad" x1="0%" y1="0%" x2="0%" y2="100%"><stop offset="0%" stop-color="#7dd3fc" stop-opacity="0.30"/><stop offset="100%" stop-color="#a78bfa" stop-opacity="0.18"/></linearGradient><filter id="softGlow"><feGaussianBlur stdDeviation="4" result="g"/><feMerge><feMergeNode in="g"/><feMergeNode in="SourceGraphic"/></feMerge></filter><filter id="pointGlow"><feGaussianBlur stdDeviation="1.2" result="g"/><feMerge><feMergeNode in="g"/><feMergeNode in="SourceGraphic"/></feMerge></filter></defs>''')
  svg.append('<rect x="0" y="0" width="100%" height="100%" fill="url(#bgGrad)"/>')
  for _ in range(260):
    x=random.uniform(0,W); y=random.uniform(0,H); rr=random.uniform(0.3,1.4); o=random.uniform(0.06,0.4)
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{rr:.2f}" fill="#ffffff" opacity="{o:.2f}"/>')
  for i in range(1,rings+1):
    r=R*i/rings; op=0.08 if i<rings else 0.20; dash=' stroke-dasharray="4,6"' if i==rings else ""
    svg.append(f'<circle cx="{cx}" cy="{cy}" r="{r:.1f}" stroke="#cbd5e1" stroke-opacity="{op}" fill="none"{dash}/>')
    lx,ly=polar(cx,cy,r,350); svg.append(f'<text x="{lx:.1f}" y="{ly:.1f}" fill="#94a3b8" font-size="11" text-anchor="start">Stage {i}</text>')
  for i in range(1,rings*2):
    r=R*i/(rings*2); svg.append(f'<circle cx="{cx}" cy="{cy}" r="{r:.1f}" stroke="#94a3b8" stroke-opacity="0.04" fill="none"/>')
  for key,deg,label in AXES:
    x,y=polar(cx,cy,R,deg)
    svg.append(f'<line x1="{cx}" y1="{cy}" x2="{x:.1f}" y2="{y:.1f}" stroke="#e2e8f0" stroke-opacity="0.12"><title>{label}: {DESC.get(key,"")}</title></line>')
    lx,ly=polar(cx,cy,R+42,deg); svg.append(f'<text x="{lx:.1f}" y="{ly:.1f}" fill="#cbd5e1" font-size="14" text-anchor="middle" dominant-baseline="middle">{label}</text>')
  svg.append(f'<polygon points="{poly}" fill="url(#polyGrad)" stroke="#7dd3fc" stroke-opacity="0.55" stroke-width="2" filter="url(#softGlow)"><title>Progress envelope (farther out = healthier)</title></polygon>')
  for x,y,key,v in tips:
    svg.append(f'<text x="{x:.1f}" y="{y:.1f}" fill="#e2e8f0" font-size="12" text-anchor="middle" dy="-6"><title>{DESC.get(key,"")}</title>{int(round(100*float(v)))}%</text>')
  links=data.get("links",[]); id2={}
  for sp in data.get("starpoints",[]):
    deg=float(sp.get("theta_deg",0.0)); rr=float(sp.get("r",0.0)); x,y=polar(cx,cy,R*c01(rr),deg); id2[sp.get("id","?")]=(x,y)
  for a,b in links:
    if a in id2 and b in id2:
      x1,y1=id2[a]; x2,y2=id2[b]; path=soft(x1,y1,x2,y2,cx,cy,0.18)
      svg.append(f'<path d="{path}" stroke="#93c5fd" stroke-opacity="0.18" stroke-width="1.2" fill="none"><title>Concept link: {a} ↔ {b}</title></path>')
  for sp in data.get("starpoints",[]):
    deg=float(sp.get("theta_deg",0.0)); rr=float(sp.get("r",0.0)); v=float(sp.get("velocity",0.0)); x,y=polar(cx,cy,R*c01(rr),deg)
    if v>0:
      tlen=min(40+200*v,140); bx,by=polar(cx,cy,R*c01(rr)-tlen,deg)
      svg.append(f'<line x1="{bx:.1f}" y1="{by:.1f}" x2="{x:.1f}" y2="{y:.1f}" stroke="#fde68a" stroke-opacity="0.35" stroke-width="1.6"><title>Recent velocity {v:.2f}</title></line>')
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="3.8" fill="#fde68a" filter="url(#pointGlow)"><title>{sp.get("id","").replace("_"," ")}</title></circle>')
    lbl=sp.get("id","").replace("_"," "); svg.append(f'<text x="{x+10:.1f}" y="{y-8:.1f}" fill="#fef3c7" font-size="12">{lbl}</text>')
  rd_pct=int(round(100*float(data.get("rd",0.0))))
  svg.append(f'<rect x="{W-300}" y="24" width="276" height="114" rx="10" fill="#0b1220" opacity="0.66" stroke="#1f2937" stroke-opacity="0.5"/>')
  svg.append(f'<text x="{W-162}" y="50" fill="#cbd5e1" font-size="14" text-anchor="middle">Redundancy Debt (axis dents)</text>')
  svg.append(f'<text x="{W-162}" y="74" fill="#fca5a5" font-size="18" text-anchor="middle">{rd_pct}%</text>')
  ts=data.get("timestamp",""); svg.append(f'<text x="{W-162}" y="{98}" fill="#94a3b8" font-size="11" text-anchor="middle">Last updated: {ts}</text>')
  svg.append(f'<a href="https://github.com/rickballard/CoCivium/blob/main/admin/metrics/metrics.json"><text x="{W-162}" y="{114}" fill="#93c5fd" font-size="11" text-anchor="middle">View data JSON</text></a>')
  bx,by,bw,bh=24,H-280,620,256
  svg.append(f'<rect x="{bx}" y="{by}" width="{bw}" height="{bh}" rx="14" fill="#0b1220" opacity="0.66" stroke="#1f2937" stroke-opacity="0.5"/>')
  svg.append(txt("What is this map?",bx+18,by+30,size=16,color="#e2e8f0"))
  lines=["A living radar of CoCivium repo health across 8 axes (0–1).","Rings = evolution stages 1–9; dashed ring hints at ∞ (beyond roadmap).","Polygon = current progress; farther out = healthier. Values shown as %.","Starpoints = key concepts/files; trails = recent velocity.","Edge dents = Redundancy Debt per axis (duplicates/conflicts).","Data source: admin/metrics/metrics.json (updated nightly via GitHub Action)."]
  for i,t in enumerate(lines,1): svg.append(txt("• "+t,bx+18,by+30+20*i,size=12,color="#cbd5e1"))
  lw,lh=560,256; lx,ly=W-lw-24,H-lh-24
  svg.append(f'<rect x="{lx}" y="{ly}" width="{lw}" height="{lh}" rx="14" fill="#0b1220" opacity="0.66" stroke="#1f2937" stroke-opacity="0.5"/>')
  svg.append(txt("Axes & references",lx+18,ly+30,size=16,color="#e2e8f0"))
  y=ly+54
  for key,_deg,label in AXES:
    svg.append(txt(f"{label}:",lx+18,y,size=13,color="#e5e7eb")); svg.append(txt(DESC.get(key,""),lx+150,y,size=12,color="#cbd5e1")); y+=20
  sy=y+6; svg.append(f'<line x1="{lx+18}" y1="{sy}" x2="{lx+78}" y2="{sy}" stroke="#fde68a" stroke-width="1.6"/>')
  svg.append(f'<circle cx="{lx+78}" cy="{sy}" r="3.6" fill="#fde68a" filter="url(#pointGlow)"/>'); svg.append(txt("Starpoint + velocity trail",lx+98,sy+4,size=12,color="#cbd5e1"))
  sy+=22; svg.append(f'<path d="M{lx+18},{sy} Q{lx+50},{sy-16} {lx+82},{sy}" stroke="#93c5fd" stroke-opacity="0.6" stroke-width="1.2" fill="none"/>')
  svg.append(txt("Fungal filament (concept link)",lx+98,sy+4,size=12,color="#cbd5e1"))
  svg.append(f'<text x="{cx}" y="{34}" fill="#e2e8f0" font-size="20" text-anchor="middle">CoCivium Progress Map — v1.3</text>')
  svg.append('</svg>')
  OUT.parent.mkdir(parents=True,exist_ok=True); OUT.write_text("\n".join(svg),encoding="utf-8")
if __name__=="__main__": main()
