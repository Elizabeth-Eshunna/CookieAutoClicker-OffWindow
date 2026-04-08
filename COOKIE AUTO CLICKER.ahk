#MaxHotkeysPerInterval 10000
#SingleInstance, Force
SetBatchLines, -1
ListLines, Off
SetControlDelay, -1
CoordMode, Mouse, Client
SetTitleMatchMode, 2
DetectHiddenWindows, On

; --- Hardcoded Startup Settings ---
Target_Window := "cookies - Cookie Clicker"
Click_Delay   := 0
X1            := 271
Y1            := 394
Pos_1         := "271 394"
; ----------------------------------

global Clicker_Is_On := 0
global Window_Is_Hidden := 0

Gui, +AlwaysOnTop -Theme

; Window Setup
Gui, Add, Button, x10 y10 w80 h20 gSet_Location, Set Window
Gui, Add, Edit, x+10 w180 h20 vTarget_Window, % Target_Window

; Position Setup
Gui, Add, Button, x10 y+10 w80 h20 gSet_Pos_1, Set Pos
Gui, Add, Edit, x+10 w120 h20 vPos_1 gSubmit_All, % Pos_1

; --- CLICKER STATUS BAR ---
Gui, Add, Progress, x10 y+5 w280 h40 BackgroundRed +cRed vStatusColor -Border, 100
Gui, Font, s10 Bold cBlack
Gui, Add, Text, xp yp wp hp Center +0x200 BackgroundTrans vStatusText, CLICKER STOPPED
Gui, Font, s8 Norm cBlack
Gui, Add, Button, x10 y+5 w280 h30 gToggle_Clicker, START / STOP CLICKING

; --- VISIBILITY STATUS BAR ---
Gui, Add, Progress, x10 y+5 w280 h40 BackgroundRed +cRed vVisColor -Border, 100
Gui, Font, s10 Bold cBlack
Gui, Add, Text, xp yp wp hp Center +0x200 BackgroundTrans vVisText, WINDOW SHOWN
Gui, Font, s8 Norm cBlack
Gui, Add, Button, x10 y+5 w280 h30 gToggle_Visibility, HIDE / SHOW WINDOW

Gui, Show, w300 h230, Cookie Auto Clicker
return

GuiClose:
    WinShow, %Target_Window%
ExitApp

; --- Toggle Clicking Logic (+) ---
NumpadAdd::
[:: 
Toggle_Clicker:
    Clicker_Is_On := !Clicker_Is_On 
    if (Clicker_Is_On) {
        GuiControl, +BackgroundGreen +cGreen, StatusColor
        GuiControl,, StatusText, CLICKER ONGOING
        SetTimer, ClickLoop, %Click_Delay%
    } else {
        GuiControl, +BackgroundRed +cRed, StatusColor
        GuiControl,, StatusText, CLICKER STOPPED
        SetTimer, ClickLoop, Off
    }
return

; --- Toggle Visibility Logic (-) ---
NumpadSub::
]::
Toggle_Visibility:
    Window_Is_Hidden := !Window_Is_Hidden
    if (Window_Is_Hidden) {
        ; Restore first in case it was minimized (PostMessage needs window to be 'open')
        WinRestore, %Target_Window%
        WinHide, %Target_Window%
        GuiControl, +BackgroundGreen +cGreen, VisColor
        GuiControl,, VisText, WINDOW HIDDEN
    } else {
        WinShow, %Target_Window%
        GuiControl, +BackgroundRed +cRed, VisColor
        GuiControl,, VisText, WINDOW SHOWN
    }
return

; --- The Clicking Logic ---
ClickLoop:
    lParam := X1 | (Y1 << 16)
    PostMessage, 0x201, 1, %lParam%, , %Target_Window% 
    PostMessage, 0x202, 0, %lParam%, , %Target_Window% 
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

*^Esc::
    WinShow, %Target_Window%
ExitApp#MaxHotkeysPerInterval 10000
#SingleInstance, Force
SetBatchLines, -1
ListLines, Off
SetControlDelay, -1
CoordMode, Mouse, Client
SetTitleMatchMode, 2
DetectHiddenWindows, On

; --- Hardcoded Startup Settings ---
Target_Window := "cookies - Cookie Clicker"
Click_Delay   := 0
X1            := 271
Y1            := 394
Pos_1         := "271 394"
; ----------------------------------

global Clicker_Is_On := 0
global Window_Is_Hidden := 0

Gui, +AlwaysOnTop -Theme

; Window Setup
Gui, Add, Button, x10 y10 w80 h20 gSet_Location, Set Window
Gui, Add, Edit, x+10 w180 h20 vTarget_Window, % Target_Window

; Position Setup
Gui, Add, Button, x10 y+10 w80 h20 gSet_Pos_1, Set Pos
Gui, Add, Edit, x+10 w120 h20 vPos_1 gSubmit_All, % Pos_1

; --- CLICKER STATUS BAR ---
Gui, Add, Progress, x10 y+20 w280 h40 BackgroundRed +cRed vStatusColor -Border, 100
Gui, Font, s10 Bold cBlack
Gui, Add, Text, xp yp wp hp Center +0x200 BackgroundTrans vStatusText, CLICKER STOPPED
Gui, Font, s8 Norm cBlack
Gui, Add, Button, x10 y+5 w280 h30 gToggle_Clicker, START / STOP CLICKING ( + )

; --- VISIBILITY STATUS BAR ---
Gui, Add, Progress, x10 y+15 w280 h40 BackgroundRed +cRed vVisColor -Border, 100
Gui, Font, s10 Bold cBlack
Gui, Add, Text, xp yp wp hp Center +0x200 BackgroundTrans vVisText, WINDOW SHOWN
Gui, Font, s8 Norm cBlack
Gui, Add, Button, x10 y+5 w280 h30 gToggle_Visibility, HIDE / SHOW WINDOW ( - )

; Legend
Gui, Add, Text, cBlue x10 y+10, Toggle Clicking: [+]  |  Toggle Visibility: [-]
Gui, Add, Text, cRed x10, Use [-] instead of minimizing to keep clicking!

Gui, Show, w300 h300, Cookie Auto Clicker
return

GuiClose:
    WinShow, %Target_Window%
ExitApp

; --- Toggle Clicking Logic (+) ---
NumpadAdd::
+:: 
Toggle_Clicker:
    Clicker_Is_On := !Clicker_Is_On 
    if (Clicker_Is_On) {
        GuiControl, +BackgroundGreen +cGreen, StatusColor
        GuiControl,, StatusText, CLICKER ONGOING
        SetTimer, ClickLoop, %Click_Delay%
    } else {
        GuiControl, +BackgroundRed +cRed, StatusColor
        GuiControl,, StatusText, CLICKER STOPPED
        SetTimer, ClickLoop, Off
    }
return

; --- Toggle Visibility Logic (-) ---
NumpadSub::
-::
Toggle_Visibility:
    Window_Is_Hidden := !Window_Is_Hidden
    if (Window_Is_Hidden) {
        ; Restore first in case it was minimized (PostMessage needs window to be 'open')
        WinRestore, %Target_Window%
        WinHide, %Target_Window%
        GuiControl, +BackgroundGreen +cGreen, VisColor
        GuiControl,, VisText, WINDOW HIDDEN
    } else {
        WinShow, %Target_Window%
        GuiControl, +BackgroundRed +cRed, VisColor
        GuiControl,, VisText, WINDOW SHOWN
    }
return

; --- The Clicking Logic ---
ClickLoop:
    lParam := X1 | (Y1 << 16)
    PostMessage, 0x201, 1, %lParam%, , %Target_Window% 
    PostMessage, 0x202, 0, %lParam%, , %Target_Window% 
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

*^Esc::
    WinShow, %Target_Window%
ExitApp
