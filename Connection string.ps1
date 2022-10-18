[Reflection.Assembly]::LoadWithPartialName(“Microsoft.AnalysisServices”)

###################  SSAS #########################################################################################

$ServerName = "AD1SQLDC40ASHRH\ASHAREDH"
write-host "Connecting to SSAS Server: " $ServerName
    $server = New-Object Microsoft.AnalysisServices.Server
    $server.connect($ServerName)

########################### DB ########################################################################################

     $Instance = 'AD1HFDDBST2A1,50001'
     $ConStr = "Data Source=$Instance;Integrated Security=true;Initial Catalog=master;"
     $SqlCon = New-Object("Data.sqlclient.sqlconnection")$ConStr
     $SqlCon.open()

###################################### DB #############################################################################

$SQLServer = "YourServerName" #use Server\Instance for named SQL instances!
$SQLDBName = "YourDBName"
$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $SQLServer; Database = $SQLDBName; Integrated Security = True;" 
$SqlCmd = New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText = 'StoredProcName'
$SqlCmd.Connection = $SqlConnection 
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $SqlCmd 
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet) 
$SqlConnection.Close() 

############################################# DB #####################################################################

[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null 
$Instance = "WAD1DBLHP1001\SHARED"
$srv = new-object Microsoft.SqlServer.Management.Smo.Server $Instance
$srv.Databases

##################################################################################################################

#To get all property

$srv.JobServer.Jobs | Select-Object -Property * | Out-GridView 

##################################################################################################################