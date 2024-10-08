:START
@echo off
set /p Race=Enter Race: 
mkdir %Race%
Set "out=G:\Pictures\Workshop\DND\.Tools\Scripts\Names\%Race%"
(
	a
) > "%out%\%Race%_m.txt"
Set "out=G:\Pictures\Workshop\DND\.Tools\Scripts\Names\%Race%"
(
	a
) > "%out%\%Race%_f.txt"
Set "out=G:\Pictures\Workshop\DND\.Tools\Scripts\Names\%Race%"
(
	a
) > "%out%\%Race%_s.txt"
cls
goto START