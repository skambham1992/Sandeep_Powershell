#$IDs = Import-Csv -Path c:\ADTerm.csv | Select-object -ExpandProperty EmployeeID
$san = "jrenner"
        
        Get-ADUser -filter { SamAccountName -eq $san } | Disable-ADAccount

        #Write-Output $result
        Write-Output "sucess"