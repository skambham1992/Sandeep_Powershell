Import-Module Activedirectory
$newusers = @("steve","ned.stark01","tyron.lannister")

foreach ($st in $Users)
{
if (Get-aduser $newuser)
    {
     write-host "$newuser already exists"
    }
else
    {
    New-aduser -samaccountname $newuser
    }
}