$Processes = Get-Process #Set processes variable

$procArray=@() #Create an Empty Array

#Loop to add custom objects
foreach ($p in $Processes){
$ProcObj = New-Object PSCustomObject -Property @{
    ProcessName = $p.name
    PID = $p.id
    Start = $p.Starttime
    Description = $p.Description
    Path = $p.path

#Optional Extras, uncomment if required
#    Modules = $p.Modules
    HandleCount = $p.handlecount

  }
    $ProcArray += $ProcObj #add the objects to the array
}

write-output $procarray | Format-list     #display on screen
