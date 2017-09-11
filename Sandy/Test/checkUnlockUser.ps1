
$csv = 'C:\Users\Administrator\Desktop\Desktop_1\Test\unlock.csv'

Import-Csv $csv | ForEach-Object {
$user =  $_.samname

#Import-Module ActiveDirectory
#Get-ADUser nbanala -Properties LockedOut | Select-Object LockedOut
#Get-ADUser  skambham -Properties * | Select-Object LocketOut

If ((Get-ADUser $user -Properties LockedOut).LockedOut) {
	write-Output "true"
}
Else{
	write-Output  "false"
}
}
#write-Output $san "is successfully disabled and moved to Disabled Users."