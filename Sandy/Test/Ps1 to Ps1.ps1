
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
				#return "Password Created  :"+$pwd;
                Write-output "Password Created  :"+$pwd;
				
		# Invoke-Expression C:\Users\Administrator\Desktop\mail_sleep.ps1
		
		    Start-Sleep -s 25
			$SmtpServer = 'smtp.gmail.com'
			$SmtpUser = 'sampleproject888@gmail.com'
			$smtpPassword = 'SampleSample'
			$MailtTo = 'skambham@innominds.com'
			$MailFrom = 'sampleproject888@gmail.com'
			$MailSubject = "INNOMINDS USER CREATION" 
			$MailMessage =  "TeRTHYRTDe"
			$Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $SmtpUser, $($smtpPassword | ConvertTo-SecureString -AsPlainText -Force) 
			Send-MailMessage -To "$MailtTo" -from "$MailFrom" -Subject $MailSubject -Body $MailMessage -SmtpServer $SmtpServer -Credential $Credentials -UseSsl -Port 587
         
         

		




}