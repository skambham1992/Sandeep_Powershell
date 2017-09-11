$csv = 'C:\Users\Administrator\Desktop\Test\ADUserDisable.csv'
Import-Csv $csv	| ForEach-Object {
		
$san = $_.username
#Write-Output $san
        
        #Get-ADUser -filter { SamAccountName -eq $san } | Disable-ADAccount
		
		Disable-ADAccount -Identity $san
}

        
        Write-Output $san" is successfully disabled."