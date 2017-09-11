$SmtpServer = 'smtp.gmail.com'
$SmtpUser = 'sampleproject888@gmail.com'
$smtpPassword = 'samplesample'
$MailtTo = 'skambham@innominds.com'
$MailFrom = 'sampleproject888@gmail.com'
$MailSubject = "Test using $SmtpServer" 
$MailMessage =  "you account created"
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $SmtpUser, $($smtpPassword | ConvertTo-SecureString -AsPlainText -Force) 
Send-MailMessage -To "$MailtTo" -from "$MailFrom" -Subject $MailSubject -Body $MailMessage -SmtpServer $SmtpServer -Credential $Credentials -UseSsl -Port 587 