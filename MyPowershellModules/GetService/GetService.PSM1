function GetService {
    param([string] $HostName = ($env:COMPUTERNAME), [string]$AsLike = 'sql')

    gwmi -Class win32_service -computername $hostname | select Name,DisplayName,StartMode,State,ProcessId,StartName | 
            Where-Object {$_.Displayname -match $AsLike} | 
            Sort-Object Name | 
            Format-Table -AutoSize 

}