@echo off

set SCRIPT_PATH=%~dp0Remote_IPConfig.ps1

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_PATH%"
pause