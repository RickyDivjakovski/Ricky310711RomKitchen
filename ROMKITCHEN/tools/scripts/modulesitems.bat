"tools/cecho"   {0A}0{#} - Back
echo.
echo.
echo ********************************************************************************
echo.
SET /P selection=Please make your decision: 
IF %selection% == 1 call tools/scripts/moduleinstaller.bat  
