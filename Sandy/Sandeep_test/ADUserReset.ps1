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

Get-ADUser $san | Move-ADObject -TargetPath 'OU=Admin_Reset_Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com'

Write-Output $users

}
  
else {

Write-Output "User $user is in Disable state"
 
} 

}