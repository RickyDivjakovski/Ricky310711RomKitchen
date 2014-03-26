echo off
if (%1)==() GOTO complete
IF NOT EXIST "WORKING/system/app/%~n1.odex" goto skip
mkdir "WORKING/system/app/tmp_%~n1"

java -Xmx%heapsize%m -jar "tools/baksmali.jar" -d WORKING/system/framework -d WORKING/system/priv-app -d WORKING/system/app -x "WORKING\system\app\%~n1.odex"
if errorlevel 1 goto error

java -Xmx%heapsize%M -jar "tools/smali.jar" -a %api% -o "WORKING\system\app\tmp_%~n1\classes.dex" out>nul
if errorlevel 1 goto error

IF NOT EXIST "WORKING\system\app\tmp_%~n1\classes.dex" goto error

move "WORKING\system\app\%~n1.apk" "WORKING/system/app/tmp_%~n1/">nul
"tools/7za.exe" a -tzip WORKING\system\app\tmp_%~n1\%~n1.apk "WORKING\system\app\tmp_%~n1\classes.dex" -mx%3>nul
del "WORKING\system\app\%~n1.odex"
move "WORKING\system\app\tmp_%~n1\%~n1.apk" "WORKING/system/app/%~n1.apk">nul

rmdir /s /q "WORKING/system/app/tmp_%~n1"
rmdir /s /q out
"tools/cecho" %~n1 {0A}SUCCEEDED{#}
echo.
goto complete
:skip
"tools/cecho" %~n1 {0A}SUCCEEDED{#}
echo.
goto complete
:error
"tools/cecho" %~n1 {0C}FAILED{#}
echo.
if exist "WORKING/system/app/tmp_%~n1" rmdir /s /q "WORKING/system/app/tmp_%~n1"
rmdir /s /q "out"
:complete

