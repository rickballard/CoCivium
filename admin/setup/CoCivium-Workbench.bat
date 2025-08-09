@echo off
setlocal

rem --- Paths (adjust if your repos live elsewhere)
set "COCIVIUM_DIR=%USERPROFILE%\Documents\GitHub\CoCivium"
set "GIBINDEX_DIR=%USERPROFILE%\Documents\GitHub\GIBindex"

rem --- Chrome detection
set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not exist "%CHROME%" set "CHROME=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if not exist "%CHROME%" set "CHROME=chrome"

rem --- Use a dedicated Chrome profile (create it once and name it CoCivium)
set "PROFILE=--profile-directory=CoCivium"

rem --- Tabs to open
set URLS=https://github.com/rickballard/CoCivium ^
 https://github.com/rickballard/CoCivium/actions ^
 https://github.com/rickballard/GIBindex ^
 https://github.com/rickballard/GIBindex/actions ^
 https://github.com/notifications ^
 https://chatgpt.com/

start "" "%CHROME%" %PROFILE% %URLS%

rem --- Open two Git Bash windows at repo roots
set "GITBASH=%ProgramFiles%\Git\git-bash.exe"
if not exist "%GITBASH%" set "GITBASH=%ProgramFiles(x86)%\Git\git-bash.exe"
start "" "%GITBASH%" --cd="%COCIVIUM_DIR%"
start "" "%GITBASH%" --cd="%GIBINDEX_DIR%"

endlocal
