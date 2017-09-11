function mailit {
Param(
[string]$user,
[string]$FirstName,
[string]$LastName
)
$EmailList="helpdesk@acme.org"
$MailMessage= @{
To=$EmailList
From="DONOTREPLY@acme.org"
Subject="NEW USER ACCOUNT"
Body="A new user account has been created. Initial login information listed below: `n
First name: $FirstName
Last name:  $LastName
Userid: $user
Password: letmein
Thank You."
SmtpServer="smtp.acme.org"
ErrorAction="Stop"
	}
Send-MailMessage @MailMessage
}
