@ECHO OFF

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "..\default_provision.ps1" -preset "restore_all.preset"
