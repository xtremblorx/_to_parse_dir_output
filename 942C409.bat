@echo off

set ERROR_CODE1=Error :404: Could not find any file for index use.

REM BEWARE CALLING THIS MULTIPLE TIMES
REM VARIABLES ARE NOT RESET!
for /f "delims=*" %%i in ('cd') DO set currentdir=%%i

for /f "delims=" %%i in ('dir /b') do set rootfilename=%%i& goto one
									:one
if NOT DEFINED rootfilename ( set /a counter+=1 ) else ( goto HEREIAM )
cd \ & (for /f "delims=*" %%i in ('cd') DO set currentdir=%%i) & (for /f "delims=" %%i in ('dir /b') do set rootfilename=%%i& goto two)
									:two
if NOT DEFINED rootfilename (if %counter%==1 cd %homedrive%\Windows&(for /f "delims=*" %%i in ('cd') DO set currentdir=%%i)&(for /f "delims=" %%i in ('dir /b') do set rootfilename=%%i& goto three)  ) else ( goto HEREIAM )
									:three
if NOT DEFINED rootfilename (echo %ERROR_CODE1%& EXIT ) else ( goto HEREIAM ) & REM POST CODE ERROR
:HEREIAM
echo File Search Successful.






REM Variables in Use= counter,rootfilename,currentdir,Error_code1
REM labels in use: 