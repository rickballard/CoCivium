# scripts/CoVibe.AbsLink.ps1
function CoAbsLink {
  [CmdletBinding()] param(
    [Parameter(Mandatory)][string],
    [switch], [switch]
  )
  Set-StrictMode -Version Latest
   =  -replace '\\','/'
  C:\Users\Chris\Documents\GitHub\CoCivium = git rev-parse --show-toplevel
  if(-not C:\Users\Chris\Documents\GitHub\CoCivium){ throw 'Not a git repo' }
   = Join-Path C:\Users\Chris\Documents\GitHub\CoCivium 
  admin/outreach/KickOpenAI/Posts/being_noname_insert.md  = (Resolve-Path -LiteralPath ).Path.Substring(C:\Users\Chris\Documents\GitHub\CoCivium.Length).TrimStart('\','/').Replace('\','/')
   = git remote get-url origin
  if( -notmatch 'github\.com[:/](.+?)/(.+?)(\.git)?$'){ throw 'Non-GitHub remote' }
  rickballard=System.Collections.Hashtable[1]; rickballard/CoCivium=System.Collections.Hashtable[2]
   = if(){ git rev-parse HEAD } else { git rev-parse --abbrev-ref HEAD }
   = "https://github.com/rickballard/rickballard/CoCivium/blob//admin/outreach/KickOpenAI/Posts/being_noname_insert.md"
  if(){ Set-Clipboard -Value  }
  
}
