cls
#Copy-Item "C:\Kamal\test.txt" -Destination "\\AD1HFDASEN905\c$\hig\test.txt"
#xcopy "C:\Kamal\test.txt" "\\AD1HFDASEN905\c$"
$f = "\\AD1HFDASEN905\c$"
$v = test-path $f -IsValid
if ($v -eq $true) { WRITE-OUTPUT $f }
#convert-path -path "\\AD1HFDASEN905\c$"
Get-ChildItem -Path \\AD1HFDASEN905\c$ -Verbose

#to run background -asjob
Invoke-Command -ComputerName AD1HFDDBST2A0,AD1HFDDBST2A1 -ScriptBlock { typeperf "System\Processor Queue Length" } -AsJob

Invoke-Command -ComputerName AD1HFDDBST2A0 -ScriptBlock { netstat -atn } 

Invoke-Command -ComputerName AD1HFDDBST2A0 -ScriptBlock { netstat -atn } | where { $_."Offload State" -like "*In*"}


Invoke-Command -ComputerName AD1HFDDBST2A0,AD1HFDDBST2A1 -ScriptBlock { typeperf "System\Processor Queue Length" }  | Format-Table

Invoke-Command -ComputerName AD1HFDDBST2A0,AD1HFDDBST2A1 -ScriptBlock { typeperf "Process(*)\% Processor Time" -f csv -o "C:\temp\mytemp.csv"}

gwmi -Class win32_process | select Caption,ParentProcessId,ProcessId,WorkingSetSize | Sort-Object Caption | Format-Table

gwmi -Class win32_service -ComputerName AD1HFDSQLPC03A | Format-List *

gwmi -Class win32_service | select Caption, StartName | Format-Table

gwmi -Class win32_service | Where-Object {$_.DisplayName -like '*cond*'} | Format-List *

Get-Process -ComputerName ad1hfddbcm906 | select * | where-Object {$_.Id -eq 4464}

tasklist /s ad1hfddbcm906 /svc

Invoke-Command -ScriptBlock { tasklist } | Format-Table -Property *


Get-Command -Module sqlps


Get-ChildItem SQL\CNU4249BVK\SQL2012\databases\master\users

PS SQLSERVER:\> Get-ChildItem SQL\AD1HFDSP13D002\PR_SP13_HFD02


Get-ADComputer
Get-ADGroup
Get-ADGroupmember
Get-ADUser
Get-Alias
Get-Cluster
Get-Date


Get-ADGroupMember -identity "@MBM MDS SQLDBA" -Recursive | select name,objectclass,displayname
Get-ADPrincipalGroupMembership "JTavernese" | select GroupCategory,GroupScope,name

cim-class
Win32_MountPoint

Net Statistics Server

Win32_Share
Win32_ClusterShare
Win32_Process
Win32_OperatingSystem
Win32_Computersystem