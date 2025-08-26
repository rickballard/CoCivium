@echo off
reg import "%~dp0apply.reg"
echo Applied. Restart Chrome.
pause
