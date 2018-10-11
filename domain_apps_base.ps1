# vi:syntax=ps1
# file=domain_apps_base.ps1
# Description: Base Applications for all domain joined Workstations. Use for
# domain joined PC's NOT for home or private use.

# Author: Rick Russell <sysadmin.rick@gmail.com>

# Enable Debug output
# Set-PSDebug -Trace 1

# --- Make sure we've imported the Boxstarter modules we want ---
Import-Module Boxstarter.Chocolatey
Import-Module Boxstarter.WinConfig
Import-Module Boxstarter.Bootstrapper
Write-BoxstarterMessage "*** Import Boxstarter Modules ***"

# Package installation using Chocolatey

Write-BoxstarterMessage "*** Install or Upgrade Chocolatey and Powershell ***"
cup -y chocolatey
cup -y powershell

refreshenv

Write-BoxstarterMessage "*** Installing Microsoft Applications and Tools ***"

Write-BoxstarterMessage "*** Installing Visual C++ Runtime Environments 2003-2017 ***"
# Microsoft Visual C++ Runtime 2005
cup vcredist2005 -y
# Microsoft Visual C++ Runtime 2008
cup vcredist2008 -y
# Microsoft Visual C++ Runtime 2010
cup vcredist2010 -y
# Microsoft Visual C++ Runtime 2012
cup vcredist2012 -y
# Microsoft Visual C++ Runtime 2013
cup vcredist2013 -y
# Microsoft Visual C++ Runtime 2015
cup vcredist2015 -y
# Microsoft Visual C++ Runtime 2017
cup vcredist140 -y

Write-BoxstarterMessage "*** Installing .Net Framework 4.6.1 ***"
# Microsoft .NET 3.5
#cup dotnet3.5 -y
# Microsoft .NET 4.6.1
cup dotnet4.6.2 -y

Write-BoxstarterMessage "All finished! Your Machine is provisioned with the default set of apps!"
