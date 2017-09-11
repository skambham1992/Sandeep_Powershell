
$csv = 'E:\XAMPP\htdocs\Project\Server\InnomindsUserCreation.csv'
$ouloccsv = 'E:\XAMPP\htdocs\Project\Server\InnomindsUserCreationLocation.csv'
#$ou  = 'OU=Users,OU=VizagIncubation,DC=innomindshyd,DC=com'
Add-Type -AssemblyName System.Web
Import-Csv $ouloccsv | ForEach-Object {
$OU = $_.Location
}
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
                    $sn = $_.lastname
					#$CN  = $_.firstname +" "+ $_.lastname
					$upn = "@innomindshyd"+"."+"com"
					$emailinno = "@innominds"+"."+"com"
				   # $cname = Get-ADUser -filter { CN -eq $CN } | measure
					
                        
						$CN = $_.firstname +" "+ $_.middlename   
						$Givenname = $_.firstname +" "+ $_.middlename 
						$givenCN = $CN.substring(0,1).toupper()+$CN.substring(1).tolower()+$lastname 
						for($j=0; $j -le 5 ; $j++){
							$cname = Get-ADUser -filter { CN -eq $givenCN } | measure
							if($cname.Count -gt 0){
								$givenCN = $_.firstname +" "+ $_.middlename+" "+ $_.lastname  + ($j+1)
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
	
     
    $lastname = $sn.substring(0,1).toupper()+$sn.substring(1).tolower()
    $DisplayFirstName = $Givenname.substring(0,1).toupper()+$Givenname.substring(1).tolower()
   # $givenCN = $CN.substring(0,1).toupper()+$CN.substring(1).tolower()+$lastname 
	$pwd = [System.Web.Security.Membership]::GeneratePassword(10,2)
    $pw   = ConvertTo-SecureString $pwd -AsPlainText -Force
				New-ADUser -Name $givenCN `
				-SamAccountName $samid `
				-GivenName $DisplayFirstName `
				-Surname $lastname `
				-Path $OU `
				-AccountPassword $pw `
				-Enabled $true `
				-CannotChangePassword $False `
				-PassThru `
				-UserPrincipalName $samid$upn` 
   
				Set-ADUser $samid -Description  " Created on $a,by $creater with $Ticketid"  
				Set-ADUser $samid -Department $_.deptame
				Set-ADUser -Identity $samid -Manager $Manager
				Set-ADUser -Identity $samid -Company "Innominds"
				Set-ADUser $samid -Title $_.title 
				Set-ADUser -Identity $samid -EmailAddress  $emailinno
				$CreatedCN = Get-ADUser "skambham" -properties SAmAccountName
                $CreatedCN.SAmAccountName

				$SmtpServer = 'smtp.gmail.com'
				$SmtpUser = 'InnomindsUserCreation@gmail.com'
				$smtpPassword = 'Innominds123$'
				$MailtTo = $emailid
				$MailFrom = 'InnomindsUserCreation@gmail.com'
				$MailSubject = "INNOMINDS USER CREATION" 
				$MailMessage =  "Hello "+$DisplayFirstName+",`n`nPlease find Your Innominds Email and Myspace Portal account details.`n`nPlease login to the Webmail at URL http://outlook.innominds.com to access the email with below credentials.
`n  username :"+$samid+ " `n  password : "+$pwd+ "`n`nLogin credentials for System and Myspace (URL: https://myspace.innominds.com ) are:
`n  username :"+$samid+ " `n  password : "+$pwd+"`n`nNote : Myspace portal activation may take up to 24 Hrs. Later if you need further assistance on Myspace, please write to HR(mparise@innominds.com).
`nNote : Please enroll/register at https://ssp.innominds.com and reset the password.
`n`Need Help on how to Enroll or Use SSP ?? Visit https://ssp.innominds.com/ssp.pdf `n`n`nRegards,`nIT Team,`nInnominds."
				$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $SmtpUser, $($smtpPassword | ConvertTo-SecureString -AsPlainText -Force) 
				Send-MailMessage -To "$MailtTo" -from "$MailFrom" -Bcc "skambham@innominds.com" -Subject $MailSubject -Body $MailMessage -SmtpServer $SmtpServer -Credential $Credentials -UseSsl -Port 587 
 
				
		#Creating CSV filr for sending mail		
		       <# $b = Get-Date
				$file = "C:\Users\Administrator\Desktop\testingcsv.csv" 
				#$fileContent = Import-csv $csv -header "FirstName", "Password"
				$NewUser = $samid
                $NewPass = $pwd
				$NewLine = "{0},{1},{2}" -f $NewUser,$NewPass,$b
                $NewLine | add-content -path $file 
				#Import-CSV $csv  | Sort Date –Descending | Export-CSV $csv -notypeinformation
				 $USR = "CORP\Administrator"
					$PSD = "lockScreen!@99"
					$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-file C:\Users\Administrator\Desktop\mail_sleep.ps1"
					#$DELAY = new-timespan -minutes 3
					$ts = New-TimeSpan -Minutes 10
					$a = (Get-Date).AddMinutes(4)
					$middayTrigger = New-JobTrigger -Once -At $a 
					$scriptPath1 = 'C:\Users\Administrator\Desktop\mail_sleep.ps1'
					Register-ScheduledTask -TaskName $samid"_mail_Schedule" -Action $action -Trigger $middayTrigger -User $USR -Password $PSD
 
	             $sorted = Import-Csv $file | Sort-Object Date -Descending 
				 $sorted | Export-csv -NoTypeInformation $file #>

               



}
