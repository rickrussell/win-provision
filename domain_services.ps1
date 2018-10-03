# vi:syntax=ps1
# file=domain_services.ps1
# Description: Windows 10 Provisioning using Boxstarter
# Author: Rick Russell <rrussell@lmud.org>

# Enable Debug output
# Set-PSDebug -Trace 1

# --- Make sure we've imported the Boxstarter modules we want ---
Import-Module Boxstarter.Chocolatey
Import-Module Boxstarter.WinConfig
Import-Module Boxstarter.Bootstrapper
Write-BoxstarterMessage "*** Imported Boxstarter Modules ***"

# --- Services Settings ---
Write-BoxstarterMessage "*** Enabling and Disabling services for Domain use. ***"
# There are some services you simply don't need. Look in Services.msc.

# Not pulling from shares?  You should not expose shares...die LAN Man!
Write-BoxstarterMessage "*** Enabling LanmanServer ***"
Set-service -Name LanmanServer -StartupType Automatic

# Enable print spooler
Write-BoxstarterMessage "*** Enabling Print Spooler ***"
Set-service -Name Spooler -StartupType Automatic

# Tablet input: pssh nobody use tablet input. its silly.just write right in onenote
Write-BoxstarterMessage "*** Disable TabletInputService (Not a tablet) ***"
Set-service -Name TabletInputService -StartupType Disabled

# Telephony API is tell-a-phony
Write-BoxstarterMessage "*** Disable TapiSrv (Telephony API is tell-a-phony)  ***"
Set-service -Name TapiSrv -StartupType Disabled

#geolocation service : u can't find me.
Write-BoxstarterMessage "*** Disable lfcvc (Where's Waldo?) ***"
Set-service -Name lfsvc -StartupType Disabled

# ain't no homegroup here, homie.
Write-BoxstarterMessage "*** Disable HomeGroupProvider  ***"
Set-service -Name HomeGroupProvider -StartupType Disable 

# Apparently we need this enabled or we can't login.
Write-BoxstarterMessage "*** Enable CertPropsvc (Don't allow propagation to local cache) ***"
Set-service -Name CertPropsvc -StartupType Automatic

# links from NTFS file shares across the network
Write-BoxstarterMessage "*** Enable TrkWks ***"
Set-service -Name TrkWks -StartupType Automatic

# we don't use iscsi on workstations & laptops
Write-BoxstarterMessage "*** Disable iscsi if un-needed ***"
Set-service -Name MSISCSI -StartupType Disable

# I still use snmp in some instances.  In the case of workstations, not so much. -RRR
Write-BoxstarterMessage "*** Disable snmp for workstations ***"
Set-service -Name SNMPTRAP -StartupType Disable

# who needs branchcache?
Write-BoxstarterMessage "*** Disable PeerDistSvc (Don't need brancache) ***"
Set-service -Name PeerDistSvc -StartupType Disable

# Peer to Peer discovery svcs...Begone!
Write-BoxstarterMessage "*** Disable peer to peer services (Don't need this inside our domain) ***"
Set-service -Name PNRPAutoReg -StartupType Disabled
Set-service -Name p2pimsvc -StartupType Disabled
Set-service -Name p2psvc -StartupType Disabled
Set-service -Name PNRPsvc -StartupType Disabled

# netbios over tcp/ip. apparently we need this for domain networks.
Write-BoxstarterMessage "*** Enable lmhosts ***"
Set-service -Name lmhosts -StartupType Automatic

# this is like plug & play only for network devices.
Write-BoxstarterMessage "*** Enable SSDPSRV ***"
Set-service -Name SSDPSRV -StartupType Automatic

# Discovery Resource Publication service
# Windows service that publishes this computer and resources attached to this computer so they can be discovered over the network.
Write-BoxstarterMessage "*** Enable FDResPub ***"
Set-service -Name FDResPub -StartupType Automatic

#"Function Discovery host provides a uniform programmatic interface for enumerating system resources" - NO THX.
Write-BoxstarterMessage "*** Enable fdPHost (Function Discovery) ***"
Set-service -Name fdPHost -StartupType Automatic

#optimize the startup cache...i think. on SSD i don't think it really matters.
Write-BoxstarterMessage "*** Enable Startup Cache ***"
set-service SysMain -StartupType Automatic

# You can override your Pictures and Documents & Library folders here to use OneNote
# this assumes you set up onedrive.
# LIBRARIES
# Move-LibraryDirectory -libraryName "Personal" -newPath $ENV:OneDrive\Documents
# Move-LibraryDirectory -libraryName "My Pictures" -newPath $ENV:OneDrive\Pictures
# Move-LibraryDirectory -libraryName "My Video" -newPath $ENV:OneDrive\Videos
# Move-LibraryDirectory -libraryName "My Music" -newPath $ENV:OneDrive\Music

Write-BoxstarterMessage "*** Refreshing Local Environment ***"
refreshenv

Write-BoxstarterMessage "*** Set Windows Explorer Options ***"
Set-WindowsExplorerOptions `
    -EnableShowHiddenFilesFoldersDrives `
    -EnableShowProtectedOSFiles `
    -EnableShowFileExtensions `
    -EnableShowFullPathInTitleBar `
    -DisableOpenFileExplorerToQuickAccess `
    -DisableShowRecentFilesInQuickAccess `
    -DisableShowFrequentFoldersInQuickAccess

# We do this in domain_provision.ps1 now
# # Large taskbar
 Write-BoxstarterMessage "*** Enable Taskbar Options ***"
Set-TaskbarOptions -Size Large -Dock Bottom -Combine Full -AlwaysShowIconsOn

#--- Windows Subsystems/Features ---
# these are also available for scripting directly on windows and installing natively via Enable-WindowsOptionalFeature.
# if you wanna know what's available, try this:
# Get-WindowsOptionalFeature  -Online | sort @{Expression = "State"; Descending = $True}, @{Expression = "FeatureName"; Descending = $False}| Format-Table -GroupBy State
