echo off
IF EXIST "WORKING\system\framework\%~n1.apk" (
del "WORKING\system\framework\%~n1.apk"
IF EXIST "WORKING\system\framework\%~n1.odex" del "WORKING\system\framework\%~n1.odex"
move "WORKING\system\framework\processed\%~n1.apk" "WORKING/system/framework/%~n1.apk"
)

IF EXIST "WORKING\system\framework\%~n1.jar" (
del "WORKING\system\framework\%~n1.jar"
IF EXIST "WORKING\system\framework\%~n1.odex" del "WORKING\system\framework\%~n1.odex"
move "WORKING\system\framework\processed\%~n1.jar" "WORKING/system/framework/%~n1.jar">nul
)

rmdir /s /q "WORKING/system/framework/processed"
