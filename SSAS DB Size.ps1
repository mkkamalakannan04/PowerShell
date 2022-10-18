cls
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100
$loadInfo = [Reflection.Assembly]::LoadWithPartialName(“Microsoft.AnalysisServices”)
cls

$ServerName = "ad1hfdatst9c1\msbi"


write-host "Connecting to SSAS Server: " $ServerName
    $server = New-Object Microsoft.AnalysisServices.Server
    $server.connect($ServerName)
    write-host $server.Databases
    if ($server.name -eq $null) 
    {
        Write-Output (“Server ‘{0}’ not found” -f $ServerName)
        }

        $sum=0
    foreach ($d in $server.Databases)
    {
        #Write-Output ( “Database: {0}; Status: {1}; Size: {2}MB” -f $d.Name, $d.State, ($d.EstimatedSize/1024/1024).ToString())
        Write-host $ServerName.srvinst, $d.Name, $d.State, $d.EstimatedSize
         

        $sum=$sum+$d.EstimatedSize/1024/1024

       }

    $SizeGB=$Sum/1024

    write-host 'Sum of Database = ‘$sum ‘ MB’
    Write-host ‘Total Size of Cube Databases =’ $SizeGB ‘ GB’ 
