;v2.1.1
;;Todo
;GUI
#Requires AutoHotkey v1.1+
Vars:
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