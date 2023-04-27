
Add-Type -AssemblyName System.Windows.Forms

# stop IDL
Write-Host "Stopping IDL"

# first close the two MEGS plot windows:
(New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Name "idlde").id)
[System.Windows.Forms.SendKeys]::SendWait("%{F4}")
start-sleep -Milliseconds 100
(New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Name "idlde").id)
[System.Windows.Forms.SendKeys]::SendWait("%{F4}")
start-sleep -Milliseconds 100

# then stop the processing and reset the session
(New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Name "idlde").id)
start-sleep -Milliseconds 100
[System.Windows.Forms.SendKeys]::SendWait("^{i}")
start-sleep -Milliseconds 100
[System.Windows.Forms.SendKeys]::SendWait("^{c}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait(".reset_session{ENTER}")
start-sleep -Seconds 2

# stop transfer
Write-Host "Stopping transfer"
(New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Name "putty").ID)
start-sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait("stop{ENTER}")
start-sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("stoptransfer 8002{ENTER}")
start-sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("setmode 0{ENTER}")
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("exit{ENTER}")
start-sleep -Seconds 2


New-BurntToastNotification -Text "nuc_tm2_shutdown DONE"

