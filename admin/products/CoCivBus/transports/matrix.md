# Transport — Matrix (T1 default)
Why: Federated, E2EE, self-hostable.

Setup:
1) Choose a homeserver (Synapse/Conduit or provider).  
2) Create a private invite-only room per bus; enable E2EE; note room ID.  
3) Create a low-scope bot/user for CoCivBus clients; store token locally.

Message: one JSON line per entry (<2 KB).  No secrets.  
Access: invite-only.  Retention: per-room; export periodically.
