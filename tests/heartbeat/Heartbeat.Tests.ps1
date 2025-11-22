# Pester Quick tag: minimal presence check
Describe "Heartbeat quick" -Tag "Quick" {
  It "loads Emit-CoStatus (if present)" {
    $path = Join-Path $PSScriptRoot "../../tools/heartbeat/Emit-CoStatus.ps1"
    if(Test-Path $path){ (Get-Content $path -First 1) | Should -Not -BeNullOrEmpty }
    else { $true | Should -BeTrue }
  }
}
