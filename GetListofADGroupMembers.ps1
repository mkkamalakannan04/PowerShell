Get-ADGroupMember "Manage-SQLServers" -Recursive | Format-Table

Get-ADGroupMember Manage-SQLServers -Recursive| Format-Table -Property name, objectclass


$Members = @()

$domains = (Get-ADForest).domains

foreach ($domain in $domains) 
    {
        $Groups = Get-ADGroupMember -Identity "Manage-SQLServers" -Recursive  -server $domain -ErrorAction Ignore
        $Members += $Groups 
    }

$Members | Select-Object name,objectclass -Unique | Format-Table


cls
$input = Read-Host "Enter GroupName"

$domains = (Get-ADForest).domains

foreach ($domain in $domains) 
    {
        #write-host $domain
        try
        {
            $Groups = Get-ADGroupMember -Identity $input -Recursive -server $domain -ErrorAction SilentlyContinue
        }
        catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
        {
            Write-Warning “AD computer object not found”
        }
            $Members += $Groups 
    }

$Members | Select-Object name,objectclass -Unique | Format-Table   
