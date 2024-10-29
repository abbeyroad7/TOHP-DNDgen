:START
@echo off
set /p Race=Enter Race: 
mkdir %Race%
Set "out=D:\Documents\Notes\DND\DND\Quartz\DM\Scripts\Names\%Race%"
(
	a
) > "%out%\%Race%_m.txt"
(
	a
) > "%out%\%Race%_f.txt"
(
	a
) > "%out%\%Race%_s1.txt"
cls
goto START