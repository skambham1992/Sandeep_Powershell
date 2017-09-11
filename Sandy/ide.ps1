Import-Module ActiveDirectory

<#$csv = "C:\Users\Administrator\Desktop\Desktop_1\testingcsv.csv"

Import-Csv $csv | ForEach-Object {

$email = $_.email


Get-ADUser -Filter {Emailaddress -eq $email } -Properties DisplayName,givenName
} 




Import-Module ActiveDirectory
$oldSuffix = "corp.innominds.com"
$newSuffix = "innominds.com"
$ou = "OU=KalaJyothi,OU=VizagIncubation,DC=corp,DC=innominds,DC=com"
$server = "corp.innominds.com"
Get-ADUser -SearchBase $ou -filter "akambham" | ForEach-Object {
$newUpn = $_.UserPrincipalName.Replace($oldSuffix,$newSuffix)
$_ | Set-ADUser -server $server -UserPrincipalName $newUpn
}

$a = Get-ADUser -Filter {SAmAccountName -eq "skambham" } -properties SAmAccountName
$b = $a.SamAccountName

if ($b -eq "zkambham") {

Write-Output "exists"

}
else {
Write-Output "create"#>
#}
#Get-ADUser -Filter {SAmAccountName -eq "psaana"} -Properties DisplayName,givenName,cn

Get-ADUser "skambham"  LockedOut