#this script gets all security event logs based on the time and event id a user inputs.

#Basic One-Liner
#Get-EventLog security | Where-Object {($_.InstanceID -eq 4634) -or ($_.InstanceID -eq 4624)} | Select-Object Index,TimeGenerated,MachineName,Username | ft

#Set a variable so it doesn't get all event logs
$userbegindate = Read-Host `
'Enter the date you wish to start your search in format DD/MM/YYYY HH:MM:SS (or just DD/MM):'
$userenddate = Read-Host `
'Enter the date you wish to finish your search in format DD/MM/YYYY HH:MM:SS (or just DD/MM):'
#Set the eventlog id based on user input (4624 for login)
$userevtid = Read-Host `
'Enter the event ID you are looking for:'

$begin = Get-Date -Date $userbegindate
$end = Get-Date -Date $userenddate

#search query
$evtlog = Get-EventLog Security -After $begin -Before $end | Where-Object {($_.InstanceID -eq $userevtid)}

#creating empty array and starting loop
$evtlogarray=@()
foreach ($e in $evtlog){
$EvtObj = New-Object PSCustomObject -Property @{
    EventId = $e.InstanceID 
    Time = $e.timegenerated
    MachineID = $e.MachineName
    #User = $e.UserName
    Message = $e.Message

   }
#adding objects to array
    $evtlogarray += $evtobj

}

#write to screeen, could also export if wanted
write-output $evtlogarray | ft Time,EventId,MachineID,Message -AutoSize 
