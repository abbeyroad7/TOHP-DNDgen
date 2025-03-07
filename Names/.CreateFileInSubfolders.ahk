Import:
{
#Requires AutoHotkey v1.1+
#NoEnv
#SingleInstance Force
#Persistent
DetectHiddenWindows, On
SetTitleMatchMode, RegEx
}

Filename = RaceSettings.ini
;Filename = Subtypes.txt

Loop, Files, %A_ScriptDir%\*, DR
	FolderList .= A_LoopFilePath "`n"
Loop, Parse, FolderList, `n
{
	;FileCreateDir, %A_LoopField%\Generate
	FileAppend, [General]`nDescriptor=Humanoid, %A_LoopField%\Generate\%Filename%
	;FileCopy, %A_ScriptDir%\RaceSettings.ini, %A_LoopField%\Generate
}

Msgbox Done.