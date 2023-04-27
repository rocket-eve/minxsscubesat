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

function Move-Window-Stop([System.IntPtr]$WindowHandle, [switch]$Top, [switch]$Bottom, [switch]$Left, [switch]$Right) {
  # get the window bounds
  $rect = New-Object RECT
  [pInvoke]::GetWindowRect($WindowHandle, [ref]$rect)

  # get which screen the app has been spawned into
  $activeScreen = [System.Windows.Forms.Screen]::FromHandle($WindowHandle).Bounds

	$posX =0
	$posY = 0
	$width = 600
	$height = 400
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

function Move-Window-EXE([System.IntPtr]$WindowHandle, [switch]$Top, [switch]$Bottom, [switch]$Left, [switch]$Right) {
  # get the window bounds
  $rect = New-Object RECT
  [pInvoke]::GetWindowRect($WindowHandle, [ref]$rect)

  # get which screen the app has been spawned into
  $activeScreen = [System.Windows.Forms.Screen]::FromHandle($WindowHandle).Bounds

	$posX =0
	$posY = 0
	$width = 600
	$height = 400
  [pInvoke]::MoveWindow($app.MainWindowHandle, $posX, $posY, $width, $height, $true)
}

clear
Write-Host "!=== DO NOT INTERACT WITH DISPLAY UNTIL FINISHED MESSAGE APPEARS ===!"
$app = Get-Process -name "Set_XRS_X55_PicoSIM_Time"
Move-Window-EXE -WindowHandle $app.MainWindowHandle 

$app = get-process -name "DataViewPC Serial V5.4.6"
Move-Window-DataView -WindowHandle $app.MainWindowHandle 

Write-Host "Setting XRS+X55 Time"
start-sleep 1

(New-Object -ComObject WScript.Shell).AppActivate((get-process -name "DataViewPC Serial V5.4.6").MainWindowTitle)
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait("%{w}1{ENTER}")
start-sleep 1
$x = 1980
$y = 300
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
start-sleep 1
$signature=@'
[DllImport("user32.dll",CharSet=CharSet.Auto,CallingConvention=CallingConvention.StdCall)]
public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
'@
$SendMouseClick = Add-Type -memberDefinition $signature -name "Win32MouseEventNew" -namespace Win32Functions -passThru

$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
start-sleep 2

[System.Windows.Forms.SendKeys]::SendWait("{r}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{r}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("%{+}")
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
$x = 2100
$y = 775
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
start-sleep 1
$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000008, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000010, 0, 0, 0, 0);

[System.Windows.Forms.SendKeys]::SendWait("{X}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{TAB}{TAB}")
start-sleep .5

$gpstime = (New-TimeSpan -Start (Get-Date "01/06/1980") -End (Get-Date).ToUniversalTime()).TotalSeconds + 18

[System.Windows.Forms.SendKeys]::SendWait($gpstime)
start-sleep .1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}{ENTER}")

Write-Host "Setting XRS+X55 Time"
start-sleep 1
$x = 1980
$y = 300
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
start-sleep 2

[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep .5

$x = 2100
$y = 775
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
start-sleep 1
$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000008, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000010, 0, 0, 0, 0);
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait("{X}")
start-sleep .5
[System.Windows.Forms.SendKeys]::SendWait("{TAB}{TAB}")
start-sleep .5

$gpstime = (New-TimeSpan -Start (Get-Date "01/06/1980") -End (Get-Date).ToUniversalTime()).TotalSeconds + 18

[System.Windows.Forms.SendKeys]::SendWait($gpstime)
start-sleep .1
[System.Windows.Forms.SendKeys]::SendWait("{TAB}{ENTER}")
start-sleep 1

$x = 1980
$y = 300
[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
start-sleep 1
$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
start-sleep 1

[System.Windows.Forms.SendKeys]::SendWait("{r}")
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait("{r}")
start-sleep 1
$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait("%{-}%{-}")
start-sleep 1
$SendMouseClick::mouse_event(0x00000002, 0, 0, 0, 0);
$SendMouseClick::mouse_event(0x00000004, 0, 0, 0, 0);
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait("{s}")
start-sleep 1
[System.Windows.Forms.SendKeys]::SendWait("%{w}4{ENTER}")

Write-Host "!============================ FINISHED =============================!"584
start-sleep 2