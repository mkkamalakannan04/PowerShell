 function sendMail{

     #SMTP server name
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
     $msg.body = "This is the email Body."

     #Sending email 
     $smtp.Send($msg)
}