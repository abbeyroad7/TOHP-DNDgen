;v1.0.0
;Todo:
;Homebrew encounters
;Character encounters
;Story arcs

Import:
{
#Requires AutoHotkey v1.1+
#NoEnv
#SingleInstance Force
#Persistent
DetectHiddenWindows, On
SetTitleMatchMode, RegEx

IconChange:
	{
		I_Icon = C:\Program Files\AutoHotkey\Icons\Names.ico
		ICON [I_Icon]                        ;Changes a compiled script's icon (.exe)
		if I_Icon <>
		IfExist, %I_Icon%
			Menu, Tray, Icon, %I_Icon%   ;Changes menu tray icon 
	}
	
	ImgDir = K:\Documents\Foundry\Data\moulinette\tiles\custom\TOHP\Tokens\Homebrew\Scenes
	SceneDir = .Scenes
}

Prompt:
{
	GUI, Color, 050505	;GUI bg color
		Gui, Font, s14 cWhite, Centaur
		GUI, add, text, w300 y10, 0=.Scenes`n1=Buildings`n2=Castles`n3=Caverns`n4=City Interiors`n5=Cityscapes`n6=Coast`n7=Deserts`n8=Dungeons`n9=Forest`n10=Interiors`n11=Jungle`n12=Mountains`n13=Plains`n14=Ruins`n15=Shopkeeper`n16=Sky`n17=Space`n18=Swamp`n19=Townscapes`n20=Tropical`n21=Tundra`n22=Underdark`n23=Underwater`n24=Valley`n25=Waterfall
	Gui, Show, x800 y250
	
	Inputbox, SceneDir,,,,200,100
}

IfStatements:
{
	if SceneDir = 0
		SceneDir = .Scenes
	if SceneDir = 1
		SceneDir = Buildings
	if SceneDir = 2
		SceneDir = Castles
	if SceneDir = 3
		SceneDir = Caverns
	if SceneDir = 4
		SceneDir = City Interiors
	if SceneDir = 5
		SceneDir = Cityscapes
	if SceneDir = 6
		SceneDir = Coast
	if SceneDir = 7
		SceneDir = Deserts
	if SceneDir = 8
		SceneDir = Dungeons
	if SceneDir = 9
		SceneDir = Forest
	if SceneDir = 10
		SceneDir = Interiors
	if SceneDir = 11
		SceneDir = Jungle
	if SceneDir = 12
		SceneDir = Mountains
	if SceneDir = 13
		SceneDir = Plains
	if SceneDir = 14
		SceneDir = Ruins
	if SceneDir = 15
		SceneDir = Shopkeeper
	if SceneDir = 16
		SceneDir = Sky
	if SceneDir = 17
		SceneDir = Space
	if SceneDir = 18
		SceneDir = Swamp
	if SceneDir = 19
		SceneDir = Townscapes
	if SceneDir = 20
		SceneDir = Tropical
	if SceneDir = 21
		SceneDir = Tundra
	if SceneDir = 22
		SceneDir = Underdark
	if SceneDir = 23
		SceneDir = Underwater
	if SceneDir = 24
		SceneDir = Valley
	if SceneDir = 25
		SceneDir = Waterfall
		
	GUI, Destroy
}

Image:
{
;Gui, Destroy
array := []  ; initialise array
loop, files, %ImgDir%\%SceneDir%\*.*  ; match any file
    array.push(a_loopFileFullPath)  ; append file to the end of the array

total_file_count := array.maxIndex()
random, random_number, 1, % total_file_count
random_file := array[random_number]
Clipboard = %random_file%
;MsgBox, % random_file
}

ImageGUI:
{
	If InStr(random_file, "webp")
	{
		filePath = %random_file%
		hBitmap := HBitmapFromWebP(filePath, width, height)
		random_file = HBITMAP:%hBitmap%
		#Include, D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Libraries\DecodeWebP.ahk
	}
	
	Gui, MainWindow:New
	Gui, Margin, 0, 0
	Gui , Add, Picture, h600 w-1, %random_file%

	Gui, Color, %color%
	Gui, +LastFound -Caption +ToolWindow -Border +Resize
	;Winset, TransColor, %color%
	Gui, Show, x250 y150
	GUI, New
	Gui, +LastFound -Caption +ToolWindow -Border +Resize
}

GUIBody:
	{
		
		GUI, Color, 050505	;GUI bg color
		Gui, Font, s14 cWhite, Centaur
		GUI, add, text, x10 w600, 
		
		Gui, Show, x800 y250
		
		NPC_Body = %FullGender% %Race% | %NPC_Role% | %NPC_Family% | Worships %NPC_Gods%`n~Currently thinking about %NOUN%`n~%NPC_Goal%
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