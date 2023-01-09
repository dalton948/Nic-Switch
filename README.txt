##########################
Read me for NIC_Switch.ps1
##########################

Purpose:
Simplify NIC resets

How to use:
1. Launch script (need to have a powershell window thats signed into Vsphers.)
2. Enter the server that you restarting the NIC on.
3. VM Console window Opens, use this to verify that the VM has successfully been restarted.
	- You do not want to start the NIC until the server is fully back up.
4. Once the server is back up, you will type Y when asked to switch the NIC back on.
5. RDP session is created, log in and confirm network connectivity.
	- Sign out afterwards.

What is the Script doing?
1. Gets the VM name provided by the user.
2. Switches the NIC off.
3. Restarts the VM
4. Turns the NIC back on after the user's confirmation that the VM is back up.
5. Opens a RDP session to confirm network connectivity.