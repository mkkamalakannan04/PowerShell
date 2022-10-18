function GetFreeSpace{
    param([string] $HostName = ($env:COMPUTERNAME))

      Get-WmiObject win32_volume -computername $hostname  | `
            #Where-Object {$_.drivetype -eq 3} | `
            Sort-Object name | `
            Format-Table Systemname,name,Label,@{l="Size(GB)";e={($_.capacity/1gb).ToString("F2")}},`
                              @{l="Free Space(GB)";e={($_.freespace/1gb).ToString("F2")}},`
                              @{l="% Free";e={(($_.Freespace/$_.Capacity)*100).ToString("F2")}}

}