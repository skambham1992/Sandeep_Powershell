
$csv = "C:\Users\Administrator\Desktop\Sandeep_test\Employees.csv" 
$employees = @(

  [pscustomobject]@{

  FirstName = 'Adam'

  Password  = 'Bertram'

  #Email  = 'trump'
}

  )

  $employees | 
    ConvertTo-Csv -NoTypeInformation  |
	Select -Skip 1 |
	ForEach-Object { $_ -replace '"' } |
	Out-File $csv -Encoding Unicode -Append