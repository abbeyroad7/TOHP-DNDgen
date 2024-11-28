Import:
{
#Requires AutoHotkey v1.1+
#NoEnv
#SingleInstance Force
#Persistent
}

Loop	;Screenshot every 10 mins
{
	Send #{PrintScreen}
	Sleep 600000
}