# vi:syntax=ps1
# file=lock-down.ps1
# Description: Windows 10 Provisioning using Boxstarter
# Author: Rick Russell <rrussell@lmud.org>

# Needs to be run as a pre-req prior to provisioning

# Enable Debug output
#Set-PSDebug -Trace 1

# Run Boxstarter Shell as an Administrator
$cwd = "$(Get-Location)"
. $_boxstarter_path
cd "$cwd"

# --- Make sure we've imported the Boxstarter modules we want ---
Import-Module Boxstarter.Chocolatey
Import-Module Boxstarter.WinConfig
Import-Module Boxstarter.Bootstrapper
Write-BoxstarterMessage "*** Imported Boxstarter Modules ***"

#--- Restore Temporary Settings ---
Write-BoxstarterMessage "re-Enable UAC"
Enable-UAC
Write-BoxstarterMessage "re-Enable Windows Update"
Enable-MicrosoftUpdate

# Make sure we prevent users on other computers from running commands on the local computer
Write-BoxstarterMessage "Disable PSRemoting (external commands)"
Disable-PSRemoting -force

# From an Administrator PowerShell, if Get-ExecutionPolicy returns Restricted,
# Set policy to unrestricted:
$_exec_policy = $(Get-ExecutionPolicy)

if ("$_exec_policy" -eq ("Unrestricted" -or "Bypass") {
    Write-Output "Locking Execution Policy to Restricted..."
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted -Force
}
else {
    Write-Output "Execution Policy already set to Restricted"
}

Write-BoxstarterMessage "Machine is now locked down."
