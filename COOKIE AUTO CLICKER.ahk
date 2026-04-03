;Modified macro for cookie clicker only - Original Written By: Hellbent aka CivReborn

#MaxHotkeysPerInterval 10000
#SingleInstance,Force
SetBatchLines, 200ms
SetMouseDelay,-1
Coordmode,Mouse,Client
SetTitleMatchMode, 2
SetControlDelay -1
DetectHiddenWindows On

; --- Hardcoded Values ---
Target_Window := "cookies - Cookie Baker"
Click_Delay   := 1
Loop_Clicker  := 1
Clicker_1     := 1
X1            := 271
Y1            := 394
Pos_1         := "271 394"
No_Clicks_1   := 1
; ------------------------

global Stop:=0, Clicker_Is_On:=0
Gui,+AlwaysOnTop

Gui,Add,Button,x10 y+20 w120 h30 gHide_Window, Hide Window
Gui,Add,Button,x+10 w120 h30 gShow_Window,Show Window

Gui,Add,Button,x10 y+20 w120 h30 gStart_Clicker,Start
Gui,Add,Button,x+10 w120 h30 gStop_Clicker,Stop


Gui,Add,Text,cRed x10 y+10 ,Start = [
Gui,Add,Text,cBlue x+10 , Stop = ]
Gui,Add,Text,cRed x10 , Hide Window = Numpad 3
Gui,Add,Text,cBlue x+10 ,Show Window = Numpad 4

Gui,Show,w280 h150,Ghost Clicker 0.1 (Modified)
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
	
Reload:
	Reload

Set_Location:
	Target_Window:=Set_Window(Target_Window)
	GuiControl,,Target_Window,% Target_Window	
	return

Update_Window:
	Gui,Submit,NoHide
	return
	
Submit_All:
	Gui,Submit,NoHide
	return

Start_Clicker:
	[:: ;edit keybinds here
	Run_Auto_Clicker()
	return
	
Stop_Clicker:
	]:: ;edit keybinds here
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
