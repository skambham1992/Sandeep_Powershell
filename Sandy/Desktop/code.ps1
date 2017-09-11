Import-Module ActiveDirectory

$USER = "noone"

# Get users matching the search criteria
$MatchingUsers = Get-ADUser -Filter 'UserPrincipalName -like $USER' 

if ($MatchingUsers)
{

$suggestedUserName = $TYSON
   
    
}
Write-Host $suggestedUserName

else
{
    # no matches so just use the name
    $suggestedUserName = $USER
}

# Display the results
Write-Host $suggestedUserName