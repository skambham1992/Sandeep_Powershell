Function Test-ADObject {
[CmdletBinding()]
Param(
  [Parameter(Mandatory=$true,Position=0)]
  [string[]]$Name,
  [Parameter(Mandatory=$true,Position=1)]
  [ValidateSet("User","Group","Computer","organizationalUnit")]
  [string]$Type
)
}
foreach($ObjName in $Name) {
  $OutputObj = New-Object -TypeName PSObject -Property @{
        Name = $ObjName;
        IsFound = $null;
        ObjectClass = $Type }
  try {
    $ObjOut = @(Get-ADObject -Filter { Name -eq $ObjName -and  ObjectClass -eq $Type } -EA Stop)

    if($ObjOut.count -eq 0) {
      $OutputObj.IsFound = $false
    }

    if($ObjOut.Count -gt 1) {
      $OutputObj.IsFound = $false
      Write-Verbose "Multiple objects found with the name  $ObjName"
    }

    if($ObjOut.Count -eq 1) {
      $OutputObj.IsFound = $true
    }
  } catch {
    $OutputObj.IsFound = $false
  }
  $OutputObj | select Name, ObjectClass,...
}
  