cls
echo.
echo ********************************************************************************
"tools/cecho"                                  {0A}MODULES MENU{#} 
echo.
echo ********************************************************************************
echo.
echo   This is the Rickys Roms Kitchen module installer module :)
echo   To install a module simply drop a module(.mdl) file in the ORIGINAL folder
echo   and make a choice of what you wanna do below.
"tools/cecho"   {0C}NOTE{#}: remove the module/s from ORIGINAL folder after installation
echo.
echo        and only install one at a time of you will face errors.
"tools/cecho"   {0A}1{#} - Install a module in ORIGINAL folder
echo.
"tools/cecho"   {0A}2{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
SET /P selection=Please make your decision: 
IF %selection% == 0 goto finishmoduleset selection=
cd ORIGINAL
FOR %%F IN ("*.mdl") DO (
set modulename=
cd ..
mkdir tmp
copy "ORIGINAL\%%F" "tmp/%%F.zip">nul
"tools/7za" x "tmp/%%F.zip" modulename>nul
"tools/7za" x "tmp/%%F.zip" modulefile>nul
set /p modulename=<modulename
del "modulename">nul
set /p modulefile=<modulefile
del "modulefile">nul
if exist "tools/modules/%modulefile%" (
echo Updating %modulename%
del "tools\modules\%modulefile%">nul
"tools/7za" x "tmp/%%F.zip" tools -aoa>nul
"tools/cecho" Updated {0A}%modulename%{#}
echo.
)
if not exist "tools/modules/%modulefile%" (
"tools/7za" x "tmp/%%F.zip" tools>nul
echo Installing %modulename%
echo. >> tools/scripts/modulesmenu.bat
echo "tools/cecho"   {0A}%modules%{#} - %modulename% >> tools/scripts/modulesmenu.bat
echo echo. >> tools/scripts/modulesmenu.bat
echo. >> tools/scripts/modulesitems.bat
echo set /A modules+=1 >> tools/scripts/modulesmenu.bat
echo IF -+selection+- == %modules% call tools/modules/%modulefile% >> tools/scripts/modulesitems.bat 
cscript "tools/sed.vbs" "tools/scripts/modulesitems.bat" "-+" "%%"
cscript "tools/sed.vbs" "tools/scripts/modulesitems.bat" "+-" "%%"
"tools/cecho" Installed {0A}%modulename%{#}
echo.
)
rmdir /s /q "tmp"
cd ORIGINAL
)
pause
cd ..

:finishmodule