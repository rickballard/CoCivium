import json, sys
d = json.load(open(sys.argv[1]))
print("direction: right")
for n in d.get("nodes", []):
    nid=n["id"]; lbl=n.get("label", nid)
    print(f'{nid}: "{lbl}"')
for e in d.get("links", []):
    lab=e.get("label","")
    arrow = f' -> "{lab}" ' if lab else " -> "
    print(f'{e["source"]}{arrow}{e["target"]}')
