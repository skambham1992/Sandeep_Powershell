$users= get-aduser -Filter * -SearchBase "ou=Users,ou=VizagIncubation,dc=corp,dc=innominds,dc=com"

Function RemoveMemberships

 {

 
  $SAMAccountName = "nekumari"
  #param([string]$SAMAccountName)  
 
 $user = Get-ADUser $SAMAccountName -properties memberof
 
 $userGroups = $user.memberof

 $userGroups | %{get-adgroup $_ | Remove-ADGroupMember -confirm:$false -member $SAMAccountName}

 $userGroups = $null

 }


$users | %{RemoveMemberships $_.SAMAccountName}