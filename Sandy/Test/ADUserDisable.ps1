
Import-Module ActiveDirectory
$csv = 'C:\Users\Administrator\Desktop\Test\ADUserDisable.csv'
Import-Csv $csv	| ForEach-Object {		
$san = $_.username
$a = "{0:d}" -f (get-date)
$Dis_admin = $_.disadmin
$Ticketid = $_.Ticketid
$EID = $_.empid
#$san = "skambham"
$uid = Get-ADUser  -SearchBase 'DC=corp,DC=innominds,DC=com' -Filter {sAMAccountName -eq $san } -Properties Name,SamAccountName,EmployeeID
   if ($uid.employeeID -eq $EID ){
 
   If (Get-ADUser  -SearchBase 'OU=Disabled Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com' -Filter {sAMAccountName -eq $san })
       {
         write-Output "user $san is already disabled."
    	}
		
else 
    {
     #write-Output "hi"
		
		 #$users= get-aduser -Filter * -SearchBase "ou=Users,ou=VizagIncubation,dc=corp,dc=innominds,dc=com"

           Function RemoveMemberships

                                       {

 
                             $SAMAccountName = $san
                               #param([string]$SAMAccountName)  
 
                                $user = Get-ADUser $SAMAccountName -properties memberof
 
                                      $userGroups = $user.memberof

                              $userGroups | %{get-adgroup $_ | Remove-ADGroupMember -confirm:$false -member $SAMAccountName}

                                $userGroups = $null

 }

                 Disable-ADAccount -Identity $san

                $users | %{RemoveMemberships $_.SAMAccountName}

               Set-ADUser $san -Description  " Terminated on terminatedmaire$a  Terby $Dis_admin with $Ticketid"

                Set-ADAccountExpiration -Identity $san "$a"

              Get-ADUser $san | Move-ADObject -TargetPath 'OU=Disabled Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com'

              write-Output $san "is successfully disabled and moved to Disabled Users."
}
		
		
   
}


   else
   {
write-Output "UserID and employeeID doesnot match"
   }
#write-Output $san "is successfully disabled and moved to Disabled Users."

}
