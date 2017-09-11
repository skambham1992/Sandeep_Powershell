# Check if the ActiveDirectory module is Loaded
Get-Module -Name ActiveDirevtory

<# Check if the ActiveDirectory module is available
Get-Module -Name ActiveDirectory -ListAvailable

# Import the ActiveDirectory module
Import-Module -Name ActiveDirectory

# Find Cmdlets in the ActiveDirectory related to OrganizationalUnit
#Get-ADObject -Filter { ObjectClass -eq 'organizationalunit' }
$OU = 'OU=VizagIncubation,DC=corp,DC=innominds,DC=com'

#Get-ADOrganizationalUnit -SearchBase $OU -SearchScope Subtree -Filter * | 
     #Select-Object DistinguishedName, Name


  $dn = Get-ADobject -SearchScope Subtree -SearchBase $OU -Filter { ObjectClass -eq 'organizationalunit' } -Properties  DistinguishedName
  $dn.DistinguishedName#>

  <#$csv = 'E:\XAMPP\htdocs\Project\Server\InnomindsUserCreation.csv'
  Import-Csv $csv | ForEach-Object { $tit = $_.Location }
  write-output $tit#>
  
<#$a = Get-ADUser "skambham" -properties GivenName,SAmAccountName
$a.SAmAccountName#>
Get-ADUser "skambham" -properties SAmAccountName,GivenName,UserPrincipalName,Canonicalname,Manager,memberof,description
#Get-ADUser -Identity "skambham" -Properties Canonicalname