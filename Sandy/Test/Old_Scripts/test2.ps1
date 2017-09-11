$csv = 'C:\Users\Administrator\Desktop\Test\innominds.csv'
$ou  = 'OU=Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com'

Import-Csv $csv | ForEach-Object {
    $user =  $_.firstname
    $userName1 = $_.firstname.Substring(0,1) + $_.lastname
    #$CN  = $_.firstname +" "+ $_.lastname
    $upn = "@corp"+"."+"innominds"+"."+"com"
   # $cname = Get-ADUser -filter { CN -eq $CN } | measure
    

    $CN = $_.firstname +" "+ $_.lastname    
    for($j=0; $j -le 5 ; $j++){
        $cname = Get-ADUser -filter { CN -eq $CN } | measure
        if($cname.Count -gt 0){
            $CN = $_.firstname +" "+ $_.lastname + ($j+1)
        }
       
    }


    for($i=1; $i -le $user.length; $i++){
        $userName = $_.firstname.Substring(0,$i) + $_.lastname
        $sann = Get-ADUser -filter { SamAccountName -eq $userName } | measure
        if($sann.Count -gt 0){
            
            $userName1 = $_.firstname.Substring(0,$i+1) + $_.lastname
        }
    }


     Write-Output $CN
     Write-Output $userName1
     $pwd = "Inno@1234"
     $pw   = ConvertTo-SecureString $pwd -AsPlainText -Force
    New-ADUser -Name $CN `
    -SamAccountName $userName1 `
    -GivenName $_.firstname `
    -Surname $_.lastname `
    -Path $ou `
    -AccountPassword $pw `
    -Enabled $true `
    -ChangePasswordAtLogon $true `
    -PassThru `
    -UserPrincipalName $userName1$upn
}