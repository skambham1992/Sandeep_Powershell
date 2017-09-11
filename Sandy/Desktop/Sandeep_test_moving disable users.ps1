$san = "Tcruise"
Get-ADUser -filter * -SearchBase 'OU=Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com' -Properties SamAccountName | 
        Where-Object{$san} | Disable-ADAccount