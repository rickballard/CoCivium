# IssueOps — CoPing/CoPong & DO sets

**How we run instruction sets in issues/PRs:**

### Title line (outside code)
`DO <i>/<n>, <SetName>; [yyyy-MM-dd HH:mm]; <brief>`  ← local time; no timezone.

### End-of-set demark
Printed by the assistant/tooling after the last step:
```
[yyyy-MM-dd HH:mm] [END-SET] ✅ ----- End of DO Set (<SetName optional>) ----- ✅
```
Three blank lines before and after make it visible when skimming.

### Handshake
- **CoPing `<SetName>`** = proposing a set of steps.
- **CoPong `<SetName> complete`** = all steps done.
- **CoPong `<SetName> k/n`** = only k steps were executed (no chaining beyond k).
- **No CoPong** = assume it was **not executed**.

### CoTip
If the **CoCivium RepoAccelerator/CoAgent** is installed, typing **`???`** at a PS7 prompt and pressing Enter will:
- copy the last 150 lines of the PS7 transcript to your clipboard, and
- print the **End of DO Set** demark banner with spacing in the console.
Paste that into the ChatGPT window to CoPong.

