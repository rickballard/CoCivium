@echo off
setlocal
powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%USERPROFILE%\Documents\GitHub\CoCivium\admin\tools\workbench\Start-Workbench.ps1"
endlocal
exit /b