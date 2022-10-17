$a = "<style>"
$a = $a + "BODY{}"
#$a = $a + "BODY{background-color:peachpuff;}"
$a = $a + "TABLE{border-width: 1px;border-style: solid;border-color: black;border-collapse:collapse;font-family:Verdana;font-size: 10px;}"
$a = $a + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;}"
#$a = $a + "TH{border-width: 1px;padding: 0px;border-style: solid;border-color: black;background-color:#808080}"
$a = $a + "TD{border-width: 1px;padding: 0px;border-style: solid;border-color: black;}"
#$a = $a + "Tr{border-width: 1px;padding: 0px;border-style: solid;border-color: black;nth-child(even) {background-color: #f2f2f2};}"
$a = $a + "</style>"

$Body = gwmi -class win32_service | select Name,DisplayName,StartMode,State,ProcessId,StartName| ConvertTo-Html -Head $a -Body "This is sample HTML"

   $smtpServer = "HIGMX.TheHartford.com"

     #Creating a Mail object
     $msg = new-object Net.Mail.MailMessage

     #Creating SMTP server object
     $smtp = new-object Net.Mail.SmtpClient($smtpServer)

     #Email structure 
     $msg.From = "Kamal.Marimuthu@TheHartford.com"
     $msg.ReplyTo = "Kamal.Marimuthu@TheHartford.com"
     $msg.To.Add("Kamal.Marimuthu@TheHartford.com")
     $msg.subject = "This is test from powershell"
     $msg.IsbodyHTML = $true
     $msg.body = $Body

     #Sending email 
     $smtp.Send($msg)

