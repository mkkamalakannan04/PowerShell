#Create own profile to load files and modules

#http://www.gsx.com/blog/bid/81096/Enhance-your-PowerShell-experience-by-automatically-loading-scripts



$profile

test-path $profile

new-item -path $profile -itemtype file -force
#now we can customize our profile to load what we need on startup...something lile below in our profile file (Microsoft.PowerShellISE_profile.ps1)

Get-Module -ListAvailable | Import-Module

Write-Host "Custom PowerShell Environment Loaded" 