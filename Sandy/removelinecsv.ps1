#Get-Content "C:\Users\Administrator\Desktop\Sandeep_test\Employees.csv" | ForEach-Object { $_.Trim() } 

$file = "C:\Users\Administrator\Desktop\Sandeep_test\Employees.csv"
$NewUser = "hee"
$NewUser = "hooo"
$a = (Get-Date)
<#(Get-Content $file | Select-Object -Skip 1) | Set-Content $file 



$filedata = import-csv $file -Header FirstName , Password
$filedata | export-csv $file -NoTypeInformation  
(Get-Content $file) | Foreach-Object {$_ -replace '"', ''}|Out-File $file #>


#(Get-Content $file) | where {$_ -notmatch 'danger'} | Set-Content $file

$NewLine = "{0},{1}" -f $NewUser,$NewUser
$NewLine | add-content -path $file | Sort-Object { [datetime]  $a } -Descending


