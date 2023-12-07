@echo off
set "source=..\nvim"
set "destination=%USERPROFILE%\AppData\Local\nvim"

if exist "%destination%" (
	rmdir /s /q "%destination%"
)

xcopy /E /I "%source%" "%destination%"

pause
