;v3.4.0
;;Todo
;GUI
;Tagging system for races
;Cleanup code, brackets
;Unify global script/names script
;Integrate into Foundry actor macro
#Requires AutoHotkey v1.1+
#SingleInstance
Import:
{
Habitat = Temperate
Dir = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Names
RaceDir = K:\Documents\Foundry\Data\moulinette\tiles\custom\TOHP\Tokens\Homebrew\Sapient
RaceList = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Names\.List.txt
Inputbox, Race,,,,200,100
	If InStr(Race, " ")
		{
			RaceMF := StrSplit(Race, " ")
			Race := RaceMF.1
			Gender := RaceMF.2
				if (Gender = "m")
					ImgDir = K:\Documents\Foundry\Data\moulinette\tiles\custom\TOHP\Tokens\Homebrew\Sapient\%Race%\Male
				if (Gender = "f")
					ImgDir = K:\Documents\Foundry\Data\moulinette\tiles\custom\TOHP\Tokens\Homebrew\Sapient\%Race%\Female
			Goto, Start
		}
	If Race =
		{
			Loop, Read, %RaceList%
				Races_Lines = %A_Index%
			Random, RacesRnd, 1, Races_Lines
			FileReadLine, Race, %RaceList%, RacesRnd
			;Msgbox %Race%	;Debug
		}
;Race = Dragonborn
Random, MF, 1, 2
	if (MF = "1")
	{
		Gender = m
		ImgDir = %RaceDir%\%Race%\Male
	}
	if (MF = "2")
	{
		Gender = f
		ImgDir = %RaceDir%\%Race%\Female
	}

Start:
FirstFile = %Dir%\%Race%\%Race%_%Gender%.txt
LastFile_0 = %Dir%\%Race%\%Race%_s0.txt
LastFile_1 = %Dir%\%Race%\%Race%_s1.txt
LastFile_2 = %Dir%\%Race%\%Race%_s2.txt
;Msgbox %FirstFile%

if !FileExist(FirstFile)
	{
		Msgbox Error 404: %RACE% not found
		Reload
	}
}

Image:
{
Gui, Destroy


array := []  ; initialise array
loop, files, %ImgDir%\*.*  ; match any file
    array.push(a_loopFileFullPath)  ; append file to the end of the array

total_file_count := array.maxIndex()
random, random_number, 1, % total_file_count
random_file := array[random_number]
Clipboard = %random_file%
;msgBox, % random_file
	
	Gui, Margin, 0, 0
	Gui , Add, Picture, h600 w-1, %random_file%

	Gui, Color, %color%
	Gui, +LastFound -Caption +ToolWindow -Border +Resize
	;Winset, TransColor, %color%
	Gui, Show, x400 y150
}

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
	GUI, new
	GUI, add, text,, %Clipboard%
	;Msgbox %Clipboard%
	Gui, Show, x800 y450
	End:
}
Msgbox
Reload

EndofFile:
{
Escape::
{
	Gui, Destroy
	Reload
}
+Escape::ExitApp
}
return