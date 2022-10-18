cls
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100
$report = ""



$report = $report + "<html>"  
$report = $report + "<head>"  
$report = $report + "<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>"  
$report = $report + '<STYLE TYPE="text/css">'  
$report = $report +  "<!--"  
$report = $report +  "td {"  
$report = $report +  "font-family: Tahoma;"  
$report = $report +  "font-size: 11px;"  
$report = $report +  "border-top: 1px solid #999999;"  
$report = $report +  "border-right: 1px solid #999999;"  
$report = $report +  "border-bottom: 1px solid #999999;"  
$report = $report +  "border-left: 1px solid #999999;"  
$report = $report +  "pAdding-top: 0px;"  
$report = $report +  "pAdding-right: 0px;"  
$report = $report +  "pAdding-bottom: 0px;"  
$report = $report +  "pAdding-left: 0px;"  
$report = $report +  "}"  
$report = $report +  "body {"  
$report = $report +  "margin-left: 5px;"  
$report = $report +  "margin-top: 5px;"  
$report = $report +  "margin-right: 0px;"  
$report = $report +  "margin-bottom: 10px;"  
$report = $report +  ""  
$report = $report +  "table {"  
$report = $report +  "border: thin solid #000000;"  
$report = $report +  "}"  
$report = $report +  "-->"  
$report = $report +  "</style>"  
$report = $report + "</head>"  
$report = $report + "<body>"  
$report = $report +  "<table width='100%'>"  
$report = $report +  "<tr bgcolor='0099FF'>"  
$report = $report +  "<td colspan='7' height='35' align='center'>"  
$report = $report +  "<font face='tahoma' color='#003399' size='4'><strong>Test Report</strong></font>"  
$report = $report +  "</td>"  
$report = $report +  "</tr>"  
$report = $report +  "</table>" 






$report = $report +  "<table width='100%'>"  
$report = $report +  "<tr bgcolor='IndianRed'>"  
$report = $report +  "<td width='5%' height='20' align='center' > <strong>Name</strong></td>"  
$report = $report +  "<td width='5%' height='20' align='center' > <strong>DisplayName</strong></td>"
$report = $report +  "<td width='5%' height='20' align='center' > <strong>StartMode</strong></td>"
$report = $report +  "<td width='5%' height='20' align='center' > <strong>State</strong></td>"
$report = $report +  "<td width='5%' height='20' align='center' > <strong>StartName</strong></td>"
$report = $report + "</tr>"  


$frags = gwmi -class win32_service | select Name,DisplayName,StartMode,State,StartName

foreach($frag in $frags)
{
 $report = $report + "<tr>" 
 $report = $report + "<td align=center > $($frag.Name)</td>"  
 $report = $report + "<td align=center > $($frag.DisplayName)</td>"  
 $report = $report + "<td align=center > $($frag.StartMode)</td>"  
if ($frag.State -eq "Running")
 {
    $report = $report + "<td align=center > $($frag.State)</td>" 
 }
else 
 {
    $report = $report + "<td bgcolor= 'RED' align=center > $($frag.State)</td>" 
 }
 $report = $report + "<td align=center > $($frag.StartName)</td>"  

 $report = $report + "</tr>" 

 }

$report = $report +  "</table>"








$report = $report + "</body>"  
$report = $report + "</html>"


   $smtpServer = "HIGMX.xxx.com"

     #Creating a Mail object
     $msg = new-object Net.Mail.MailMessage

     #Creating SMTP server object
     $smtp = new-object Net.Mail.SmtpClient($smtpServer)

     #Email structure 
     $msg.From = "Kamal.Marimuthu@xxx.com"
     $msg.ReplyTo = "Kamal.Marimuthu@xxx.com"
     $msg.To.Add("Kamal.Marimuthu@xxx.com")
     $msg.subject = "This is test from powershell"
     $msg.IsbodyHTML = $true
     $msg.body = $report

     #Sending email 
     $smtp.Send($msg)


