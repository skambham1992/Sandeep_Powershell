
$csv = 'C:\Users\Administrator\Desktop\Sandeep_test\add_empid.csv'

Import-module ActiveDirectory 

Import-Csv $csv	| ForEach-Object {
		
$userid = $_.userid
$empid=$_.empid
Set-ADUser $userid -employeeID $empid
write-output "$empid is successfully added to the user $userid"
}