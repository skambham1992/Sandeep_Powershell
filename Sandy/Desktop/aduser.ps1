

Import-Module ActiveDirectory
New-ADUser `
 -Name "steve" `
 -Path  "OU=Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com" `
 -SamAccountName  "steve" `
 -DisplayName "steve smith" `
 -AccountPassword (ConvertTo-SecureString "Inno123$" -AsPlainText -Force) `
 -ChangePasswordAtLogon $true  `
 -Enabled $true; 