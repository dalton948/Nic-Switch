<# Script made by 
 .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .-----------------.
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| |  ________    | || |      __      | || |   _____      | || |  _________   | || |     ____     | || | ____  _____  | |
| | |_   ___ `.  | || |     /  \     | || |  |_   _|     | || | |  _   _  |  | || |   .'    `.   | || ||_   \|_   _| | |
| |   | |   `. \ | || |    / /\ \    | || |    | |       | || | |_/ | | \_|  | || |  /  .--.  \  | || |  |   \ | |   | |
| |   | |    | | | || |   / ____ \   | || |    | |   _   | || |     | |      | || |  | |    | |  | || |  | |\ \| |   | |
| |  _| |___.' / | || | _/ /    \ \_ | || |   _| |__/ |  | || |    _| |_     | || |  \  `--'  /  | || | _| |_\   |_  | |
| | |________.'  | || ||____|  |____|| || |  |________|  | || |   |_____|    | || |   `.____.'   | || ||_____|\____| | |
| |              | || |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' 
 let me know if you have any questions
 #>

Write-host "
 _   _ _____ _____   _____          _ _       _      
| \ | |_   _/  __ \ /  ___|        (_) |     | |     
|  \| | | | | /  \/ \ `--.__      ___| |_ ___| |__   
| . ` | | | | |      `--. \ \ /\ / / | __/ __| '_ \  
| |\  |_| |_| \__/\ /\__/ /\ V  V /| | || (__| | | | 
\_| \_/\___/ \____/ \____/  \_/\_/ |_|\__\___|_| |_|                                                                                                          
"


#Get Server
$server = Read-Host "Please enter the server name"

Write-host "Starting VM Console Window. Use this to verify the server has restarted fully."

#Opens a VM Console window so that users can confirm when the VM has fully restarted
GET-VM $server | open-VMConsoleWindow

Write-Host "
Switching NIC off.
"

#Turning the NIC Off  
GET-VM $server | Get-NetworkAdapter | Set-NetworkAdapter -Connected:$false -StartConnected:$false -confirm:$false

Write-Host " 
Restarting Server
"

#restarting the server specified at the start
GET-VM $server | restart-VM -confirm:$false

#Looping until the VM has successfully been powered back on from the restart.
do {
    $powerstate = get-vm $server | Select-Object PowerState -ExpandProperty *power*
    start-sleep -s 3
    Write-Host $powerstate
} until ($powerstate -eq "PoweredOn")

Write-Host "
Please confrim via the Console Window that the VM has fully booted up before starting the NIC" -ForegroundColor cyan 

#Looping until the user enters Y to turn the NIC back on
do {
    $vmstatuscheck = Read-Host "Are you ready to turn the NIC back on? Y/N".ToUpper()
} until ($vmstatuscheck -eq "Y")

Write-Host "
Switching NIC back on"

#turning the NIC back on
GET-VM $server | Get-NetworkAdapter | Set-NetworkAdapter -Connected:$true -StartConnected:$true -confirm:$false

Write-Host "
Confirming issue resolved with an RDP session"

#opening a RDP session to confirm network connectivity
Start-Process "$env:windir\system32\mstsc.exe" -ArgumentList /v:$server

exit
