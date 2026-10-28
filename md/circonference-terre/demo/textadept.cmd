@echo off

REM set VER=12_9
set VER=13_0_alpha_2
set LANG=fr

set SESSION=%~d0\.textadept\session
if exist %SESSION% del /q %SESSION%

start "" /b %~d0\applications\textadept\%VER%\textadept.exe --userhome %~d0\.textadept %*

REM https://orbitalquark.github.io/textadept/manual.html
