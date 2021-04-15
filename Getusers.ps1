Get-WmiObject -class Win32_UserAccount | Select-Object -Property name,accounttype,status,domain | format-table -AutoSize
