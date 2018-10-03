# vi:syntax=ps1
# file=win_update.ps1
# Description: Windows 10 Provisioning using Boxstarter
# Author: Rick Russell <rrussell@lmud.org>

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
Write-BoxstarterMessage "*** Making sure we're in an elevated environmentMaking sure we're in an elevated environment... ***"
$cwd = "$(Get-Location)"
. $_boxstarter_path
cd "$cwd"

# --- Make sure we've imported the Boxstarter modules we want ---
Import-Module Boxstarter.Chocolatey
Import-Module Boxstarter.WinConfig
Import-Module Boxstarter.Bootstrapper
Write-BoxstarterMessage "*** Imported Boxstarter Modules ***"

# Kick off Windows Updates
Enable-MicrosoftUpdate
Write-BoxstarterMessage "Kicking off Windows Updates"
Install-WindowsUpdate -acceptEula
