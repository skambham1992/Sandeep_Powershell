				
			           
 $userName1 ="hi"
				$pwd ="hello"			
				$SmtpServer = 'smtp.gmail.com'
				$SmtpUser = 'sandeepkambham7@gmail.com'
				$smtpPassword = "m!gMail@27"
				$MailtTo = 'skambham@innominds.com' 
				$MailFrom = 'InnomindsUserCreation@gmail.com'
				$MailSubject = "INNOMINDS USER CREATION" 
				$MailMessage =  "Hello "+$userName1+",`n`nPlease find Your Innominds Email and Myspace Portal account details.`n`nPlease login to the Webmail at URL http://outlook.innominds.com to access the email with below credentials.
`n  username :"+$userName1+ " `n  password : "+$pwd+ "`n`nLogin credentials for System and Myspace (URL: https://myspace.innominds.com ) are:
`n  username :"+$userName1+ " `n  password : "+$pwd+"`n`nNote : Myspace portal activation may take up to 24 Hrs. Later if you need further assistance on Myspace, please write to HR(mparise@innominds.com).
`nNote : Please enroll/register at https://ssp.innominds.com and reset the password.
`n`Need Help on how to Enroll or Use SSP ?? Visit https://ssp.innominds.com/ssp.pdf `n`n`nRegards,`nIT Team,`nInnominds."
				$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $SmtpUser, $($smtpPassword | ConvertTo-SecureString -AsPlainText -Force) 
				Send-MailMessage -To "$MailtTo" -from "$MailFrom" -Subject $MailSubject -Body $MailMessage -Replyto "$MailFrom" -SmtpServer $SmtpServer -Credential $Credentials -UseSsl -Port 587
 
 
 

