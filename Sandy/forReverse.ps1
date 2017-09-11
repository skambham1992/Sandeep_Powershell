$sort =  "C:\Users\Administrator\Desktop\testingcsv.csv"
$sorted = Import-Csv $sort | Sort-Object Date –Descending 
$sorted | Export-csv -NoTypeInformation $sort
 Write-Output $sorted