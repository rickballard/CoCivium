# CoBloat Heartbeat

Canonical stall-risk order: **WT → HU → CU → PU**.

Console usage:
``````powershell
$CC = Join-Path $HOME "Documents\GitHub\CoCache"
. (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1")
# Example: slight ER decline; ERM needs attention
& (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1") `
  -Source dialogue -CU OK -PU OK -HU OK -WT SOFT `
  -ER declining -ERDelta "-3%/15m" `
  -SIP OK -ERM SOFT -NSQ OK -TTC OK
# Canonical emitter (CoCache)
$CC = Join-Path $HOME "Documents\GitHub\CoCache"
. (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1")
& (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1") -Source dialogue -CU OK -PU OK -HU OK -WT OK
```

Markdown drop (writes `.cobloat_line.md`):
``````powershell
$CC = Join-Path $HOME "Documents\GitHub\CoCache"
. (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1")
# Example: slight ER decline; ERM needs attention
& (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1") `
  -Source dialogue -CU OK -PU OK -HU OK -WT SOFT `
  -ER declining -ERDelta "-3%/15m" `
  -SIP OK -ERM SOFT -NSQ OK -TTC OK
# Canonical emitter (CoCache)
$CC = Join-Path $HOME "Documents\GitHub\CoCache"
. (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1")
& (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1") -Source dialogue -CU OK -PU OK -HU OK -WT OK
```

Badge option (swap emojis with SVG dots):

```
  CoBloat: ![ok](../assets/branding/cobloat/ok.svg) CU  ![soft](../assets/branding/cobloat/soft.svg) PU  ![soft](../assets/branding/cobloat/soft.svg) HU  ![ok](../assets/branding/cobloat/ok.svg) WT
  ```

## Placement
- Emit the status line **at the end of each set/cycle** (retroactive punctuation).

### PS7 snippet
```powershell
$CC = Join-Path $HOME "Documents\GitHub\CoCache"
. (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1")
# End-of-set punctuation:
& (Join-Path $CC "tools\heartbeat\Emit-CoBloat.ps1") -Source dialogue -SpellOut -Violet -CU OK -PU OK -HU OK -WT OK -ER steady
```

