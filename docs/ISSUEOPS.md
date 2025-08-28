# IssueOps — CoPing/CoPong & DO sets

### Title line (outside code)
`DO <i>/<n>, <SetName>; [yyyy-MM-dd HH:mm]; <brief>`  ← local time; no timezone.

### End-of-set demark
```
[yyyy-MM-dd HH:mm] [END-SET] ✅ ----- End of DO Set (<SetName optional>) ----- ✅
```
Three blank lines before and after make it visible when skimming.

### Handshake
- **CoPing `<SetName>`** = proposing a set.
- **CoPong `<SetName> complete`** = all steps done.
- **CoPong `<SetName> k/n`** = only k steps executed (no chaining beyond k).
- **No CoPong** = assume **not executed**.
- **Manual paste of PS7 output** in chat counts as a CoPong.

### CoTip
If the **RepoAccelerator/CoAgent** is running with CoCivium, typing **`???`** at a PS7 prompt and pressing Enter will:
- copy the last 150 lines of the PS7 transcript to your clipboard, and
- print the **End of DO Set** demark banner (with spacing).
Paste that into the ChatGPT window to CoPong.

### Planned waits
Use the yellow planned-wait banner instead of silent sleeps.

### Integration Advisory — Product Shutdown
- Tools enable `???` **per session** and must disable it on shutdown (`Disable-CoPongTrigger`).
- Session gates (`REPOACCEL_ACTIVE` / `COAGENT_ACTIVE`) are cleared on exit; no profile writes.
- CoAgent enables only with CoCivium sentinel or `.coagent-allow-copong`.

**After you paste a CoPong in chat, the assistant will reply with `ACK CoPong - <SetName or (none)> @ <local time>` and the next action.**

**After you paste a CoPong in chat, the assistant will reply with `ACK CoPong — Set=<name|none> @ <local time>` and the next action.**
