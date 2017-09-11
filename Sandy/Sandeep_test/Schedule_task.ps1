$taskName = "task schdued"
$user = "CORP\Administrator"
$password = "lockScreen!@99"
$DELAY = new-timespan -minutes 1
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-file C:\Users\Administrator\Desktop\mail_sleep.ps1"
$trigger = New-ScheduledTaskTrigger -Once -At "11:28 AM" -RandomDelay $DELAY
#$settings = New-ScheduledTaskSettingsSet `
                #-ExecutionTimeLimit ([TimeSpan]::FromHours(2)) `
                #-DeleteExpiredTaskAfter ([TimeSpan]::FromDays(60)) 
#$inputObject = New-ScheduledTask -Action $action -Trigger $trigger
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -User $user -Password $password