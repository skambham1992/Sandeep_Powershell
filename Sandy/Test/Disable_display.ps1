$csv = 'C:\Users\Administrator\Desktop\Test\ADUserDisable.csv'
Import-Module ActiveDirectory
Import-Csv $csv	| ForEach-Object {	
$san = $_.username
$EID = $_.empid
$uid = Get-ADUser  -SearchBase 'DC=corp,DC=innominds,DC=com' -Filter {sAMAccountName -eq $san } -Properties Name,SamAccountName,EmployeeID
   if ($uid.employeeID -eq $EID ){
Get-AdUser -Filter 'SamAccountName -eq $san ' -Searchbase 'OU=Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com' -pr SamAccountName,PasswordExpired,whenChanged,UserPrincipalName,Description,memberof
}
 else
   {
write-Output "UserID and employeeID doesnot match"
   }
}