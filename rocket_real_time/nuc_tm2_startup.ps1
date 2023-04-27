
Add-Type -AssemblyName System.Windows.Forms

Add-Type @"
using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

public struct RECT
{
    public int left;
    public int top;
    public int right;
    public int bottom;
}

public class pInvoke
{
    [DllImport("user32.dll", SetLastError = true)]
    public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);

    [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall, ExactSpelling = true, SetLastError = true)]
    public static extern bool GetWindowRect(IntPtr hWnd, ref RECT rect);
}
"@


function Move-Window-Putty([System.IntPtr]$WindowHandle, [switch]$Top, [switch]$Bottom, [switch]$Left, [switch]$Right) {
  # get the window bounds
  $rect = New-Object RECT
  [pInvoke]::GetWindowRect($WindowHandle, [ref]$rect)

  # get which screen the app has been spawned into
  $activeScreen = [System.Windows.Forms.Screen]::FromHandle($WindowHandle).Bounds

	$posX = 1650
	$posY = 200

  [pInvoke]::MoveWindow($putty_win.MainWindowHandle, $posX, $posY, $rect.right - $rect.left, $rect.bottom - $rect.top, $true)
}


# New-BurntToastNotification -Text "Running nuc_tm2_startup"

$wshell = New-Object -ComObject "WScript.Shell"

# start putty
Write-Host "Starting PuTTY..."
$putty_win = Start-Process "C:\Program Files (x86)\putty.exe" -PassThru
start-sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("%{e}telnet{TAB}")
start-sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
start-sleep -Seconds 2
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}listusedchs{ENTER}")
start-sleep -Seconds 1

Move-Window-Putty -WindowHandle $putty_win.MainWindowHandle 

[System.Windows.Forms.SendKeys]::SendWait("/stx preparetransfer{ENTER}")
[System.Windows.Forms.SendKeys]::SendWait("ch 7{ENTER}")
[System.Windows.Forms.SendKeys]::SendWait("ch 8{ENTER}")
[System.Windows.Forms.SendKeys]::SendWait("/etx{ENTER}")

# start the IDL program
start-sleep -Seconds 1
(New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Name "idlde").MainWindowTitle)
start-sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("^i")
start-sleep -Milliseconds 200
[System.Windows.Forms.SendKeys]::SendWait("rocket_eve_tm2_real_time_display,/domegsa,/domegsb{ENTER}")
start-sleep -Seconds 20

# start the TM2 transfer
(New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Name "putty").MainWindowTitle)
start-sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("starttransfer 8002{ENTER}")
start-sleep -Seconds 3
(New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Name "putty").MainWindowTitle)
start-sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("setmode 1{ENTER}")
start-sleep -Seconds 1
(New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Name "putty").MainWindowTitle)
start-sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("setasynctimestamps off{ENTER}")
start-sleep -Seconds 1
(New-Object -ComObject WScript.Shell).AppActivate((Get-Process -Name "putty").MainWindowTitle)
start-sleep -Milliseconds 500
[System.Windows.Forms.SendKeys]::SendWait("startacq{ENTER}")
start-sleep -Seconds 3

New-BurntToastNotification -Text "nuc_tm2_startup DONE"

start-sleep -Seconds 3
