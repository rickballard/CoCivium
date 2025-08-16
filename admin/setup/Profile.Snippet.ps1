# Profile helpers (safely dot-sourced)
function cc-pr(){ gh pr list --state open --limit 20 }
function cc-hub(){ pwsh -File "$PSScriptRoot/../tools/reminders/Run-ReminderHub.ps1" }
function cc-sweep(){ pwsh -File "$PSScriptRoot/../tools/BackChats/Run-BackChatsSweep.ps1" }
