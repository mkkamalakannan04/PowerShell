cls
$tns = "(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = xdhfd8-scan1)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = CDW_PRD_DEL_APP471.thehartford.com)
    )
)"

$Srv = "AD1HFDISEN005"

$out = Invoke-Command -ComputerName $Srv {param($tns) tnsping "$tns" } -ArgumentList $tns
Write-Host $out