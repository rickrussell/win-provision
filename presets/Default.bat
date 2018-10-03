REM Description: Boxstarter Script
REM Author: Rick Russell <rrussell@lmud.org>
REM Last Updated: 2018-05-23
REM default.bat
REM Use for non domain joined PC's for home or private use.

@ECHO OFF

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "..\default_provision.ps1" -preset "Default.preset"
