#http://sqlblog.com/blogs/jamie_thomson/archive/2011/02/02/export-all-ssis-packages-from-msdb-using-powershell.aspx

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
}