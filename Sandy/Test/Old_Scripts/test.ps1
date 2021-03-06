function Add-User {
[CmdletBinding()]
Param()
Write-Output "test1";
Write-Host "test2";
"test3";
$PlainTextPassword="letmein"
$Password=ConvertTo-SecureString -String $PlainTextPassword -AsPlainText -Force
  
function AddToCompanyWideGroup
{
    
   Param([string]$user)
   $HospWideGroup=[ADSI] "LDAP://CN=testuser,OU=Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com"
   $userPath=$user.Path
   $HospWideGroup.Add($userPath)
   $user.SetInfo()
}
	




function CreateHomeDir
{
   Param([string]$user)
   $homepath="f:\Users\$user"
   $shareName="$user$"
   $Type=0
   $pathToShare="\\acmenet01\f$\Users\$user"
   New-Item -type directory -path $pathToShare|Out-Null
   $WMI=[wmiClass]"\\acmenet01\root\cimV2:Win32_Share" 
   $WMI.Create($homepath,$shareName,$Type)|Out-Null
}

function set-Attributes
{
   Param(
      [string]$user,
      [string]$tmplateUser
   )

   AddToCompanyWideGroup -user $user

   $groups=get-qaduser $tmplateUser | select -ExpandProperty memberof
   foreach ($Group In $groups) 
   {
      add-qadgroupmember -identity $Group -member $user
   }
	$arrAttrs="department"
	$FirstName=$_.Firstname
	$LastName=$_.Lastname
	$displayName="$FirstName $LastName"
	$State="TX"
	$Country="United States"
	$CountryAbbr="US"
	$CountryCode="840"
	$Company="Acme Corporation"
	$ScriptPath="ACMELOG"
	$HomeDrivePath="\\acmenet01\$user$"
	$HomeDrive="U:"
	$user.st=$State
	$user.scriptpath=$ScriptPath
	$user.company=$Company
	$user.pwdLastSet=0
	$user.countryCode=$CountryCode
	$user.co=$Country
	$user.c=$CountryAbbr
	$user.employeeID=$EmpID
	$user.title=$Title
	$user.displayName=$displayName
	$user.SetInfo()
	$user.homeDrive=$HomeDrive
	$user.homeDirectory=$HomeDrivePath
	foreach ($Arr In $arrAttrs)
	{
		$updatedAttr=$UserToCopy.Get($Arr)
		$user.Put($Arr,$updatedAttr)
	}
	$user.SetInfo()
	$user.physicalDeliveryOfficeName=$user.department
	$user.description=$user.title
	$user.SetInfo()
}

	
	Import-Csv employees.csv |

	foreach {
      $name=$_.name
      $alias=$_.alias
      $user=$alias
      $userprincipalname="$alias@acme.org"
      $EmpID=$_.EmpID
      $Title=$_.title
      $Dept=$_.department
      $LastNameInit=$_.Lastname
      $LastNameInit=$LastNameInit.substring(0,1)
      $DeptNumber=$_.DeptNumber
      $suffix="TEMPLATE"
      $tmplateUser="$DeptNumber$suffix"
      $templateDN=get-qaduser -includedproperties parentContainerDN  $tmplateUser | Select –ExpandProperty parentContainerDN
		
      switch -regex ($LastNameInit)
      {
         "[A]" {$Database="ACMEMX02\6th Storage Group\A Mailboxes"}
         "[B]" {$Database="ACMEMX02\7th Storage Group\B Mailboxes"}
         "[E]" {$Database="ACMEMX02\10th Storage Group\E Mailboxes"}
         "[F]" {$Database="ACMEMX02\11th Storage Group\F Mailboxes"}
         "[G]" {$Database="ACMEMX02\12th Storage Group\G Mailboxes"}
         "[S]" {$Database="ACMEMX02\13th Storage Group\S Mailboxes"}
         "[T]" {$Database="ACMEMX02\14th Storage Group\T Mailboxes"}
         "[U-V]" {$Database="ACMEMX02\15th Storage Group\U-V Mailboxes"}
         "[W-Z]" {$Database="ACMEMX02\16th Storage Group\W-Z Mailboxes"}
         "[H]" {$Database="ACMEMX02\17th Storage Group\H Mailboxes"}
         "[I-K]" {$Database="ACMEMX02\18th Storage Group\I-K Mailboxes"}
         "[L]" {$Database="ACMEMX02\19th Storage Group\L Mailboxes"}
         "[M]" {$Database="ACMEMX02\20th Storage Group\M Mailboxes"}
         "[N-O]" {$Database="ACMEMX02\21st Storage Group\N-O Mailboxes"}
         "[P-Q]" {$Database="ACMEMX02\22nd Storage Group\P-Q Mailboxes"} 
         "[C]" {$Database="ACMEMX02\8th Storage Group\C Mailboxes"}
         "[D]" {$Database="ACMEMX02\9th Storage Group\D Mailboxes"}
         "[R]" {$Database="ACMEMX02\23rd Storage Group\R Mailboxes"} 
		}
        
       new-mailbox -name $name -alias $alias -Firstname $_.Firstname -LastName $_.Lastname -userPrincipalName $userprincipalname `
       -database $Database -OrganizationalUnit $templateDN -Password $Password
       CreateHomeDir -User $user
       set-Attributes -user $user -template $tmplateUser
       SetSharePerm -user $user
       mailit -u $user -f $_.FirstName -L $_.LastName
	}
	remove-item "\\acmeweb02\c$\employees.csv" -force
	
}
Write-Output "test1";
Write-Host "test2";
"test3";