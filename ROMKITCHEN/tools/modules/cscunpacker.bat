cls
echo.
echo ********************************************************************************
echo.
echo  CSC unpacker will unpack your CSC content from your cache image to the rom.
echo  You can choose to unpack minimal CSC or full CSC.
echo  Miminal being the minimal files required while full being all files.
echo  To begin place your cache.img(has to be named that) inside the ORIGINAL FOLDER
echo  then select an option
echo.
"tools/cecho"    {0A}1{#} - Unpack full CSC
echo.
"tools/cecho"    {0A}2{#} - Unpack minimal CSC
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 0 goto finishmodule
echo converting image..
if not exist ORIGINAL/cache.img (
"tools/cecho" {0C}  No %current%/ORIGINAL/cache.img image found {#}
echo.
"tools/cecho" {0C}  Please place the cache.img there and try again{#}
echo.
pause
goto finishmodule
)
if exist ORIGINAL/cache.img "tools/simg2img" ORIGINAL/cache.img WORKING/out.img
cls
"tools/cecho" {0A}  DUE TO THE FILESYSTEMS BEING UNABLE TO BE READ BY WINDOWS ITS REQUIRES SOME{#}
echo.
"tools/cecho" {0A}  HELP UNPACKING. CONVERTING THE SPARSE IMAGE TO NORMAL IMAGE.{#}
echo.
"tools/cecho" {0A}  EXT4 UNPACKER WILL APPEAR, OPEN THE FOLLOWING FILE WITH IT{#}
echo.
if not exist WORKING/out.img echo   %current%/ORIGINAL/cache.img 
if exist WORKING/out.img echo   %current%/WORKING/out.img 
"tools/cecho" {0A}  AND SELECT ALL THE FILES AND FOLDERS AND RIGHT CLICK EXTRACT TO THE FOLLOWING{#}
echo.
"tools/cecho" {0A}  FOLDER AND PRESS ENTER WHEN EXTRACTION COMPLETES{#}
echo.
echo   %current%/WORKING/temporary
mkdir WORKING/temporary
pause
IF %selection% == 1 goto unpackfull
IF %selection% == 2 goto unpackminimal
del /s /q WORKING/out.img

:unpackfull

:unpackminimal


:finishmodule


