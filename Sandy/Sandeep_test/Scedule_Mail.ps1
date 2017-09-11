
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
                    $sn = $_.lastname
					#$CN  = $_.firstname +" "+ $_.lastname
					$upn = "@corp"+"."+"innominds"+"."+"com"
				   # $cname = Get-ADUser -filter { CN -eq $CN } | measure
					

						$CN = $_.firstname +" "+ $_.middlename   
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
    $givenCN = $CN.substring(0,1).toupper()+$CN.substring(1).tolower()+$lastname  
    $lastname = $sn.substring(0,1).toupper()+$sn.substring(1).tolower()
    

	$pwd = [System.Web.Security.Membership]::GeneratePassword(10,2)
    $pw   = ConvertTo-SecureString $pwd -AsPlainText -Force
				New-ADUser -Name $givenCN `
				-SamAccountName $samid `
				-GivenName $Givenname `
				-Surname $lastname `
				-Path $ou `
				-AccountPassword $pw `
				-Enabled $true `
				--CannotChangePassword $True  `
				-PassThru `
				-UserPrincipalName $samid$upn` 
   
				Set-ADUser $samid -Description  " Created on $a,by $creater with $Ticketid"  
				Set-ADUser $samid -Department $_.deptame
				Set-ADUser -Identity $samid -Manager $Manager
				Set-ADUser -Identity $samid -Company "Innominds"
				Set-ADUser $samid -Title $_.title 
				Set-ADUser -Identity $samid -EmailAddress  $samid$upn
		#Creating CSV filr for sending mail		
		        $b = Get-Date
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
				 $sorted | Export-csv -NoTypeInformation $file
               



}
