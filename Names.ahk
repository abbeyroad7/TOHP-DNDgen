;v3.0.0
;;Todo
;GUI
;Tagging system for races
;Cleanup code, brackets
#Requires AutoHotkey v1.1+
Vars:
Habitat = Temperate
Dir = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Names
Inputbox, Race,,,,200,100
	If InStr(Race, " ")
		{
			RaceMF := StrSplit(Race, " ")
			Race := RaceMF.1
			Gender := RaceMF.2
			Goto, Import
		}
;Race = Dragonborn
Random, MF, 1, 2
	if (MF = "1")
		Gender = m
	if (MF = "2")
		Gender = f

Import:
FirstFile = %Dir%\%Race%\%Race%_%Gender%.txt
LastFile_0 = %Dir%\%Race%\%Race%_s0.txt
LastFile_1 = %Dir%\%Race%\%Race%_s1.txt
LastFile_2 = %Dir%\%Race%\%Race%_s2.txt
;Msgbox %First%


Image:
;Sapient = D:\Documents\Notes\DND\DND\Quartz\DM\Homebrew\Sapient
;Loop, Files, %Sapient%\*.*, R
;Image = %Sapient%\%Picture%
;Gui, Add, Picture,, %Image%
;Gui, Color, FFFFFF
;Gui, +LastFound -Caption +AlwaysOnTop +ToolWindow -Border

CountNames:
Loop, Read, %FirstFile%
   fLines = %A_Index%
If FileExist(LastFile_0)
{
	Loop, Read, %LastFile_0%
	s0Lines = %A_Index%
	Sur0 = true
}
Loop, Read, %LastFile_1%
   s1Lines = %A_Index%
Loop, Read, %LastFile_2%
   s2Lines = %A_Index%
;Msgbox %fLines% %s1Lines% %s2Lines%	;Count names for race

Loop, 3
{
Generate:
	Random, FirstRnd, 1, %fLines%
	Random, LastRnd_0, 1, %s0Lines%
	Random, LastRnd_1, 1, %s1Lines%
	Random, LastRnd_2, 1, %s2Lines%
	
	Read:
	FileReadLine, First, %FirstFile%, %FirstRnd%
	If FileExist(LastFile_0)
		FileReadLine, Last_0, %LastFile_0%, %LastRnd_0%
	FileReadLine, Last_1, %LastFile_1%, %LastRnd_1%
	FileReadLine, Last_2, %LastFile_2%, %LastRnd_2%
		StringLower, Last_2b, Last_2
	
	ColorFile = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Loot\Banks\.Colors.ini
	Loop, Read, %ColorFile%
	C_Lines = %A_Index%
	Random, ColorRnd, 1, %C_Lines%
	FileReadLine, COLOR, %ColorFile%, %ColorRnd%
	COLOR := StrSplit(COLOR, A_Tab)
	Last_0 := StrReplace(Last_0, "{COLOR}", Color.1)
	Last_1 := StrReplace(Last_1, "{COLOR}", Color.1)
	Last_2 := StrReplace(Last_2, "{COLOR}", Color.1)
	
	If (InStr(Last_0, "{FLORA}")) || If (InStr(Last_1, "{FLORA}")) || If (InStr(Last_2, "{FLORA}"))
			{	;Collapse
				FloraFile = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Loot\Banks\Beastiary\Flora\%Habitat%.ini
				Loop, Read, %FloraFile%
					Flora_Lines = %A_Index%
				Random, FloraRnd, 1, Flora_Lines
				FileReadLine, Flora, %FloraFile%, FloraRnd
				;Msgbox %Mammals%	;Debug
				Last_0 := StrReplace(Last_0, "{FLORA}", Flora)
				Last_1 := StrReplace(Last_1, "{FLORA}", Flora)
				Last_2 := StrReplace(Last_2, "{FLORA}", Flora)
			}
	
	Output:
	If FileExist(LastFile_0)
	{
		Random, LastA, 1, 2
		if (LastA = 1)
			Goto, Combine
		Loop, Read, %LastFile_0%
		s0Lines = %A_Index%
		Clipboard = %First% %Last_0%
		Msgbox %Clipboard%
		Goto, End
	}
	Combine:
	Clipboard = %First% %Last_1%%Last_2b%
	ClipWait
	Msgbox %Clipboard%
	End:
}
return