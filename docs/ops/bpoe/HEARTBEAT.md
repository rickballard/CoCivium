# CoBloat Heartbeat

Canonical stall-risk order: **WT → HU → CU → PU**.

Console usage:
```powershell
# Canonical emitter (CoCache)
$CC = Join-Path $HOME "Documents\GitHub\CoCache"
. (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1")
& (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1") -Source dialogue -CU OK -PU OK -HU OK -WT OK
```

Markdown drop (writes `.cobloat_line.md`):
```powershell
# Canonical emitter (CoCache)
$CC = Join-Path $HOME "Documents\GitHub\CoCache"
. (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1")
& (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1") -Source dialogue -CU OK -PU OK -HU OK -WT OK
```

Badge option (swap emojis with SVG dots):

```
  CoBloat: ![ok](../assets/branding/cobloat/ok.svg) CU  ![soft](../assets/branding/cobloat/soft.svg) PU  ![soft](../assets/branding/cobloat/soft.svg) HU  ![ok](../assets/branding/cobloat/ok.svg) WT
  ```
