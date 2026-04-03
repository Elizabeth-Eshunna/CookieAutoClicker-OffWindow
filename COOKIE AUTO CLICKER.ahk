
#MaxHotkeysPerInterval 10000
#SingleInstance, Force
SetBatchLines, -1
ListLines, Off
SetControlDelay, -1
CoordMode, Mouse, Client
SetTitleMatchMode, 2
DetectHiddenWindows, On

; --- Hardcoded Startup Settings ---
Target_Window := "Cookie Clicker" ; Adjust this to your exact window title
Click_Delay   := 1
X1            := 271
Y1            := 394
Pos_1         := "271 394"
; ----------------------------------

global Clicker_Is_On := 0
Gui, +AlwaysOnTop

; Window Setup
Gui, Add, Button, x10 y10 w80 h20 gSet_Location, Set Window
Gui, Add, Edit, x+10 w180 h20 vTarget_Window, % Target_Window

; Position Setup (Editable)
Gui, Add, Button, x10 y+10 w80 h20 gSet_Pos_1, Set Pos
Gui, Add, Edit, x+10 w120 h20 vPos_1 gSubmit_All, % Pos_1

; Controls
Gui, Add, Button, x10 y+20 w130 h30 gStart_Clicker, Start ( [ )
Gui, Add, Button, x+10 w130 h30 gStop_Clicker, Stop ( ] )

; Utility
Gui, Add, Button, x10 y+10 w130 h30 gHide_Window, Hide Window
Gui, Add, Button, x+10 w130 h30 gShow_Window, Show Window

; Legend
Gui, Add, Text, cBlue x10 y+10, Start Key: [
Gui, Add, Text, cBlue x+10, Stop Key: ]
Gui, Add, Text, cRed x10, Hide: Numpad 3 | Show: Numpad 4

Gui, Show, w300 h210, Cookie Auto Clicker
return

GuiClose:
    WinShow, %Target_Window%
ExitApp

; --- Hotkeys ---
[::
Start_Clicker:
    if (Clicker_Is_On)
        return
    Clicker_Is_On := 1
    SetTimer, ClickLoop, %Click_Delay%
return

]::
Stop_Clicker:
    Clicker_Is_On := 0
    SetTimer, ClickLoop, Off
return

; --- The "Ghost" Clicking Logic ---
ClickLoop:
    ; We use PostMessage to click the specific X/Y coordinate.
    ; This is far less likely to "lock" your mouse than ControlClick.
    lParam := X1 | (Y1 << 16)
    PostMessage, 0x201, 1, %lParam%, , %Target_Window% ; WM_LBUTTONDOWN
    PostMessage, 0x202, 0, %lParam%, , %Target_Window% ; WM_LBUTTONUP
return

; --- GUI Functions ---

Set_Location:
    ToolTip, Click on the game window ONCE to set it.
    KeyWait, LButton, D
    WinGetTitle, Target_Window, A
    GuiControl,, Target_Window, %Target_Window%
    KeyWait, LButton
    ToolTip
return

Submit_All:
    Gui, Submit, NoHide
    RegExMatch(Pos_1, "(\d+)\s+(\d+)", Match)
    X1 := Match1
    Y1 := Match2
return

Set_Pos_1:
    ToolTip, Click the cookie to set the coordinates.
    KeyWait, LButton, D 
    MouseGetPos, X1, Y1
    GuiControl,, Pos_1, %X1% %Y1%
    KeyWait, LButton 
    ToolTip
return

NumPad3::
Hide_Window:
    if (Target_Window != "")
        WinHide, %Target_Window%
return

NumPad4::
Show_Window:
    WinShow, %Target_Window%
return

*^Esc::
    WinShow, %Target_Window%
ExitApp
