Import-module ActiveDirectory 
$EID = "00"
$User = "skambham"
$uid = Get-ADUser  -SearchBase 'DC=corp,DC=innominds,DC=com' -Filter {sAMAccountName -eq $User } -Properties Name,SamAccountName,EmployeeID
 if ($uid.employeeID -eq $EID ){
 
 write-output "yes"
 
 }else{
 write-output "No"
 }



