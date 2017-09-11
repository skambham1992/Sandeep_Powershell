$csv = 'Inno_demo.csv'
$ou  = 'OU=Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com'


Import-Csv $csv | ForEach-Object {
  $user = ($_.firstname +' '+ $_.lastname)
  $users = Get-ADUser -filter { CN -eq $user } | measure
  
  
  $userCount = $users.Count
   if(($userCount -eq 0) ){
        $CN = ($_.firstname +" " + $_.lastname)
        $name = ($_.firstname.Substring(0,3) + $_.lastname)
        $sann = Get-ADUser -filter { SamAccountName -eq $name } | measure
        $sannCount = $sann.Count
        $sannCountinc =  $sann.Count + 1
        Write-Output $sann
        $pwd = "Inno@1234"
      if($sannCount -gt 0){
             $name = ($_.firstname.Substring(0,$sannCountinc) + $_.lastname)

             $pw   = ConvertTo-SecureString $pwd -AsPlainText -Force
            
             New-ADUser -Name $CN `
            -SamAccountName $name `
            -GivenName $_.firstname `
            -Surname $_.lastname `
            -Path $ou `
            -AccountPassword $pw `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -PassThru
     }
     else{
            
            $name = ($_.firstname.Substring(0,1) + $_.lastname)
         $pw   = ConvertTo-SecureString $pwd -AsPlainText -Force
         
         New-ADUser -Name $CN `
         -SamAccountName $name `
        -GivenName $_.firstname `
        -Surname $_.lastname `
        -Path $ou `
        -AccountPassword $pw `
        -ChangePasswordAtLogon $true `
        -PassThru
     }
       
        }
    
    else {
        $upn = "@corp"+"."+"innominds"+"."+"com"
        
       # $CN = '{0} {1}' -f $_.firstname, $_.lastname
       $CN = ($_.firstname +" " + $_.lastname)
        
        $name = ($_.firstname.Substring(0,3) + $_.lastname)
        
        $pwd = "Inno@1234"
         $pw   = ConvertTo-SecureString $pwd -AsPlainText -Force
         
         New-ADUser -Name $CN `
         -SamAccountName $name `
        -GivenName $_.firstname `
        -Surname $_.lastname `
        -Path $ou `
        -AccountPassword $pw `
        -Enabled $true `
        -ChangePasswordAtLogon $true `
        -PassThru
    }
}