# vi:syntax=ps1
# file=pre-reqs.ps1
# Description: Windows 10 Initial Provisioning script using Boxstarter
# Author: Rick Russell <rrussell@lmud.org>

# Needs to be run as a pre-req prior to provisioning any machine @ LMUD

# This script uses BoxStarter. Learn more: http://boxstarter.org/Learn/WebLauncher
# If BoxStarter is not installed, this script will install it.

# Enable Debug output
# Set-PSDebug -Trace 1

# From an Administrator PowerShell, if Get-ExecutionPolicy returns Restricted,
# Set policy to unrestricted:
$_exec_policy = $(Get-ExecutionPolicy)

if ("$_exec_policy" -eq "Restricted") {
    Write-Output "Unlocking Execution Policy to UnRestricted..."
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy UnRestricted -Force
}
else {
    Write-Output "Execution Policy already set to UnRestricted"
}

# Check if BoxStarter is installed, if not, install
$_boxstarter_path = 'C:\ProgramData\Boxstarter\BoxstarterShell.ps1'
if (!(Test-Path $_boxstarter_path)) {
    . { iwr -useb http://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force
}

# Run Boxstarter Shell as an Administrator
$cwd = "$(Get-Location)"
. $_boxstarter_path
cd "$cwd"

# --- Make sure we've imported the Boxstarter modules we want ---
Import-Module Boxstarter.Chocolatey
Import-Module Boxstarter.WinConfig
Import-Module Boxstarter.Bootstrapper
Write-BoxstarterMessage "*** Imported Boxstarter Modules ***"

# Remember to run lock-down.ps1 after any and all other scripts to renable UAC
# and other items below for security purposes

# Disable UAC and Windows Update
Disable-UAC
Disable-MicrosoftUpdate

# Enable users on other computers to run commands on this machine temporarily
# this is Disabled at bottom of script.
Enable-PSRemoting -Force
Enable-RemoteDesktop

Write-BoxstarterMessage "*** Machine unlocked and ready for provisioning! ***"
Write-BoxstarterMessage "*** Please remember to run lock-down.ps1 last to undo and lock down machine! ***"
