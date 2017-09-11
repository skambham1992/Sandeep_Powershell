 1 # Script to create Active Directory accounts
  2 # v2 9/12/2012
  3 # Todd Klindt
  4 # http://www.toddklindt.com
  5 
  6 # Add the Active Directory bits and not complain if they're already there
  7 Import-Module ActiveDirectory -ErrorAction SilentlyContinue
  8 
  9 # set default password
 10 # change pass@word1 to whatever you want the account passwords to be
 11 $defpassword = (ConvertTo-SecureString "Inno123$" -AsPlainText -force)
 12 
 13 # Get domain DNS suffix
 14 $dnsroot = '@' + (Get-ADDomain).dnsroot
 15 
 16 # Import the file with the users. You can change the filename to reflect your file
 17 $users = "Tyson"
 18 
 19 foreach ($user in $users) {
 20         if ($user.manager -eq "") # In case it's a service account or a boss
 21             {
 22                 try {
 23                     New-ADUser -SamAccountName $user.SamAccountName -Name ($user.FirstName + " " + $user.LastName) `
 24                     -DisplayName ($user.FirstName + " " + $user.LastName) -GivenName $user.FirstName -Surname $user.LastName `
 25                     -EmailAddress ($user.SamAccountName + $dnsroot) -UserPrincipalName ($user.SamAccountName + $dnsroot) `
 26                     -Title $user.title -Enabled $true -ChangePasswordAtLogon $false -PasswordNeverExpires  $true `
 27                     -AccountPassword $defpassword -PassThru `
 28                     }
 29                 catch [System.Object]
 30                     {
 31                         Write-Output "Could not create user $($user.SamAccountName), $_"
 32                     }
 33             }
 34             else
 35              {
 36                 try {
 37                     New-ADUser -SamAccountName $user.SamAccountName -Name ($user.FirstName + " " + $user.LastName) `
 38                     -DisplayName ($user.FirstName + " " + $user.LastName) -GivenName $user.FirstName -Surname $user.LastName `
 39                     -EmailAddress ($user.SamAccountName + $dnsroot) -UserPrincipalName ($user.SamAccountName + $dnsroot) `
 40                     -Title $user.title -manager $user.manager `
 41                     -Enabled $true -ChangePasswordAtLogon $false -PasswordNeverExpires  $true `
 42                     -AccountPassword $defpassword -PassThru `
 43                     }
 44                 catch [System.Object]
 45                     {
 46                         Write-Output "Could not create user $($user.SamAccountName), $_"
 47                     }
 48              }
 49           }
 60    }