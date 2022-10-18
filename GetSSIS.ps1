#http://www.databasejournal.com/features/mssql/ssis-2012-using-powershell-to-configure-package-execution-parameters.html
cls
$loadStatus = [Reflection.Assembly]::Load("Microsoft"+".SqlServer.Management.IntegrationServices" + ", Version=11.0.0.0, Culture=neutral" + ", PublicKeyToken=89845dcd8080cc91")   
$ISNamespace = "Microsoft.SqlServer.Management.IntegrationServices" 

$constr = "Data Source=CNU4249BVK\SQL2012;Initial Catalog=master;Integrated Security=SSPI;"

$con = New-Object System.Data.SqlClient.SqlConnection $constr      

$ssis = New-Object $ISNamespace".IntegrationServices" $con   

$ssis.catalogs


$sqlInstance = "CNU4249BVK\SQL2012"
$sqlConnectionString = "Data Source=$sqlInstance;Initial Catalog=master;Integrated Security=SSPI"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString

$ssisServer = New-Object Microsoft.SqlServer.Management.IntegrationServices.IntegrationServices $sqlConnection
$ssisCatalog = $ssisServer.Catalogs["SSISDB"]

$ssisFolderName = "Sharepoint"
$ssisFolder = $ssisCatalog.Folders.Item($ssisFolderName)

Write-host $ssisFolder

$ssisProjectName = "Project1"
$ssisProject = $ssisFolder.Projects.Item($ssisProjectName)

$ssisPackageName = "Package.dtsx"
$ssisPackage = $ssisProject.Packages.Item($ssisPackageName)

# --------------------------------------------------------------------------------------------------------

# Download all SSIS package

add-pssnapin sqlserverprovidersnapin100 
add-pssnapin sqlservercmdletsnapin100 
cls 
 
$Packages =  Invoke-Sqlcmd  -Query "WITH cte AS (
            SELECT    cast(foldername as varchar(max)) as folderpath, folderid
            FROM    msdb..sysssispackagefolders
            WHERE    parentfolderid = '00000000-0000-0000-0000-000000000000'
            UNION    ALL
            SELECT    cast(c.folderpath + '\' + f.foldername  as varchar(max)), f.folderid
            FROM    msdb..sysssispackagefolders f
            INNER    JOIN cte c        ON    c.folderid = f.parentfolderid
        )
        SELECT    c.folderpath,p.name,CAST(CAST(packagedata AS VARBINARY(MAX)) AS VARCHAR(MAX)) as pkg
        FROM    cte c
        INNER    JOIN msdb..sysssispackages p    ON    c.folderid = p.folderid
        WHERE    c.folderpath  LIKE 'CLAIMS\TPA_Subledger%'" -ServerInstance "AD1HFDISCM007\CLAIMS" -MaxCharLength 10000000 
 
 
 
Foreach ($pkg in $Packages)
{
    $pkgName = $Pkg.name
    $folderPath = $Pkg.folderpath
    $fullfolderPath = "C:\Kamal\test\ssis\$folderPath\"
    if(!(test-path -path $fullfolderPath))
    {
        mkdir $fullfolderPath | Out-Null
    }
    $pkg.pkg | Out-File -Force -encoding ascii -FilePath "$fullfolderPath\$pkgName.dtsx"  
