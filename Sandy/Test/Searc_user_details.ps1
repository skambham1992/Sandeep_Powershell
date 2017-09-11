Get-Module -Name ActiveDirevtory
$csv = 'C:\Users\Administrator\Desktop\Test\searchuser.csv'
Import-Csv $csv | ForEach-Object {
$samid = $_.samid
}


Get-ADUser $samid -properties SAmAccountName,GivenName,UserPrincipalName,Canonicalname,Manager,memberof,description