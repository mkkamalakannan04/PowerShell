function Get-FreeSpace{
    param([string] $HostName = ($env:AD1HFDSP13T01))

      Get-WmiObject win32_volume -computername $hostname  | `
            #Where-Object {$_.drivetype -eq 3} | `
            Sort-Object name | `
            Format-Table name,@{l="Size(GB)";e={($_.capacity/1gb).ToString("F2")}},`
                              @{l="Free Space(GB)";e={($_.freespace/1gb).ToString("F2")}},`
                              @{l="% Free";e={(($_.Freespace/$_.Capacity)*100).ToString("F2")}}

}