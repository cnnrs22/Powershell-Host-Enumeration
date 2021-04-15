#This script will get the local admins of a machine
Get-LocalGroupMember -group Administrators | Select-Object Name,SID