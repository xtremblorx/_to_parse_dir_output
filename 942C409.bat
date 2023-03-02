@echo off

SETLOCAL ENABLEDELAYEDEXPANSION
set ERROR_CODE1=Error :404: Could not find any file for index use.

REM BEWARE CALLING THIS MULTIPLE TIMES
REM VARIABLES ARE NOT RESET!
for /f "delims=*" %%i in ('cd') DO set currentdir=%%i

for /f "delims=" %%i in ('dir /b') do set rootfilename=%%i& goto one
									:one
if NOT DEFINED rootfilename ( set /a counter+=1 ) else ( goto HEREIAM )
cd \ & (for /f "delims=*" %%i in ('cd') DO set currentdir=%%i) & (for /f "delims=" %%i in ('dir /b') do set rootfilename=%%i& goto two)
									:two
if NOT DEFINED rootfilename (cd %homedrive%\Windows&(for /f "delims=*" %%i in ('cd') DO set currentdir=%%i)&(for /f "delims=" %%i in ('dir /b') do set rootfilename=%%i& goto three)  ) else ( goto HEREIAM )
									:three
if NOT DEFINED rootfilename (echo %ERROR_CODE1%& EXIT ) else ( goto HEREIAM ) & REM POST CODE ERROR
:HEREIAM
echo File Search Successful.

cd %currentdir%
for /f "delims=" %%a in ('dir ^| find "%rootfilename%"') do for /F %%b in ('python -c "s1 = '%%a';s2 = '%rootfilename%';print(s1.index(s2))"') do set /a INDEX=%%b

echo Enter Parse DIr
set /p Parsedir=
cd %parsedir% 2>NUL
set error=%errorlevel%
if %error%==0 (echo yes ) else (echo.&echo.&echo RAN ERROR & PAUSE &Exit)

set /a counter=0
for /f "delims=" %%a in ('dir') do set /a counter+=1
set /a total=counter-5
set /a counter=0


for /f "skip=4 delims=" %%a in ('dir') do (if !counter! GEQ !total! (goto END)) & set /a counter+=1 &  for /f "tokens=1,2,3,4 delims= " %%b in ("%%a") do echo. & (set filename=%%a& set filename=!filename:~%INDEX%,250!)&echo !filename!
:END
PAUSE
REM Variables in Use= counter,rootfilename,currentdir,Error_code1
REM labels in use: 