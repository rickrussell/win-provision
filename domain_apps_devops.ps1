# vi:syntax=ps1
# file=domain_apps_devops.ps1
# Description: Use for domain joined PC's NOT for home or private use.
# Author: Rick Russell <sysadmin.rick@gmail.com>

# --- Make sure we've imported the Boxstarter modules we want ---
Import-Module Boxstarter.Chocolatey
Import-Module Boxstarter.WinConfig
Import-Module Boxstarter.Bootsrapper
Write-BoxstarterMessage "*** Imported Boxstarter Modules ***"

# Package installation using Chocolatey

# For Hyper-V VM's:
cup -y Microsoft-Hyper-V-All -source windowsFeatures
cup -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#adobereader, java 8 runtime, 7zip, chrome, firefox etc
Write-BoxstarterMessage "*** Installing basic applications ***"
cup -y 7zip.install
cup -y sumatrapdf
cup -y firefox
cup -y googlechrome

refreshenv

Write-BoxstarterMessage "*** Installing DevOps Tools ***"

# Local developement
cup -y atom
cup -y curl
cup -y github.install
cup -y git-credential-manager-for-windows
cup -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal"' -y
cup -y poshgit
cup -y powershellhere

# Languages
# cup -y golang
# cup -y nodejs
# cup -y Python
# cup -y ruby

# containerization
## docker
cup -y docker
cup -y docker-for-windows
cup -y docker-compose
cup -y docker-kitematic
## vagrant
cup -y virtualbox
cup -y vagrant
## kubernetes
# cup -y kubernetes-cli
# cup -y minikube

# Other tools
cup -y etcher
cup -y kitty
cup -y openssh #-params '"/SSHServerFeature"'
cup -y wireshark
cup -y winscp.install

Write-BoxstarterMessage "***Installing Extra Fonts***"
#---- Fonts ----
cup -y inconsolata
cup -y dejavufonts
cup -y sourcecodepro
cup -y robotofonts
cup -y droidfonts

refreshenv

# Schedule updates to applications with chocolatey
Write-BoxstarterMessage "** Scheduling Daily Task to update Chocolatey Packages **"
schtasks.exe /create /s "localhost" /ru "System" /tn "Update Chocolatey packages" /tr "%ChocolateyInstall%\bin\cup all" /sc DAILY /st 06:00 /F
Write-BoxstarterMessage "** Set update schedule for applications installed with Chocolatey **"
Write-BoxstarterMessage "** All finished! Your Machine is provisioned with the DevBox applications! **"

# Reboot if necessary
if (Test-PendingReboot) {
  Write-BoxstarterMessage "** Some applications require the machine be rebooted... **"
  Invoke-Reboot
}
