echo off
if (%1)==() GOTO enough
IF NOT EXIST "WORKING/system/framework/%~n1.odex" goto skip
IF NOT EXIST "WORKING/system/framework/processed" mkdir "WORKING/system/framework/processed"
mkdir "WORKING/system/framework/tmp_%~n1"

java -Xmx%heapsize%M -jar "tools/baksmali.jar" -a %api% -d "WORKING/system/framework" -x "WORKING\system\framework\%~n1.odex">nul
if errorlevel 1 goto error

java -Xmx%heapsize%M -jar "tools/smali.jar" -a %api% -o "WORKING\system\framework\tmp_%~n1\classes.dex" out>nul
if errorlevel 1 goto error

IF NOT EXIST "WORKING\system\framework\tmp_%~n1\classes.dex" goto error

IF EXIST "WORKING\system\framework\%~n1.apk" (
copy "WORKING\system\framework\%~n1.apk" "WORKING/system/framework/tmp_%~n1/">nul
"tools/7za.exe" a -tzip WORKING\system\framework\tmp_%~n1\%~n1.apk "WORKING\system\framework\tmp_%~n1\classes.dex" -mx%3>nul
move "WORKING\system\framework\tmp_%~n1\%~n1.apk" "WORKING/system/framework/processed/%~n1.apk">nul
)

IF EXIST "WORKING\system\framework\%~n1.jar" (
copy "WORKING\system\framework\%~n1.jar" "WORKING/system/framework/tmp_%~n1/">nul
"tools/7za.exe" a -tzip WORKING\system\framework\tmp_%~n1\%~n1.jar "WORKING\system\framework\tmp_%~n1\classes.dex" -mx%3>nul
move "WORKING\system\framework\tmp_%~n1\%~n1.jar" "WORKING/system/framework/processed/%~n1.jar">nul
)
goto free

:free
rmdir /s /q "WORKING/system/framework/tmp_%~n1"
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
rmdir /s /q "WORKING/system/framework/tmp_%~n1">nul
rmdir /s /q "out">nul

:complete