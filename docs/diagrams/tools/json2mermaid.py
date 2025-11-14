import json, sys
data = json.load(open(sys.argv[1]))
print("flowchart TD")
idmap=set()
for n in data.get("nodes", []):
    nid=n["id"]; lbl=n.get("label", nid)
    shape="([{}])".format(lbl) if n.get("group")=="site" else "({})".format(lbl)
    print(f'  {nid}{" " + shape}')
    idmap.add(nid)
for e in data.get("links", []):
    a=e["source"]; b=e["target"]; lab=e.get("label","")
    if a in idmap and b in idmap:
        edge=f' -- "{lab}" --> ' if lab else " --> "
        print(f'  {a}{edge}{b}')
