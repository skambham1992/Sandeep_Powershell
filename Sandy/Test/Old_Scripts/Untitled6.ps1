$Name = "skambham"
$User = Get-ADUser  -SearchBase 'OU=Disabled Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com' -Filter {sAMAccountName -eq $Name}
If ($User -eq $Null) {"User does not exist in AD"}
Else {"User found in AD"}