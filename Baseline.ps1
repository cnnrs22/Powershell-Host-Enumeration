# This script will baseline a system

$Network=(Get-NetIPAddress | Select-Object -Property Name,IPv4Address) | Format-List

$CompInfo=(Get-ComputerInfo | Select-Object -Property WindowsProductName,WindowsVersion,CsName,CsUsername,CsSystemType,OsBuildNumber,OsLocalDateTime,Timezone,OsNumberofProcesses,OsNumberOfUsers,CsNetworkAdapters | Format-List)
#could use get-wmiobject -Class Win32_ComputerSystem for basic details. 

$InstalledApps=(Get-WmiObject win32_product | Select-Object -Property Name)
"Network",$Network,"Computer Info",$CompInfo,"Installed Apps",$InstalledApps | out-file ./baseline.txt

"============"
"Baseline Computer info"
"============"
$CompInfo


<#This was a function that formats the time zone but it looks fine
function tz{
    $tz=Get-TimeZone
    $tz.ToString()
}
The timezone is:" 
tz
#>

"============"
"Network Info:"
"============"
$Network

"============"
"Installed Products"
"============"
$InstalledApps

