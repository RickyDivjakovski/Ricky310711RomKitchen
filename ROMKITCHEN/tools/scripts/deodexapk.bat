echo off
if (%1)==() GOTO complete
"tools/cecho" deodexing %~n1
IF NOT EXIST "WORKING/system/app/%~n1.odex" goto skip
mkdir "WORKING/system/app/tmp_%~n1"

java -Xmx512M -jar "tools/baksmali.jar" -d WORKING/system/framework -d WORKING/system/priv-app -d WORKING/system/app -x "WORKING\system\app\%~n1.odex"
if errorlevel 1 goto error

java -Xmx512M -jar "tools/smali.jar" -a %api% -o "WORKING\system\app\tmp_%~n1\classes.dex" out>nul
if errorlevel 1 goto error

IF NOT EXIST "WORKING\system\app\tmp_%~n1\classes.dex" goto error

del "WORKING\system\app\%~n1.odex"
move "WORKING\system\app\%~n1.apk" "WORKING/system/app/tmp_%~n1/">nul
cd "WORKING/system/app/tmp_%~n1/"
"../../../../tools/7za.exe" a -tzip %~n1.apk "classes.dex" -mx%3>nul
cd "../../../../"
move "WORKING\system\app\tmp_%~n1\%~n1.apk" "WORKING/system/app/%~n1.apk">nul

rmdir /s /q "WORKING/system/app/tmp_%~n1"
rmdir /s /q out
"tools/cecho"  {0A}SUCCEEDED{#}
echo.
goto complete
:skip
"tools/cecho"  {0A}SUCCEEDED{#}
echo.
goto complete
:error
"tools/cecho"  {0C}FAILED{#}
echo.
"tools/cecho"  {0C}If "Too small initial heap" change heapsize in settings and try again{#}
echo.
pause
if exist "WORKING/system/app/tmp_%~n1" rmdir /s /q "WORKING/system/app/tmp_%~n1"
rmdir /s /q "out"
:complete

