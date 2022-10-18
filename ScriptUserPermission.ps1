cls
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100

$SList = Import-Csv -Path "C:\Kamal\COG50145\Audit\CHG0129422\localdisablesv2.csv"
$ScriptPath = "C:\Kamal\COG50145\Audit\CHG0129422\BKP\UserPermission.sql"
$BkpPath = "C:\Kamal\COG50145\Audit\CHG0129422\BKP\"




FOREACH ($S IN $SLIST)
{
       $Er = @()
       if ($S.is_Instance -eq 1)
       {
        $Outfile = $BkpPath + ($S.instance | foreach {$_ -replace "\\", "_"})+ "_" + ($S.id | foreach {$_ -replace "\\", "_"})+ "_" + (Get-Date -UFormat "%Y%m%d") + '.txt' 
        $OutList = Invoke-Sqlcmd -InputFile $ScriptPath -Variable "id='$($S.id)'"  -ServerInstance $S.instance -Database "master" -MaxCharLength 9999999 -ErrorAction Continue -ErrorVariable Er
       }
       else
       {
        $Outfile = $BkpPath + ($S.instance | foreach {$_ -replace "\\", "_"}) + "_" + $S.database + "_" + ($S.id | foreach {$_ -replace "\\", "_"}) + "_" + (Get-Date -UFormat "%Y%m%d") + '.txt'
       $OutList = Invoke-Sqlcmd -InputFile $ScriptPath -Variable "id='$($S.id)'" -ServerInstance $S.instance -Database $S.database -MaxCharLength 9999999 -ErrorAction Continue -ErrorVariable Er
       }

        If ($Er)
        {
            $OPE = $S.instance  +  "," + $S.database +  "," + $S.id +  "," + $Er[0].tostring().Substring(0,40)
            WRITE-OUTPUT $OPE | out-file  "C:\Kamal\COG50145\Audit\CHG0129422\BKP\Errors.csv" -ENCODING ASCII  -APPEND
        }
        else
        {
            write-output $OutList.SQLSTATEMENTS | Out-File -FilePath $Outfile
        }
       $Outfile = ''
        
}


Remove-Variable $Outfile
Remove-Variable $OutList
Remove-Variable $OPE
Remove-Variable $Er
Remove-Variable $S
Remove-Variable $BkpPath
Remove-Variable $ScriptPath
Remove-Variable $SList

<#

        If ($Er)
        {
            $OPE = $S.c +  "," + 'Error'
            WRITE-OUTPUT $OPE | out-file  C:\Kamal\COG50145\Audit\LoginFail.csv -ENCODING ASCII  -APPEND
        }
        else
        {
            FOREACH ($DB IN $DBName)
            {
                $Users = INVOKE-SQLCMD -QUERY " SELECT Name, case when issqlrole = 1 then  'SQL Role'
			                    when issqlUser = 1 then  'SQL User'
			                    when isntuser =1 or isntgroup = 1 then  'Network User'
			                    else 'Login' end as Descs,
                                Hasdbaccess As Status
                                FROM SYS.sysusers" -ServerInstance $S.c -Database $DB.Name

                FOREACH($UName IN $Users)
                {
                 
                    $OPE = $S.c + "," + $DB.Name + "," + $UName.Name + "," + $UName.Descs  + "," + $UName.Status 
                    WRITE-OUTPUT $OPE | out-file  C:\Kamal\COG50145\Audit\Login.csv -ENCODING ASCII  -APPEND
                }
            }

        }



    }



Remove-Variable $Er
Remove-Variable $DB
Remove-Variable $OPE
Remove-Variable $DBName
Remove-Variable $S
Remove-Variable $SList




$date = get-date -Format g
$Instance = "CNU4249BVK\SQL2008R2"  
$DB = "Mytest"
$OldUser = 'myTest'
$Date = Get-Date -UFormat "%Y%m%d"
$Outfile = 'C:\Kamal\test\' + ($Instance | foreach {$_ -replace "\\", "_"}) + "_" + $OldUser + "_" + (Get-Date -UFormat "%Y%m%d") + '.txt'
$Outfile

$OutList = Invoke-Sqlcmd -InputFile "C:\Kamal\test\UserPermission.sql" -Variable "OldUser='${OldUser}'" -ServerInstance $Instance -Database $DB -MaxCharLength 9999999
write-output $OutList.SQLSTATEMENTS | Out-File -FilePath "C:\Kamal\test\text.txt"
    #>