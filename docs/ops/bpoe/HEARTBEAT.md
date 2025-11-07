# CoBloat Heartbeat

Canonical stall-risk order: **WT → HU → CU → PU**.

Console usage:
```powershell
. .\tools\CoHeartbeat.ps1; & (Join-Path $PWD "tools\CoHeartbeat.ps1") -CU OK -PU OK -HU OK -WT OK
```

Markdown drop (writes `.cobloat_line.md`):
```powershell
. .\tools\CoHeartbeat.ps1; & (Join-Path $PWD "tools\CoHeartbeat.ps1") -CU OK -PU SOFT -HU SOFT -WT OK -Out markdown
Get-Content .cobloat_line.md
```

Badge option (swap emojis with SVG dots):

```
  CoBloat: ![ok](../assets/branding/cobloat/ok.svg) CU  ![soft](../assets/branding/cobloat/soft.svg) PU  ![soft](../assets/branding/cobloat/soft.svg) HU  ![ok](../assets/branding/cobloat/ok.svg) WT
  ```
