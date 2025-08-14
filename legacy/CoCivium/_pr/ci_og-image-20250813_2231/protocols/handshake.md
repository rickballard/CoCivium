HELLO(sender_did, envelope_pubkey, nonce)
← CHALLENGE(nonce2, task_ref, ttl)
ATTEST(sig(nonce||nonce2||task), vc_list[])
← ADMIT(session_token, expiry)

Failure paths: rate-limit, vc-missing, liveness-failed, policy-violation.
