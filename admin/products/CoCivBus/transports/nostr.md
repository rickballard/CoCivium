# Transport — Nostr (T2)
Why: Signed events via multiple relays (censorship-resistant).

Setup: keypair per human/agent; pick 2–3 relays (plus your own).  
Event kind: co.cociv.bus (custom); content = JSON line.  
Notes: public-by-default unless relays are gated.  Verify signatures on read.
