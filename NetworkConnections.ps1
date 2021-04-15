#This script will get network connections that dont match 0.0.0.0 or 127.0.0.1 or ::

#Set NetConns Variable and filter out sessions where the IP doesn't exist
$NetConns = get-nettcpconnection | Where-Object remoteaddress -notlike "0.0.0.0" | 
Where-Object RemoteAddress -NotLike "::1" | Where RemoteAddress -NotLike "::" 

<# 
Add this in if you want to get rid of localhost (CobaltStrike Beacon manipulates by listening on localhost though)

| Where RemoteAddress -NotLike "127.0.0.1" 

#>

$NetArray = @() # create empty array
foreach ($n in $NetConns){
$NetObj = New-Object PSCustomObject -Property @{
    OwningProcess = $n.OwningProcess
    LocalPort = $n.LocalPort
    LocalAddr = $n.LocalAddress
    RemotePort = $n.RemotePort
    RemoteAddr = $n.RemoteAddress
    State = $n.State
    }

    $NetArray += $NetObj

}

#formatty things to sort by established first followed by local IP. 
Write-Output $NetArray | Sort -Property State,LocalAddr | ft State,OwningProcess,LocalAddr,LocalPort,RemoteAddr,RemotePort -AutoSize


