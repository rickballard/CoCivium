@echo off
reg import "%~dp0rollback.reg"
echo Rolled back. Restart Chrome.
pause
