$csv = 'C:\Users\Administrator\Desktop\Desktop_1\Test\unlock.csv'
$ou  = 'OU=Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com'
Import-Csv $csv | ForEach-Object {
$user =  $_.samname
If (Unlock-ADAccount -Identity $user){
	write-Output "Succesfully Unlocked"
} 
Else{
	write-Output "Already Unlocked"
}
}
#$user = get-aduser -f {SamAccountName -eq 'fshaik'}
#write-Output $user
