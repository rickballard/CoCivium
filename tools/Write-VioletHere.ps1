param([Parameter(Mandatory)][string]$Message)
$ErrorActionPreference='Stop'
$root = (git -C $PSScriptRoot rev-parse --show-toplevel)
& "$HOME/Documents\GitHub\CoSteward\tools\Write-Violet.ps1" -Message $Message -RepoRoot $root
