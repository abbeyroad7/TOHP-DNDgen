;v3.06.11
;;Todo
;GUI
;Tagging system for races
;Cleanup code, brackets
;New name in mind
;D20 stats, race, weapons, etc
;When importing to foundry, seperate pics by race
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

RaceSetDir = K:\Documents\Foundry\Data\moulinette\tiles\custom\TOHP\Tokens\Homebrew\Sapient\%Race%
if !FileExist(RaceSetDir)
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
;MsgBox, % random_file
}

ImageGUI:
{
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
		NameArray = %First% %Last_0%
		;Msgbox %Clipboard%
		Goto, End
	}
	Combine:
	NameArray := []
	NameArray%A_Index% = %First% %Last_1%%Last_2b%
	;MsgBox % NameArray%A_Index%
	
	End:
	GUICode:
	{
	GUI, Color, 050505	;GUI bg color
	Gui, Font, s14 cWhite, Centaur
	GUI, add, button, gAction%A_Index%, % NameArray%A_Index%	;Alt+first character as keyboard shortcut using &
	Gui, Show, AutoSize Center
	}
}
pause	;press Escape to resume
Reload


Action1:
{
	;MsgBox % NameArray1
	FoundryName = % NameArray1
	Goto, FoundryImport
}
Action2:
{
	FoundryName = % NameArray2
	Goto, FoundryImport
}
Action3:
{
	FoundryName = % NameArray3
	Goto, FoundryImport
}

FoundryImport:
{
	SleepDur = 50
	ImgPath = %random_file%
	;Msgbox %ImgPath%
	
	;FoundryImage := StrReplace(random_file, "\", "/")
	;FoundryImage := StrSplit(FoundryImage, "Data/")
	;FoundryImage := % FoundryImage.2
	
	FoundryImage = moulinette/tiles/custom/TOHP/Tokens/NPC/%FoundryName%.webp
	
	SetTitleMatchMode, 2
	if WinExist("Foundry Virtual Tabletop")
		Winactivate, Foundry Virtual Tabletop
	else
	{
		Msgbox,,,Foundry instance not found. Returning...,2
		Return
	}
	
	MouseGetPos, PosX, PosY
	MouseClick, right, 929, 1363	;Right click macro
	MouseClick, left, 932, 1234	;Edit macro menu
	
	Clipboard = const img = "%FoundryImage%"; `nconst actor = await Actor.create({ `n  name: "%FoundryName%", `n  type: "npc", `n  img: img, `n  prototypeToken: { `n    texture: { `n      src: img, `n      scaleX: 1.2, `n      scaleY: 1.2 `n    }, `n    width: 1.2, `n    height: 1.2 `n  } `n});
	MouseClick, left, 1232, 831	;body
	Send ^a{Backspace}^v
	MouseClick, left, 1477, 1018	;Execute
	Sleep 50
	Send {Escape 2}
	Clipboard = %FoundryName%
	;MouseMove, PosX, PosY	;Return to OG pos
	Run, %ImgPath%
	Run, "K:\Documents\Foundry\Data\moulinette\tiles\custom\TOHP\Tokens\NPC\.NewBorder.pdn"
	
	Sleep 1000
	FileMove, %ImgPath%, K:\Documents\Foundry\Data\moulinette\tiles\custom\TOHP\Tokens\NPC\.Saved\BaseImg\%FoundryName%.*
	ExitApp
}

EndofFile:
{
+Escape::
{
	Reload
}
^+Escape::ExitApp
}
return