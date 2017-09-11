$csv = 'C:\Users\Administrator\Desktop\trail.csv'
$ou  = 'OU=Users,OU=VizagIncubation,DC=corp,DC=innominds,DC=com'
Add-Type -AssemblyName System.Web


Import-Csv $csv | ForEach-Object {


    $user =  $_.firstname
	$firstName=$_.firstname
	$middleName=$_.middlename
	$lastName=$_.lastname
	
    $userName1 = $_.firstname.Substring(0,1) + $_.lastname
    $upn = "@corp"+"."+"innominds"+"."+"com"
  
    if([string]::IsNullOrEmpty($middleName) ){
		write-output "string is null"
		$CNFromForm=$firstName+" "+$lastName
		
	}else{
		$CNFromForm=$firstName+" "+$middleName+" "+$lastName
	}
	$CN=$CNFromForm
    for($j=0; $j -le 5 ; $j++){
        $cname = Get-ADUser -filter { CN -eq $CN } | measure
        if($cname.Count -gt 0){
            $CN = $CNFromForm + ($j+1)
        }
       
    }


    for($i=1; $i -le $user.length; $i++){
        $userName = $_.firstname.Substring(0,$i) + $_.lastname
        $sann = Get-ADUser -filter { SamAccountName -eq $userName } | measure
        if($sann.Count -gt 0){
            
            $userName1 = $_.firstname.Substring(0,$i+1) + $_.lastname
        }
    }
    
	$pwd = [System.Web.Security.Membership]::GeneratePassword(10,2)
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
    -UserPrincipalName $userName1$upn`
	
	
	write-output $CN
	write-output $userName1

}




	

	

