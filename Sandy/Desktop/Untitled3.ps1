# Put picture part here.
 50         $filename = "$($user.SamAccountName).jpg"
 51         Write-Output $filename
 52 
 53         if (test-path -path $filename)
 54             {
 55                 Write-Output "Found picture for $($user.SamAccountName)"
 56 
 57                 $photo = [byte[]](Get-Content $filename -Encoding byte)
 58                 Set-ADUser $($user.SamAccountName) -Replace @{thumbnailPhoto=$photo} 
 59           