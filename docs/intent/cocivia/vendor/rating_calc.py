# vendor/rating_calc.py
import csv, sys, datetime
bad = 0
total_rows = 0
with open('docs/intent/cocivia/vendor/VENDOR_RATINGS.csv', newline='', encoding='utf-8') as f:
    rows = list(csv.DictReader(f))
    total_rows = len(rows)
    for i, r in enumerate(rows, 2):
        try:
            scores = [float(r[k]) for k in ['SafetyEvidence','Provenance','DataControls','WorkerUplift','PolicyInterop','DisclosureQuality'] if r[k].strip()!='']
            if scores:
                t = sum(scores)
                if r.get('Total','').strip() and abs(float(r['Total']) - t) > 0.001:
                    print(f"Row {i}: Total mismatch (expected {t}, got {r['Total']})"); bad = 1
                if not r.get('JustificationLinks','').strip():
                    print(f"Row {i}: Missing JustificationLinks for non-empty scores"); bad = 1
                if not r.get('FreshnessUTC','').strip():
                    print(f"Row {i}: Missing FreshnessUTC"); bad = 1
        except Exception as e:
            print(f"Row {i}: Error parsing scores -> {e}"); bad = 1
print(f"Checked {total_rows} rows.")
sys.exit(bad)
