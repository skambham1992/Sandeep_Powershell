$csv = 'C:\Users\Administrator\Desktop\Sandeep_test\ADUserReset.csv'
Add-Type -AssemblyName System.Web
Import-Csv $csv	| ForEach-Object {
		
$pwd = [System.Web.Security.Membership]::GeneratePassword(10,2)
$pw   = ConvertTo-SecureString $pwd -AsPlainText -Force
$user = $_.username
$emailId=$_.emailid
$emailIdCc=$user+'@innominds.com'
$users = Get-ADUser -filter { SamAccountName -eq $user }

$Requiredname = $user
$DisableUser = Get-ADUser  -SearchBase 'OU=Disabled Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com' -Filter {sAMAccountName -eq $Requiredname }

If ($DisableUser -eq $Null) { 

Set-ADAccountPassword -Reset -NewPassword $pw –Identity $users

Enable-ADAccount -Identity $users

Set-ADUser –Identity $users –ChangePasswordAtLogon $true

Write-Output $users


$SmtpServer = 'smtp.gmail.com'
$SmtpUser = 'sampleproject888@gmail.com'
$smtpPassword = 'SampleSample'
$MailtTo = $emailId
$MailFrom = 'sampleproject888@gmail.com'
$MailSubject = "INNOMINDS NEW LOGON DETAILS" 
$MailMessage =  "Hello "+$user+",`n`nYour Password Reset Successfully Completed.Please find Your Innominds Email and Myspace Portal account details.
`n  username :"+$user+ " `n  password : "+$pwd+ "`n`n`nRegards,`nIT Team,`nInnominds."
$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $SmtpUser, $($smtpPassword | ConvertTo-SecureString -AsPlainText -Force) 
Send-MailMessage -To "$MailtTo" -Cc "$emailIdCc" -from "$MailFrom" -Subject $MailSubject -Body $MailMessage -SmtpServer $SmtpServer -Credential $Credentials -UseSsl -Port 587 
	
return "New Password Created  :"+$pwd;


}


  
else {

Write-Output "User exists"
 
} 

}