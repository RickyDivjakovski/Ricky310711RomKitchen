echo off
if (%1)==() GOTO complete
"tools/cecho" deodexing %~n1 
IF NOT EXIST "WORKING/system/framework/%~n1.odex" goto skip
mkdir "WORKING/system/framework/tmp_%~n1"

java -Xmx1024M -jar "tools/baksmali.jar" -a %api% -d "WORKING/system/framework" -x "WORKING\system\framework\%~n1.odex">nul
if errorlevel 1 goto error

java -Xmx1024M -jar "tools/smali.jar" -a %api% -o "WORKING\system\framework\tmp_%~n1\classes.dex" out>nul
if errorlevel 1 goto error

IF NOT EXIST "WORKING\system\framework\tmp_%~n1\classes.dex" goto error

IF EXIST "WORKING\system\framework\%~n1.apk" (
move "WORKING\system\framework\%~n1.apk" "WORKING/system/framework/tmp_%~n1/">nul
cd "WORKING/system/framework/tmp_%~n1/"
"../../../../tools/7za.exe" a -tzip %~n1.apk "classes.dex" -mx%3>nul
cd "../../../../"
move "WORKING\system\framework\tmp_%~n1\%~n1.apk" "WORKING/system/framework/%~n1.apk">nul
)

IF EXIST "WORKING\system\framework\%~n1.jar" (
move "WORKING\system\framework\%~n1.jar" "WORKING/system/framework/tmp_%~n1/">nul
cd "WORKING/system/framework/tmp_%~n1/"
"../../../../tools/7za.exe" a -tzip %~n1.jar "classes.dex" -mx%3>nul
cd "../../../../"
move "WORKING\system\framework\tmp_%~n1\%~n1.jar" "WORKING/system/framework/%~n1.jar">nul
)

del "WORKING\system\framework\%~n1.odex"
goto free

:free
rmdir /s /q "WORKING/system/framework/tmp_%~n1"
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
rmdir /s /q "WORKING/system/framework/tmp_%~n1">nul
rmdir /s /q "out">nul

:complete