# Minimal Python Client (sketch)

This is a sketch to guide implementation.  Use a maintained Matrix SDK.  Required behaviors:
1) Generate or import a DID and an Ed25519 key.  
2) Perform handshake (HELLO/CHALLENGE/ATTEST/ADMIT).  
3) Send/receive signed envelope messages to Matrix rooms.  
4) Maintain liveness pings and rotate session tokens.

Security notes: store keys securely.  Log Merkle roots and hashes, not raw sensitive content.
