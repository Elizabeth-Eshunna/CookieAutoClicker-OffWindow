;Modified for cookie clicker only - Original Written By: Hellbent aka CivReborn
#MaxHotkeysPerInterval 10000
#SingleInstance,Force
SetBatchLines, 200ms
SetMouseDelay,-1
Coordmode,Mouse,Client
SetTitleMatchMode, 2
SetControlDelay -1
DetectHiddenWindows On

; --- Hardcoded Settings ---
Target_Window := "cookies - Cookie Baker"
Click_Delay   := 1
Loop_Clicker  := 1
Clicker_1     := 1
No_Clicks_1   := 1

; --- Default Coordinates (Editable) ---
X1            := 271
Y1            := 394
Pos_1         := "271   394"
; ------------------------

global Stop:=0, Clicker_Is_On:=0
Gui,+AlwaysOnTop


Gui,Add,Button,x10 y+15 w80 h20 gSet_Pos_1,Set Pos
Gui,Add,Edit,x+10 w120 h20 vPos_1 gSubmit_All, % Pos_1

Gui,Add,Button,x10 y+20 w120 h30 gHide_Window, Hide Window
Gui,Add,Button,x+10 w120 h30 gShow_Window,Show Window

Gui,Add,Button,x10 y+10 w120 h30 gStart_Clicker,Start
Gui,Add,Button,x+10 w120 h30 gStop_Clicker,Stop

Gui,Add,Text,cRed x10 y+10 ,Start = [
Gui,Add,Text,cBlue x+10 , Stop = ]
Gui,Add,Text,cRed x10 , Hide Window = Numpad 3
Gui,Add,Text,cBlue x+10 ,Show Window = Numpad 4

Gui,Show,w280 h180, Ghost Clicker 0.1
return

GuiClose:
try
	{
		WinShow,%Target_Window%
	}
	ExitApp

Hide_Window:
	NumPad3::
	if(Target_Window!="")
	WinHide,%Target_Window%
	return

Show_Window:
	NumPad4::
	WinShow,%Target_Window%
	return
	
Set_Location:
	Target_Window:=Set_Window(Target_Window)
	GuiControl,,Target_Window,% Target_Window	
	return

Update_Window:
	Gui,Submit,NoHide
	return
	
Submit_All:
	Gui,Submit,NoHide
    ; This parses the text box to update X1 and Y1 if you type manually
    RegExMatch(Pos_1, "(\d+)\s+(\d+)", Match)
    X1 := Match1
    Y1 := Match2
	return

Set_Pos_1:
	Stop:=1
	Get_Click_Pos(X1,Y1)		
	GuiControl,,Pos_1,%X1%   %Y1%	
	return

Start_Clicker:
	[::
	Run_Auto_Clicker()
	return

Stop_Clicker:
	]::
	Stop:=1
	return

Run_Auto_Clicker()
	{
		global
		Stop:=0
		if(Target_Window!="")
			{
				Clicker_Is_On:=1
				if(Loop_Clicker==1)
					{
						Loop
							{
								if(Stop==1)
									{
										Clicker_Is_On:=0
										return
									}
								if(Clicker_1==1)
									{
										Loop, % No_Clicks_1
											{
												if(Stop==1)
													{
														Clicker_Is_On:=0
														return
													}
												ControlClick,x%X1% y%Y1%,%Target_Window%,,,, NA x%X1% y%Y1%
												Sleep, %Click_Delay%
											}
									}
							}
					}
			}
	}

Get_Click_Pos(ByRef X,ByRef Y)
	{
		isPressed:=0,i:=0
		Loop
			{
				Left_Mouse:=GetKeyState("LButton")
				MouseGetPos,X,Y,
				ToolTip,Left Click Your Target Location To Set It  `n`nCurrent Location: `nX = %X%`nY = %Y% 
				if(Left_Mouse==False&&isPressed==0)
					isPressed:=1
				else if(Left_Mouse==True&&isPressed==1)
					{
						MouseGetPos,X,Y,
						ToolTip,
						break
					}
			}
	}

Set_Window(Target_Window)
	{
		isPressed:=0,i:= 0
		Loop
			{
				Left_Mouse:=GetKeyState("LButton")
				WinGetTitle,Temp_Window,A
				ToolTip,Left Click on the target window twice to set `n`n Current Window: %Temp_Window%
				if(Left_Mouse==False&&isPressed==0)
					isPressed:=1
				else if(Left_Mouse==True&&isPressed==1)
					{
						i++,isPressed:=0
						if(i>=2)
							{
								WinGetTitle,Target_Window,A
								ToolTip,
								break
							}
					}
			}
		return Target_Window	
	}

*~LButton::
	if(Clicker_Is_On==1)
		{
			Click,
		}
	return

*^Esc::
try
	{
		WinShow,%Target_Window%
	}
ExitApp
