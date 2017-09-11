
$csv = 'C:\Users\Administrator\Desktop\Test\ADEmployee.csv'
$ou  = 'OU=Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com'
Add-Type -AssemblyName System.Web

Import-Csv $csv | ForEach-Object {
#write-Output $_.title
				   $a = "{0:d}" -f (get-date)
				   $managers = $_.manager
					$Manager = Get-ADUser -Filter {Name -eq $managers}
					$user =  $_.firstname
					$emailid = $_.mailid
					$creater = $_.createdby
					$Ticketid = $_.Ticketid
					$userName1 = $_.firstname.Substring(0,1) + $_.lastname
					#$CN  = $_.firstname +" "+ $_.lastname
					$upn = "@corp"+"."+"innominds"+"."+"com"
				   # $cname = Get-ADUser -filter { CN -eq $CN } | measure
					

						$CN = $_.firstname +" "+ $_.middlename+" "+ $_.lastname    
						$Givenname = $_.firstname +" "+ $_.middlename 
						for($j=0; $j -le 5 ; $j++){
							$cname = Get-ADUser -filter { CN -eq $CN } | measure
							if($cname.Count -gt 0){
								$CN = $_.firstname +" "+ $_.middlename+" "+ $_.lastname  + ($j+1)
							}
						   
						}


						for($i=1; $i -le $user.length; $i++){
							$userName = $_.firstname.Substring(0,$i) + $_.lastname
							$sann = Get-ADUser -filter { SamAccountName -eq $userName } | measure
							if($sann.Count -gt 0){
								
								$userName1 = $_.firstname.Substring(0,$i+1) + $_.lastname
							}
    }
    $samid = $userName1.tolower()
	$pwd = [System.Web.Security.Membership]::GeneratePassword(10,2)
    $pw   = ConvertTo-SecureString $pwd -AsPlainText -Force
				New-ADUser -Name $CN `
				-SamAccountName $samid `
				-GivenName $Givenname `
				-Surname $_.lastname `
				-Path $ou `
				-AccountPassword $pw `
				-Enabled $true `
				-ChangePasswordAtLogon $true `
				-PassThru `
				-UserPrincipalName $samid$upn` 
   
				Set-ADUser $samid -Description  " Created on $a,by $creater with $Ticketid"  
				Set-ADUser $samid -Department $_.deptame
				Set-ADUser -Identity $samid -Manager $Manager
				Set-ADUser -Identity $samid -Company "Innominds"
				Set-ADUser $samid -Title $_.title 
				Set-ADUser -Identity $samid -EmailAddress  $samid$upn
				#write-Output "Password Created  :"+$pwd;
				
				
				#Start-Sleep -s 20
				$SmtpServer = 'smtp.gmail.com'
				$SmtpUser = 'sampleproject888@gmail.com'
				$smtpPassword = 'SampleSample'
				$MailtTo = $emailid
				$MailFrom = 'sampleproject888@gmail.com'
				$MailSubject = "INNOMINDS USER CREATION" 
				$MailMessage =  "Hello "+$user+",`n`nPlease find Your Innominds Email and Myspace Portal account details.`n`nPlease login to the Webmail at URL http://outlook.innominds.com to access the email with below credentials.
				`n  username :"+$samid+ " `n  password : "+$pwd+ "`n`nLogin credentials for System and Myspace (URL: https://myspace.innominds.com ) are:
				`n  username :"+$samid+ " `n  password : "+$pwd+"`n`nNote : Myspace portal activation may take up to 24 Hrs. Later if you need further assistance on Myspace, please write to HR(mparise@innominds.com).
				`nNote : Please enroll/register at https://ssp.innominds.com and reset the password.
				`n`Need Help on how to Enroll or Use SSP ?? Visit https://ssp.innominds.com/ssp.pdf `n`n`nRegards,`nIT Team,`nInnominds."
				$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $SmtpUser, $($smtpPassword | ConvertTo-SecureString -AsPlainText -Force) 
				Send-MailMessage -To "$MailtTo" -from "$MailFrom" -Subject $MailSubject -Body $MailMessage -SmtpServer $SmtpServer -Credential $Credentials -UseSsl -Port 587 
					#write-Output $csv
	  return "Password Created  :"+$pwd;



}