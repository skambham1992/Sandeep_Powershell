$Requiredname = "skambham"
$DisableUser = Get-ADUser  -SearchBase 'OU=Disabled Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com' -Filter {sAMAccountName -eq $Requiredname }
If ($DisableUser -eq $Null) {"User does not exist in AD"}
Else {"User found in AD"}