<#
Import-Module sqlps
cls
$DBName = Invoke-Sqlcmd -ServerInstance "DELL2015\UG" -query "select top  1 @@servername as servername, name from sys.databases"

foreach ($s in $DBName)
{
$Fileout = "C:\temp\" + $s.name + "-AssessmentReport.csv"
$arglist = @(
'/AssessmentName=T4',
'/AssessmentDatabases="Server={0};Integrated Security=true"',
'/AssessmentTargetPlatform=SqlServerWindows2017',
'/AssessmentEvaluateCompatibilityIssues',
'/AssessmentOverwriteResult',
'/AssessmentResultCsv="{1}"'
) -f $s.servername, $Fileout
#$arglist 
Start-Process -FilePath 'C:\Program Files\Microsoft Data Migration Assistant\DmaCmd.exe' -ArgumentList $arglist -NoNewWindow -RedirectStandardOutput C:\temp\out.txt -RedirectStandardError C:\temp\err.txt
}



#>


cls

[reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.smo")
cls
$InstanceName = "DELL2015\UG"

$Srv = New-Object Microsoft.SqlServer.Management.Smo.Server $InstanceName

#$Srv | Get-Member | ft


foreach ($DB in $Srv.Databases)
{

    Write-Output $Db.name $srv.name  
}



Import-Module sqlps
cls
$DBName = Invoke-Sqlcmd -ServerInstance "DELL2015\UG" -query "select top  2 @@servername as servername, name from sys.databases"

$FilePath = "C:\temp\"
foreach ($s in $DBName)
{
    $File = $FilePath + $S.servername.Replace("\","_") + "_" + $S.name + "_" + (Get-date).ToString("s").Replace(":","") + ".csv"
    Write-Host $File
    GetUpgradeData $S.servername,$S.name,$File
}



Function GetUpgradeData {
    param($servername, $name, $File)

Write-Host $File

#$Fileout = "C:\temp\" + $name + "-AssessmentReport.csv"
$arglist = @('/AssessmentName=T4','/AssessmentDatabases="Server={0};Integrated Security=true"','/AssessmentTargetPlatform=SqlServerWindows2017','/AssessmentEvaluateCompatibilityIssues','/AssessmentOverwriteResult','/AssessmentResultCsv="{1}"') -f $servername, $File
$arglist 
#Start-Process -FilePath 'C:\Program Files\Microsoft Data Migration Assistant\DmaCmd.exe' -ArgumentList $arglist -NoNewWindow -RedirectStandardOutput C:\temp\out.txt -RedirectStandardError C:\temp\err.txt
}




Import-Module sqlps
cls

Function GetUpgradeData {
    param($var1, $var2, $File)

    Write-Host $var2

#$Fileout = "C:\temp\" + $name + "-AssessmentReport.csv"
$arglist = @(
'/AssessmentName=T4',
'/AssessmentDatabases="Server={0};Integrated Security=true"',
'/AssessmentTargetPlatform=SqlServerWindows2017',
'/AssessmentEvaluateCompatibilityIssues',
'/AssessmentOverwriteResult',
'/AssessmentResultCsv="{1}"'
)  -f  $var1[0],$var2
$arglist 
#Start-Process -FilePath 'C:\Program Files\Microsoft Data Migration Assistant\DmaCmd.exe' -ArgumentList $arglist -NoNewWindow -RedirectStandardOutput C:\temp\out.txt -RedirectStandardError C:\temp\err.txt
}


$DBName = Invoke-Sqlcmd -ServerInstance "DELL2015\UG" -query "select top  10 @@servername as servername, name from sys.databases"

$FilePath = "C:\temp\"
foreach ($s in $DBName)
{
    $var1 = $S.servername.ToString()
    $var2=$S.name.ToString()
    $File = $FilePath + $S.servername.Replace("\","_") + "_" + $S.name + "_" + (Get-date).ToString("s").Replace(":","") + ".csv"
    GetUpgradeData "DELL2015\UG","test" ,$File
}


$news="kamdfdafalxxxx"
$arglist = @(
'/AssessmentName=T4',
'/AssessmentDatabases="Server={0};Integrated Security=true"',
'/AssessmentTargetPlatform=SqlServerWindows2017',
'/AssessmentEvaluateCompatibilityIssues',
'/AssessmentOverwriteResult',
'/AssessmentResultCsv="{1}"'
) -f $news,5
$arglist 
