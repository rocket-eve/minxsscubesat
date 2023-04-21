
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

function Move-Window-DataView([System.IntPtr]$WindowHandle, [switch]$Top, [switch]$Bottom, [switch]$Left, [switch]$Right) {
  # get the window bounds
  $rect = New-Object RECT
  [pInvoke]::GetWindowRect($WindowHandle, [ref]$rect)

  # get which screen the app has been spawned into
  $activeScreen = [System.Windows.Forms.Screen]::FromHandle($WindowHandle).Bounds

	$posX =1950
	$posY = 100
	$width = 1200
	$height = 780
  [pInvoke]::MoveWindow($app.MainWindowHandle, $posX, $posY, $width, $height, $true)
}

function Move-Window-Putty([System.IntPtr]$WindowHandle, [switch]$Top, [switch]$Bottom, [switch]$Left, [switch]$Right) {
  # get the window bounds
  $rect = New-Object RECT
  [pInvoke]::GetWindowRect($WindowHandle, [ref]$rect)

  # get which screen the app has been spawned into
  $activeScreen = [System.Windows.Forms.Screen]::FromHandle($WindowHandle).Bounds

	$posX =3150
	$posY = 100

  [pInvoke]::MoveWindow($app.MainWindowHandle, $posX, $posY, $rect.right - $rect.left, $rect.bottom - $rect.top, $true)
}

function Move-Window-Powershell([System.IntPtr]$WindowHandle, [switch]$Top, [switch]$Bottom, [switch]$Left, [switch]$Right) {
	$posX =2895
	$posY = 540
	$width = 800
	$height = 400

  [pInvoke]::MoveWindow($app.MainWindowHandle, $posX, $posY, $width, $height, $true)
}

function Set-WindowState {
param(
    [Parameter()]
    [ValidateSet('FORCEMINIMIZE', 'HIDE', 'MAXIMIZE', 'MINIMIZE', 'RESTORE', 
                 'SHOW', 'SHOWDEFAULT', 'SHOWMAXIMIZED', 'SHOWMINIMIZED', 
                 'SHOWMINNOACTIVE', 'SHOWNA', 'SHOWNOACTIVATE', 'SHOWNORMAL')]
    [Alias('Style')]
    [String] $State = 'SHOW',
    
    [Parameter(ValueFromPipelineByPropertyname='True')]
    [System.IntPtr] $MainWindowHandle = (Get-Process –id $pid).MainWindowHandle,

    [Parameter()]
    [switch] $PassThru

)
BEGIN
{

$WindowStates = @{
    'FORCEMINIMIZE'   = 11
    'HIDE'            = 0
    'MAXIMIZE'        = 3
    'MINIMIZE'        = 6
    'RESTORE'         = 9
    'SHOW'            = 5
    'SHOWDEFAULT'     = 10
    'SHOWMAXIMIZED'   = 3
    'SHOWMINIMIZED'   = 2
    'SHOWMINNOACTIVE' = 7
    'SHOWNA'          = 8
    'SHOWNOACTIVATE'  = 4
    'SHOWNORMAL'      = 1
}
    
$Win32ShowWindowAsync = Add-Type -memberDefinition @" 
[DllImport("user32.dll")] 
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow); 
"@ -name “Win32ShowWindowAsync” -namespace Win32Functions –passThru

}
PROCESS
{
    $Win32ShowWindowAsync::ShowWindowAsync($MainWindowHandle, $WindowStates[$State]) | Out-Null
    Write-Verbose ("Set Window State on '{0}' to '{1}' " -f $MainWindowHandle, $State)

    if ($PassThru)
    {
        Write-Output $MainWindowHandle
    }

}
END
{
}

}

Set-Alias -Name 'Set-WindowStyle' -Value 'Set-WindowState'

function Get-ChildWindow{
[CmdletBinding()]
param (
    [Parameter(ValueFromPipeline = $true, ValueFromPipelinebyPropertyName = $true)]
    [ValidateNotNullorEmpty()]
    [System.IntPtr]$MainWindowHandle
)

BEGIN{
    function Get-WindowName($hwnd) {
        $len = [apifuncs]::GetWindowTextLength($hwnd)
        if($len -gt 0){
            $sb = New-Object text.stringbuilder -ArgumentList ($len + 1)
            $rtnlen = [apifuncs]::GetWindowText($hwnd,$sb,$sb.Capacity)
            $sb.tostring()
        }
    }

    if (("APIFuncs" -as [type]) -eq $null){
        Add-Type  @"
        using System;
        using System.Runtime.InteropServices;
        using System.Collections.Generic;
        using System.Text;
        public class APIFuncs
          {
            [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
            public static extern int GetWindowText(IntPtr hwnd,StringBuilder lpString, int cch);

            [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)]
            public static extern IntPtr GetForegroundWindow();

            [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)]
            public static extern Int32 GetWindowThreadProcessId(IntPtr hWnd,out Int32 lpdwProcessId);

            [DllImport("user32.dll", SetLastError=true, CharSet=CharSet.Auto)]
            public static extern Int32 GetWindowTextLength(IntPtr hWnd);

            [DllImport("user32")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool EnumChildWindows(IntPtr window, EnumWindowProc callback, IntPtr i);
            public static List<IntPtr> GetChildWindows(IntPtr parent)
            {
               List<IntPtr> result = new List<IntPtr>();
               GCHandle listHandle = GCHandle.Alloc(result);
               try
               {
                   EnumWindowProc childProc = new EnumWindowProc(EnumWindow);
                   EnumChildWindows(parent, childProc,GCHandle.ToIntPtr(listHandle));
               }
               finally
               {
                   if (listHandle.IsAllocated)
                       listHandle.Free();
               }
               return result;
           }
            private static bool EnumWindow(IntPtr handle, IntPtr pointer)
           {
               GCHandle gch = GCHandle.FromIntPtr(pointer);
               List<IntPtr> list = gch.Target as List<IntPtr>;
               if (list == null)
               {
                   throw new InvalidCastException("GCHandle Target could not be cast as List<IntPtr>");
               }
               list.Add(handle);
               //  You can modify this to check to see if you want to cancel the operation, then return a null here
               return true;
           }
            public delegate bool EnumWindowProc(IntPtr hWnd, IntPtr parameter);
           }
"@
        }
}

PROCESS{
    foreach ($child in ([apifuncs]::GetChildWindows($MainWindowHandle))){
        Write-Output (,([PSCustomObject] @{
            MainWindowHandle = $MainWindowHandle
            ChildId = $child
            ChildTitle = (Get-WindowName($child))
        }))
    }
}
}

clear

Write-Host "======== DO NOT INTERACT WITH DISPLAY UNTIL FINISHED MESSAGE APPEARS ========"
start-sleep -s 5
Write-Host "Closing PuTTY"
start-sleep 1
stop-process -Name PuTTY
start-sleep 1

Write-Host "Closing DataViewPC"
start-sleep 1
(New-Object -ComObject WScript.Shell).AppActivate((get-process -name "DataViewPC Serial V5.4.6").MainWindowTitle)
start-sleep 1
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait("%{f}x")
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
start-sleep 2

Write-Host "Closing X55 IDL Display"
start-sleep 1
(New-Object -ComObject WScript.Shell).AppActivate((get-process -name "idlde").MainWindowTitle)
[System.Windows.Forms.SendKeys]::SendWait("^{c}")
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait(".reset{ENTER}")
start-sleep 2

Write-Host "Closing Hydra"
start-sleep 1
$x = 1200
$y = 900
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
start-sleep 3
$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);cmd_hw tlmOutFile rollover
[System.Windows.Forms.SendKeys]::SendWait("cmd_hw tlmOutFile rollover{ENTER}")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("^{w}")

start-sleep 1
$x = 800
$y = 600
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
start-sleep 3
$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
[System.Windows.Forms.SendKeys]::SendWait("cmd_hw tlmOutFile rollover{ENTER}")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("^{w}")
Write-Host "======== TEARDOWN FINISHED ========"