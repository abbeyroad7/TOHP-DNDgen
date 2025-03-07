;v1.0.0
;Todo:
;Alt mode on encounter style, 1 boss, 3 mini boss, goons, etc

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

PartyVariables:
{
	PartyLevel = 5
	
	PartyHealth:
	{
		P1_HP = 49	;Borislav
		P2_HP = 30	;Freya
		P3_HP = 22	;Goobert
		P4_HP = 31	;Renroc
		P5_HP = 26	;Scribbles
		P6_HP = 39	;Yeldarb
		PartyHealth := P1_HP + P2_HP + P3_HP + P4_HP + P5_HP + P6_HP
		Msgbox % PartyHealth
	}
	
}

Prompt:
{	
	Inputbox, EnemyCount, Enemy Count,,,200,100
}

GUIBody:
	{
		
		GUI, Color, 050505	;GUI bg color
		Gui, Font, s14 cWhite, Centaur
		GUI, add, text, x10 w600, EnemyCount : %EnemyCount%
		GUI, add, text, x10 w600, EnemyCount : %EnemyCount%
		
		Gui, Show, x800 y250
		
		NPC_Body = 
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