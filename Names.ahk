;v3.06.2
;;Todo
;PersonalityType
;Alignment
;Weight/Height *multiplier of race
;Quirks
;Identifiable characteristics
;Purpose
;Ideals
;Background +abilityscores/feats
;Origin
;Age
;Family
;Relationships +Most valued person
;Religion
;Weapons
;Level

;Tables
;Tagging system for races
;Cleanup code, brackets
;Queue for first/last names only
;D20 stats, race, weapons, etc
;When importing to foundry, seperate pics by race
#Requires AutoHotkey v1.1+
#SingleInstance Force
Import:
{
	ImportVars:
	{
		Habitat = Temperate
		Dir = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Names
		NPCDir = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Loot\Banks\NPC
		RaceDir = K:\Documents\Foundry\Data\moulinette\tiles\custom\TOHP\Tokens\Homebrew\Sapient
		RaceList = D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Names\.List.txt
	}
	ImportNPC:
	{
		Loop, Read, %NPCDir%\Alignments.ini
			Alignments_Lines = %A_Index%
		Loop, Read, %NPCDir%\Backgrounds.ini
			Backgrounds_Lines = %A_Index%
	}
}

Prompt:
{
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
		If InStr(Race, "db")
			{
				Race = human
				ImgDir = K:\Documents\Foundry\Data\moulinette\tiles\custom\TOHP\Tokens\Homebrew\Sapient\%Race%\Male
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
}

Start:
{
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
;Gui, Destroy

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
	Gui, MainWindow:New
	Gui, Margin, 0, 0
	Gui , Add, Picture, h600 w-1, %random_file%

	Gui, Color, %color%
	Gui, +LastFound -Caption +ToolWindow -Border +Resize
	;Winset, TransColor, %color%
	Gui, Show, x500 y300
	GUI, New
	Gui, +LastFound -Caption +ToolWindow -Border +Resize
}

CountNames:
{
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
}

NPC:
{
	Alignments:
	{
		Random, AlignmentsRnd, 1, Alignments_Lines
		FileReadLine, NPC_Alignment, %NPCDir%\Alignments.ini, AlignmentsRnd
		;Msgbox %NPC_Alignment%	;debug
	}
	Backgrounds:
	{
		Random, BackgroundsRnd, 1, Backgrounds_Lines
		FileReadLine, NPC_Background, %NPCDir%\Backgrounds.ini, BackgroundsRnd
	}
}

Generate:
{
	Loop, 3
	{
		GenerateMain:
		{
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
		}
		
		IfStatements:
		{
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
			If (InStr(Loot, "{Table-"))
			{	;Collapse
				Table0 := StrSplit(Loot, "{Table-")
				Table := Table0.2
				Table := StrReplace(Table, "}")
				;Msgbox %Table%
				TableDir = %Dir%\Banks\Tables\%Table%.txt
				Array := []
				ArrayCount := 0
				
				Loop, Read, %TableDir%
					{						
						ArrayCount += 1
						Array.Push(A_LoopReadLine)
					}
				StartRange:
				{
					StartLine = % Array[1]
					StartLine := StrSplit(StartLine, A_Tab)
					Start := StartLine.1
					
					Start := StrSplit(Start, "-")
					StartRange := Start.1
				}
				
				EndRange:
				{
					EndLine = % Array[ArrayCount]
					EndLine := StrSplit(EndLine, A_Tab)
					End := EndLine.1
					
					If (InStr(End, "-"))
						{
							End := StrSplit(End, "-")
							EndRange := End.2
						}
					Else
						EndRange = %End%
					
					If(EndRange = "00")
						EndRange = 100
					;Msgbox %StartRange% goes to %EndRange%
				}
				
				Random, TableRoll, %StartRange%, %EndRange%
				for index, element in Array
						{	 
						EndLine = % Array[index]
						EndLine := StrSplit(EndLine, A_Tab)
						End := EndLine.1
						
						End := StrSplit(End, "-")
						StartRange := End.1
						EndRange := End.2
						
						If(EndRange = "00")
							EndRange = 100
						
						;MsgBox % "Element number " . index . " is " . element
						;Msgbox %StartRange%
						;Msgbox %TableRoll%
						
						If (TableRoll <= StartRange)
						{
							;Line = %element%
							element := RegExReplace(element, "[0-9]")
							element := Trim(element, "`t-")
							Goto, EscapeArray
						}
					}
				EscapeArray:
				Loot := RegexReplace(Loot, "{Table.+}", element)
			}
		}
		
		Output:
		{
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
		}
		Combine:
		{
			NameArray := []
			NameArray%A_Index% = %First% %Last_1%%Last_2b%
			;MsgBox % NameArray%A_Index%
		}
		End:
		
		GUICode:
		{
		GUI, Color, 050505	;GUI bg color
		Gui, Font, s14 cWhite, Centaur
		GUI, add, button, gAction%A_Index% y10, % NameArray%A_Index%
		}
	}
	
	GUIBody:
	{
		GUI, add, text, gAction3 x10 y70 r1, ~%NPC_Alignment%	~%NPC_Background%
		GUI, add, text, gAction3 x10 r2, Test
		Gui, Show, x1000 y250
	}
	
	pause	;press Escape to resume
	Reload
}

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
Escape::
{
	Reload
}
+Escape::ExitApp
}
return