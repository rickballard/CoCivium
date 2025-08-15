Set-StrictMode -Version Latest

function Get-CoBusLast {
  param([int]$Last = 10)
  Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
  $HS   = 'https://matrix-client.matrix.org'
  $User = '@rick_ball:matrix.org'
  $Room = '!onAbUAZZGsiexyPpza:matrix.org'

  $pw = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
          [Runtime.InteropServices.Marshal]::SecureStringToBSTR(
            (Read-Host 'Matrix password' -AsSecureString)))
  $login = Invoke-RestMethod -Method Post -Uri "$HS/_matrix/client/v3/login" -ContentType 'application/json' `
            -Body (@{ type='m.login.password'; identifier=@{ type='m.id.user'; user=$User }; password=$pw } | ConvertTo-Json)
  $hdr = @{ Authorization = "Bearer $($login.access_token)" }

  # Anchor timeline, then fetch recent messages (single page is enough for our traffic)
  $sync    = Invoke-RestMethod -Headers $hdr -Uri "$HS/_matrix/client/v3/sync?timeout=0"
  $from    = [uri]::EscapeDataString($sync.next_batch)
  $roomEnc = [uri]::EscapeDataString($Room)
  $resp    = Invoke-RestMethod -Headers $hdr -Uri "$HS/_matrix/client/v3/rooms/$roomEnc/messages?dir=b&limit=200&from=$from"

  $events = @($resp.chunk)
  $jsonLines = foreach($e in $events){
    if($e.type -eq 'm.room.message' -and $e.content.msgtype -eq 'm.text'){
      $b = [string]$e.content.body
      if($b.Trim().StartsWith('{')){ $b }
    }
  }
  if(-not $jsonLines){ throw "No JSON-looking lines found yet." }
  $out = ($jsonLines | Select-Object -Last $Last) -join "`n"
  $out
  Set-Clipboard -Value $out
  '--- copied to clipboard ---'
}

function Add-CoBusLine {
  param([Parameter(Mandatory=$true)][string]$Status)
  Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
  $HS   = 'https://matrix-client.matrix.org'
  $User = '@rick_ball:matrix.org'
  $Room = '!onAbUAZZGsiexyPpza:matrix.org'

  $pw = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
          [Runtime.InteropServices.Marshal]::SecureStringToBSTR(
            (Read-Host 'Matrix password' -AsSecureString)))
  $login = Invoke-RestMethod -Method Post -Uri "$HS/_matrix/client/v3/login" -ContentType 'application/json' `
            -Body (@{ type='m.login.password'; identifier=@{ type='m.id.user'; user=$User }; password=$pw } | ConvertTo-Json)
  $hdr = @{ Authorization = "Bearer $($login.access_token)" }

  $ts   = (Get-Date).ToString('o')
  $line = ([ordered]@{
    ts=$ts; author=$User; session='Main'
    status=$Status.Substring(0,[Math]::Min($Status.Length,180)); todos=@()
  } | ConvertTo-Json -Compress)

  $txn     = [string](Get-Date -UFormat %s) + '-bus'
  $roomEnc = [uri]::EscapeDataString($Room)
  Invoke-RestMethod -Method Put -Headers $hdr -ContentType 'application/json' `
    -Uri "$HS/_matrix/client/v3/rooms/$roomEnc/send/m.room.message/$txn" `
    -Body (@{ msgtype='m.text'; body=$line } | ConvertTo-Json) | Out-Null
  '✅ Posted.'
}
