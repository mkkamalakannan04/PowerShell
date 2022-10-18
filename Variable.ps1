cls
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100

$date = get-date -Format g
$Instance = "CNU4249BVK\SQL2008R2"  
$DB = "Mytest"
$OldUser = 'myTest'
$Date = Get-Date -UFormat "%Y%m%d"
$Outfile = 'C:\Kamal\test\' + ($Instance | foreach {$_ -replace "\\", "_"}) + "_" + $OldUser + "_" + (Get-Date -UFormat "%Y%m%d") + '.txt'
$Outfile

$OutList = Invoke-Sqlcmd -InputFile "C:\Kamal\test\UserPermission.sql" -Variable "OldUser='${OldUser}'" -ServerInstance $Instance -Database $DB -MaxCharLength 9999999
write-output $OutList.SQLSTATEMENTS | Out-File -FilePath "C:\Kamal\test\text.txt"


#working
INVOKE-SQLCMD -QUERY "select lob,count(TRGT_APP_CD) FROM [EDM_Audit].[DBO].[OEM_LOB_APPCD] WHERE lob =`$(loginame) group by lob" -Variable "loginame='$($L.LOB)'" -ServerInstance $SQL_SERVER_NAME  -MaxCharLength 9999999
