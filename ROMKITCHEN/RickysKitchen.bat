@echo off
echo ======================================== Copyright (C) 2014 Ricky Divjakovski(Ricky310711) ==============================================
echo   you cannot redistribute it and/or modify in any way, commits are welcome on git and will be reviewed - ricky310711@github
echo   This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of    
echo   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                                
echo   This tool was originally part of AET(android everything tool) also made by me(ricky310711).
echo   I do not ask for money but if you would like to contribute to my work go ahead and donate and i will appreciate you and add you to
echo   the "Special thanks list" where all donatotors will be listed
echo   This program is designed for users to experiance android the way they want it and be able to release roms with their creatvity included
echo =========================================================================================================================================
cls

:: BatchGotAdmin
:====================================-
REM  ==> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM ==> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "%~s0", "%params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
@echo off
cd >> tmp.log
set /p current=< tmp.log
del tmp.log       
cd "%current%"

:main
cls
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
"tools/cecho"                        {0A}   RICKYS ROM KITCHEN BY RICKY310711 {#}
echo. 
echo ********************************************************************************
echo.
"tools/cecho"   {0A}S{#} - Settings
echo.
echo.
"tools/cecho"   {0A}1{#} - Setup working folder
echo.
"tools/cecho"   {0A}2{#} - Open working folder
echo.
"tools/cecho"   {0A}3{#} - Open build folder
echo.
echo.
"tools/cecho"   {0A}4{#} - Extraction options
echo.
"tools/cecho"   {0A}5{#} - Aroma options
echo.
"tools/cecho"   {0A}6{#} - Add init.d support
echo.
"tools/cecho"   {0A}7{#} - Install busybox
echo.
"tools/cecho"   {0A}8{#} - Add root permissions
echo.
"tools/cecho"   {0A}9{#} - Deodex
echo.
echo.
"tools/cecho"   {0A}T{#} - Init.d tweaks menu
echo.
"tools/cecho"   {0A}E{#} - Extras menu
echo.
echo.
"tools/cecho"   {0A}I{#} - Show working information
echo.
"tools/cecho"   {0A}B{#} - Build from working folder
echo.
"tools/cecho"   {0A}P{#} - Push latest build to sdcard
echo.
echo.
"tools/cecho"   {0A}D{#} - Donate To This Project
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
if %selection% == s goto settings
if %selection% == S goto settings
if %selection% == 1 goto setworking
if %selection% == 2 goto openworking
if %selection% == 3 goto openbuild
if %selection% == 4 goto extractionoptions
if %selection% == 5 goto aromaoptions
if %selection% == 6 goto addinitd
if %selection% == 7 goto installbusybox
if %selection% == 8 goto rootrom
if %selection% == 9 goto deodexrom
if %selection% == t goto initdtweaks
if %selection% == T goto initdtweaks
if %selection% == e goto extrasmenu
if %selection% == E goto extrasmenu
if %selection% == i goto information
if %selection% == I goto information
if %selection% == b goto buildrom
if %selection% == B goto buildrom
if %selection% == p goto pushbuild
if %selection% == P goto pushbuild
if %selection% == d goto donate
if %selection% == D goto donate
if %selection% == 99 goto test
set selection=RICKY310711
"tools/cecho" {0C}OOOPS, looks like you typed something wrong..{#}
echo.
pause>nul
goto main

:test 
call tools/scripts/buildaroma
pause
goto main

if exist "C:\Program Files (x86)\Notepad++\notepad++.exe" "C:\Program Files (x86)\Notepad++\notepad++" "WORKING/META-INF/com/google/android/aroma-config"

:deodexrom
cls
echo.
echo ********************************************************************************
echo.
echo  This allows you to deodex your rom, deodexing allows you to modify apk and jar
echo  files, without deodexing you cannot do so.
echo  While odexed is slight(very slightly) faster, in my opinion its always a good
echo  option to deodex your rom.
echo.
"tools/cecho"    {0A}1{#} - Deodex the rom
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 0 goto main
echo Starting deodexing process for applications
echo.
echo.
echo.
FOR %%F IN ("WORKING\system\app\*.apk") DO call "tools/scripts/deodexapk.bat" %%F %api% %compression%
if exist "WOKRING/system/priv-app" (
echo.
echo.
echo.
echo Starting deodexing process for priv-app applications
FOR %%F IN ("WORKING\system\app\*.apk") DO call "tools/scripts/deodexprivapp.bat" %%F %api% %compression%
)
echo.
echo.
echo.
echo Starting deodexing process for framework
echo.
echo.
echo.
FOR %%F IN ("WORKING\system\framework\*.jar") DO call "tools/scripts/deodexjar.bat" %%F %api% %compression%
FOR %%F IN ("WORKING\system\framework\*.apk") DO call "tools/scripts/deodexjar.bat" %%F %api% %compression%
FOR %%F IN ("WORKING\system\framework\processed\*.jar") DO call "tools/scripts/movejar.bat" %%F
FOR %%F IN ("WORKING\system\framework\processed\*.apk") DO call "tools/scripts/movejar.bat" %%F
goto main

:donate
start tools/donate.url
goto main

:extrasmenu
cls
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
"tools/cecho"                                  {0A}EXTRAS MENU{#} 
echo.
echo ********************************************************************************
echo.
"tools/cecho"   {0A}1{#} - Zipalign
echo.
"tools/cecho"   {0A}2{#} - De-knox rom(samsung)
echo.
"tools/cecho"   {0A}3{#} - Change density
echo.
"tools/cecho"   {0A}4{#} - Toggle bitcode verification
echo.
"tools/cecho"   {0A}5{#} - Toggle GPU rendering
echo.
"tools/cecho"   {0A}6{#} - Add sysrw/ro binary
echo.
"tools/cecho"   {0A}7{#} - Toggle bootanimation
echo.
"tools/cecho"   {0A}8{#} - Kernel/Recovery tools
echo.
"tools/cecho"   {0A}0{#} - Back
echo.
echo.
echo ********************************************************************************
echo.
SET /P menunr=Please make your decision: 
IF %menunr% == 1 goto zipalign
IF %menunr% == 2 goto deknox
IF %menunr% == 3 goto densitychanger
IF %menunr% == 4 goto togglebitcode
IF %menunr% == 5 goto togglegpurendering
IF %menunr% == 6 goto addsysrwo
IF %menunr% == 7 goto togglebootanimation
IF %menunr% == 8 goto imagetools
IF %menunr% == 0 goto main
"tools/cecho" {0C}OOOPS, looks like you typed something wrong..{#}
echo.
pause>nul
goto extrasmenu

:densitychanger
cls
echo.
echo ********************************************************************************
echo.
echo  This allows you to change the dpi to whatever you like without losing your
echo  original setting! changing makes your device seem bigger or smaller according
echo  to the value you change it to. however some apps may appear distorted.
echo  lower = device feels bigger                     higher = device feels smaller
echo.
"tools/cecho"    {0A}1{#} - Change DPI
echo.
"tools/cecho"    {0A}2{#} - Revert changes to stock
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 1 goto changedensity
IF %selection% == 2 goto revertdensity
IF %selection% == 0 goto extrasmenu
goto densitychanger

:changedensity
cls
echo ********************************************************************************
echo.
echo                   Enter your desired density now!
echo.
echo ********************************************************************************
set /P tmp=Make your decision:
if exist "tools/config/romsettings/dpi/CustomToken" (
cscript "tools/sed.vbs" "WORKING/system/build.prop" "# Custom DPI" ""
cscript "tools/sed.vbs" "WORKING/system/build.prop" "ro.sf.lcd_density=" "##"
cscript "tools/sed.vbs" "WORKING/system/build.prop" "##ro.sf.#lcd_density=" "ro.sf.lcd_density="
del "tools\config\romsettings\dpi\CustomToken"
rmdir /s /q "tools/config/romsettings/dpi/customdpi"
)
echo AUTOGENERATED > tools/config/romsettings/dpi/CustomToken
mkdir "tools/config/romsettings/dpi/customdpi"
echo AUTOGENERATED > tools/config/romsettings/dpi/customdpi/%tmp%
cscript "tools/sed.vbs" "WORKING/system/build.prop" "ro.sf.lcd_density=" "##ro.sf.#lcd_density="
echo # Custom DPI >> WORKING/system/build.prop
echo ro.sf.lcd_density=%tmp% >> WORKING/system/build.prop
set tmp=
call tools/scripts/done
goto densitychanger

:revertdensity
if not exist "tools/config/romsettings/dpi/CustomToken" (
"tools/cecho" {0C}Your density is still at stock value.{#}
echo.
pause
)
cls
if exist "tools/config/romsettings/dpi/CustomToken" (
cscript "tools/sed.vbs" "WORKING/system/build.prop" "# Custom DPI" ""
cscript "tools/sed.vbs" "WORKING/system/build.prop" "ro.sf.lcd_density=" "##"
cscript "tools/sed.vbs" "WORKING/system/build.prop" "##ro.sf.#lcd_density=" "ro.sf.lcd_density="
del "tools\config\romsettings\dpi\CustomToken"
rmdir /s /q "tools/config/romsettings/dpi/customdpi"
call tools/scripts/done
)
goto densitychanger

:togglebitcode
cls
echo.
echo ********************************************************************************
echo.
echo  Turns bitcode verification on/off, i suggest you keep it on but trning it off
echo  increases speed greatly, however could(not likely) cause an app or 2 to crash.
echo  default is off.
echo.
"tools/cecho"    {0A}1{#} - Turn off
echo.
"tools/cecho"    {0A}2{#} - Turn on
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 1 goto disablebitcode
IF %selection% == 2 goto enablebitcode
IF %selection% == 0 goto extrasmenu
goto togglebitcode

:disablebitcode
if exist "tools/config/romsettings/bitcodeverification/BitcodeToken" (
"tools/cecho" {0C}Bitcode verification is already disabled{#}
echo.
pause
)
if not exist "tools/config/romsettings/bitcodeverification/BitcodeToken" (
echo # Disable Bitcode-verification >> WORKING/system/build.prop
echo dalvik.vm.verify-bytecode = false >> WORKING/system/build.prop
echo dalvik.vm.dexopt-flags=v=n,o=v >> WORKING/system/build.prop
echo AUTOGENERATED > tools/config/romsettings/bitcodeverification/BitcodeToken
call tools/scripts/done
)
goto togglebitcode

:enablebitcode
if not exist "tools/config/romsettings/bitcodeverification/BitcodeToken" (
"tools/cecho" {0C}Bitcode verification is not disabled yet{#}
echo.
pause
)
if exist "tools/config/romsettings/bitcodeverification/BitcodeToken" (
cscript "tools/sed.vbs" "WORKING/system/build.prop" "# Disable Bitcode-verification" ""
cscript "tools/sed.vbs" "WORKING/system/build.prop" "dalvik.vm.verify-bytecode = false" ""
cscript "tools/sed.vbs" "WORKING/system/build.prop" "dalvik.vm.dexopt-flags=v=n,o=v" ""
del tools\config\romsettings\bitcodeverification\BitcodeToken
call tools/scripts/done
)
goto togglebitcode

:togglebootanimation
cls
echo.
echo ********************************************************************************
echo.
echo  This option allows you to enable/disable the bootanimation. if disabled, the
echo  screen will stay black until the device is completely booted
echo  defauls is on.
echo.
"tools/cecho"    {0A}1{#} - Turn off
echo.
"tools/cecho"    {0A}2{#} - Turn on
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 1 goto disablebootanimation
IF %selection% == 2 goto enablebootanimation
IF %selection% == 0 goto extrasmenu
goto togglebootanimation

:disablebootanimation
if exist "tools/config/romsettings/bootanimation/AnimationToken" (
"tools/cecho" {0C}Bootanimation is already disabled{#}
echo.
pause
)
if not exist "tools/config/romsettings/bootanimation/AnimationToken" (
echo # Disable Bootanimation >> WORKING/system/build.prop
echo debug.sf.nobootanimation=1 >> WORKING/system/build.prop
echo AUTOGENERATED > tools/config/romsettings/bootanimation/AnimationToken
call tools/scripts/done
)
goto togglebootanimation

:enablebootanimation
if not exist "tools/config/romsettings/bootanimation/AnimationToken" (
"tools/cecho" {0C}Bootanimation is not disabled yet{#}
echo.
pause
)
if exist "tools/config/romsettings/bootanimation/AnimationToken" (
cscript "tools/sed.vbs" "WORKING/system/build.prop" "# Disable Bootanimation" ""
cscript "tools/sed.vbs" "WORKING/system/build.prop" "debug.sf.nobootanimation=1" ""
del tools\config\romsettings\bootanimation\AnimationToken
call tools/scripts/done
)
goto togglebootanimation

:togglegpurendering
cls
echo.
echo ********************************************************************************
echo.
echo  This option allows you to enable/disable GPU rendering
echo.
"tools/cecho"    {0A}1{#} - Turn off
echo.
"tools/cecho"    {0A}2{#} - Turn on
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 1 goto disablegpurendering
IF %selection% == 2 goto enablegpurendering
IF %selection% == 0 goto extrasmenu
goto togglegpurendering

:disablegpurendering
if exist "tools/config/romsettings/gpurendering/GPUToken" (
"tools/cecho" {0C}GPU rendering is already disabled{#}
echo.
pause
)
if not exist "tools/config/romsettings/gpurendering/GPUToken" (
echo # Disable GPU Rendering >> WORKING/system/build.prop
echo debug.sf.hw=1 >> WORKING/system/build.prop
echo AUTOGENERATED > tools/config/romsettings/gpurendering/GPUToken
call tools/scripts/done
)
goto togglegpurendering

:enablegpurendering
if not exist "tools/config/romsettings/gpurendering/GPUToken" (
"tools/cecho" {0C}GPU rendering is not disabled yet{#}
echo.
pause
)
if exist "tools/config/romsettings/gpurendering/GPUToken" (
cscript "tools/sed.vbs" "WORKING/system/build.prop" "# Disable GPU Rendering" ""
cscript "tools/sed.vbs" "WORKING/system/build.prop" "debug.sf.hw=1" ""
del tools\config\romsettings\gpurendering\GPUToken
call tools/scripts/done
)
goto togglegpurendering

:deknox
cls
echo.
echo ********************************************************************************
echo.
echo  Samsungs never devices/firmware have this crappy implementation on what they 
echo  call "secure". they try doing this via knox to catch out the people who wreck
echo  their device via gaining root. however the trigger can be avoided by removing
echo  knox libs/utillities. SO FUCK YOU SAMSUNG!
echo.
"tools/cecho"    {0A}1{#} - De-knox the rom
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 1 goto startdeknoxing
IF %selection% == 0 goto main
goto deknox

:startdeknoxing
IF %knox% == No (
"tools/cecho" {0C}THE ROM IS ALREADY KNOX-FREE{#}
echo.
"tools/cecho" {0C}NO NEED TO REPEAT{#}
echo.
pause
goto extrasmenu
)
if exist WORKING/system/app/KNOXAgent.apk del WORKING\system\app\KNOXAgent.apk
if exist WORKING/system/app/KNOXAgent.odex del WORKING\system\app\KNOXAgent.odex
if exist WORKING/system/app/KLMSAgent.apk del WORKING\system\app\KLMSAgent.apk
if exist WORKING/system/app/KLMSAgent.odex del WORKING\system\app\KLMSAgent.odex
if exist WORKING/system/app/KnoxAttestationAgent.apk del WORKING\system\app\KnoxAttestationAgent.apk
if exist WORKING/system/app/KnoxAttestationAgent.odex del WORKING\system\app\KnoxAttestationAgent.odex
if exist WORKING/system/app/KNOXStore.apk del WORKING\system\app\KNOXStore.apk
if exist WORKING/system/app/KNOXStore.odex del WORKING\system\app\KNOXStore.odex
if exist WORKING/system/app/ContainerAgent.apk del WORKING\system\app\ContainerAgent.apk
if exist WORKING/system/app/ContainerAgent.odex del WORKING\system\app\ContainerAgent.odex
if exist WORKING/system/app/ContainerEventsRelayManager.apk del WORKING\system\app\ContainerEventsRelayManager.apk
if exist WORKING/system/app/ContainerEventsRelayManager.odex del WORKING\system\app\ContainerEventsRelayManager.odex
if exist WORKING/system/app/KNOXStub.apk del WORKING\system\app\KNOXStub.apk
if exist WORKING/system/app/KNOXStub.odex del WORKING\system\app\KNOXStub.odex
if exist WORKING/system/priv-app/KLMSAgent.apk del WORKING\system\priv-app\KLMSAgent.apk
if exist WORKING/system/priv-app/KLMSAgent.odex del WORKING\system\priv-app\KLMSAgent.odex
if exist WORKING/system/etc/secure_storage/com.sec.knox.store rmdir /s /q WORKING\system\etc\secure_storage\com.sec.knox.store
if exist WORKING/system/lib/libknoxdrawglfunction.so del WORKING\system\lib\libknoxdrawglfunction.so
if exist WORKING/system/containers rmdir /s /q WORKING\system\containers
if exist WORKING/system/preloadedkiosk rmdir /s /q WORKING\system\preloadedkiosk
if exist WORKING/system/preloadedsso rmdir /s /q WORKING\system\preloadedsso
call tools/scripts/done
goto extrasmenu

:addsysrwo
if exist WORKING/system/bin/sysrw (
if exist WORKING/system/bin/sysro (
"tools/cecho" {0C}THE ROM ALREADY CONTAINS SYSRWW/SYSRO BINARY{#}
echo.
"tools/cecho" {0C}NO NEED TO REPEAT{#}
echo.
pause
goto extrasmenu
)
)
xcopy "tools\files\sysrwro" "WORKING" /e /i /h>nul
call tools/scripts/done
goto extrasmenu

:zipalign
cls
FOR %%F IN ("WORKING/system/app/*.apk") DO (
echo ZipAligning %%F
"tools/zipalign" -v 4 "WORKING\system\app\%%F" "WORKING/system/app/%%F.zip" >nul
if not exist "WORKING/system/app/%%F.zip" (
"tools/cecho" {0C}FAILED{#}
echo.
echo %%F >> failed.txt
pause
)
if exist "WORKING/system/app/%%F.zip" (
del "WORKING\system\app\%%F" >nul
ren "WORKING\system\app\%%F.zip" "%%F"
"tools/cecho" {0A}SUCCESS{#}
echo.
)
echo.
)
if exist WORKING/system/priv-app (
FOR %%F IN ("WORKING/system/app/*.apk") DO (
echo ZipAligning %%F
"tools/zipalign" -v 4 "WORKING\system\app\%%F" "WORKING/system/app/%%F.zip" >nul
if not exist "WORKING/system/app/%%F.zip" (
"tools/cecho" {0C}FAILED{#}
echo.
echo %%F >> failed.txt
pause
)
if exist "WORKING/system/app/%%F.zip" (
del "WORKING\system\app\%%F" >nul
ren "WORKING\system\app\%%F.zip" "%%F"
"tools/cecho" {0A}SUCCESS{#}
echo.
)
echo.
)
)
cls
if not exist failed.txt call tools/scripts/done
if exist failed.txt (
"tools/cecho" {0C}FAILED TO ZIPALIGN{#}
echo.
type failed.txt
pause
del failed.txt
)
goto extrasmenu

:imagetools
cls
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
"tools/cecho"                                  {0A}IMG TOOLS{#} 
echo.
echo ********************************************************************************
echo.
"tools/cecho"   {0A}1{#} - Unpack file in working directory
echo.
"tools/cecho"   {0A}2{#} - Compile image folder working directory
echo.
"tools/cecho"   {0A}3{#} - Enable adbd insecure ramdisk
echo.
"tools/cecho"   {0A}0{#} - Back
echo.
echo.
echo ********************************************************************************
echo.
SET /P menunr=Please make your decision: 
IF %menunr% == 1 goto imageunpack
IF %menunr% == 2 goto imagepack
IF %menunr% == 3 goto adbdinsecure
IF %menunr% == 0 goto extrasmenu
"tools/cecho" {0C}OOOPS, looks like you typed something wrong..{#}
echo.
pause>nul
goto imagetools

:imageunpack
cls
echo ********************************************************************************
"tools/cecho"  {0A}UNPACKING IMAGE...{#} 
echo.
echo ********************************************************************************
call tools/scripts/bootunpack WORKING/boot.img
if exist boot move boot WORKING/
if exist recovery move recovery WORKING/
call tools/scripts/done
goto imagetools

:imagepack
cls
echo ********************************************************************************
"tools/cecho"  {0A}PACKING IMAGE...{#} 
echo.
echo ********************************************************************************
if exist WORKING/boot move WORKING/boot %current%\
if exist WORKING/recovery move WORKING/recovery %current%\
call tools/scripts/bootpack WORKING/boot
if exist boot ren new-image.img boot.img
if exist recovery ren new-image.img recovery.img
if exist boot.img del "WORKING/boot.img"
if exist recovery.img del "WORKING/recovery.img"
if exist boot.img move boot.img WORKING/
if exist recovery.img move recovery.img WORKING/
if exist boot rmdir /s /q boot
if exist recovery rmdir /s /q recovery
if exist boot rmdir /s /q WORKING/boot
if exist recovery rmdir /s /q WORKING/recovery
call tools/scripts/done
goto imagetools

:adbdinsecure
cls
echo ********************************************************************************
"tools/cecho"  {0A}CREATING INSECURE RAMDISK...{#} 
echo.
echo ********************************************************************************
call tools/scripts/bootunpack WORKING/boot.img
if exist boot cscript "tools/sed.vbs" "boot/rmdisk/default.prop" ".secure=1" ".secure=0"
if exist recovery cscript "tools/sed.vbs" "recovery/rmdisk/default.prop" ".secure=1" ".secure=0"
call tools/scripts/bootpack WORKING/boot
if exist new-image.img echo AUTOGENERATED > tools/config/romsettings/insecureramdisk/InsecureToken
if exist boot ren new-image.img boot.img
if exist recovery ren new-image.img boot.img
if exist boot.img del "WORKING/boot.img"
if exist recovery.img del "WORKING/recovery.img"
if exist boot.img move boot.img WORKING/
if exist recovery.img move recovery.img WORKING/
if exist boot rmdir /s /q boot
if exist recovery rmdir /s /q recovery
call tools/scripts/done
goto imagetools

:initdtweaks
cls
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
"tools/cecho"                                  {0A}INIT.D TWEAKS{#} 
echo.
if %initdconfig% == Yes "tools/cecho"                                init.d status:{0A}%initdconfig%{#}
if %initdconfig% == Possibly "tools/cecho"                                init.d status:{0A}%initdconfig%{#}
if %initdconfig% == Possibly echo.
if %initdconfig% == Possibly "tools/cecho" {0A}INIT.D MAY NOT BE INSTALLED, ONLY CONTINUE IF YOUR SURE IT IS{#}
if %initdconfig% == No "tools/cecho"                                init.d status:{0A}%initdconfig%{#}
if %initdconfig% == No echo.
if %initdconfig% == No "tools/cecho" {0A}INIT.D NOT FOUND, PLEASE ADD INIT.D FIRST{#}
echo.
echo ********************************************************************************
echo.
"tools/cecho"   {0A}1{#} - Battery tweak
echo.
"tools/cecho"   {0A}2{#} - Move dalvik to cache
echo.
"tools/cecho"   {0A}3{#} - Dalvik vm tweaks
echo.
"tools/cecho"   {0A}4{#} - IPV4 tweaks
echo.
"tools/cecho"   {0A}5{#} - Better LMK configuration
echo.
"tools/cecho"   {0A}6{#} - Increase sdcard readahead kb to 2048
echo.
"tools/cecho"   {0A}7{#} - Zipalign on boot
echo.
"tools/cecho"   {0A}0{#} - Back
echo.
echo.
echo ********************************************************************************
echo.
SET /P menunr=Please make your decision: 
IF %menunr% == 1 goto batterytweaks
IF %menunr% == 2 goto dalviktocache
IF %menunr% == 3 goto dalvikvm
IF %menunr% == 4 goto internetspeed
IF %menunr% == 5 goto lmkconfiguration
IF %menunr% == 6 goto sdcardreadahead
IF %menunr% == 7 goto zipalignonboot
IF %menunr% == 0 goto main
"tools/cecho" {0C}OOOPS, looks like you typed something wrong..{#}
echo.
pause>nul
goto initdtweaks

:batterytweaks
del "WORKING\system\etc\init.d\95batterytweaks"
xcopy "tools\files\tweaks\batterytweaks" "WORKING/system/etc/init.d" /e /i /h>nul
call tools/scripts/done
goto initdtweaks

:dalviktocache
del "WORKING\system\etc\init.d\95dalviktocache"
xcopy "tools\files\tweaks\dalviktocache" "WORKING/system/etc/init.d" /e /i /h>nul
call tools/scripts/done
goto initdtweaks

:dalvikvm
del "WORKING\system\etc\init.d\95dalvikvm"
xcopy "tools\files\tweaks\dalvikvm" "WORKING/system/etc/init.d" /e /i /h>nul
call tools/scripts/done
goto initdtweaks

:internetspeed
del "WORKING\system\etc\init.d\95internetspeed"
xcopy "tools\files\tweaks\internetspeed" "WORKING/system/etc/init.d" /e /i /h>nul
call tools/scripts/done
goto initdtweaks

:lmkconfiguration
del "WORKING\system\etc\init.d\95lmkconfiguration"
xcopy "tools\files\tweaks\lmkconfiguration" "WORKING/system/etc/init.d" /e /i /h>nul
call tools/scripts/done
goto initdtweaks

:sdcardreadahead
del "WORKING\system\etc\init.d\95sdcardreadahead"
xcopy "tools\files\tweaks\sdcardreadahead" "WORKING/system/etc/init.d" /e /i /h>nul
call tools/scripts/done
goto initdtweaks

:zipalignonboot
del "WORKING\system\etc\init.d\95zipalignonboot"
xcopy "tools\files\tweaks\zipalignonboot" "WORKING/system/etc/init.d" /e /i /h>nul
call tools/scripts/done
goto initdtweaks

:settings
cls
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
"tools/cecho"                        {0A}   RICKYS ROM KITCHEN BY RICKY310711 {#}
echo. 
echo ********************************************************************************
echo.
"tools/cecho"   {0A}1{#} - Change default compression level                  current:%compression%
echo.
"tools/cecho"   {0A}2{#} - Change default heapsize                           current:%heapsize%      
echo.
"tools/cecho"   {0A}3{#} - Change default permission syntax                  current:%syntax%      
echo.
"tools/cecho"   {0A}4{#} - Delete all project data
echo.
"tools/cecho"   {0A}5{#} - Revert all settings
echo.
"tools/cecho"   {0A}6{#} - Delete all data for fresh use
echo.
"tools/cecho"   {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
set selection=RICKY310711
set /P selection=Make your decision:
if %selection% == 1 goto changecompression
if %selection% == 2 goto changeheap
if %selection% == 3 goto changesyntax
if %selection% == 4 goto deleteproject
if %selection% == 5 goto revertsettings
if %selection% == 6 goto freshtool
if %selection% == 0 goto main

:changesyntax
cls
echo.
echo ********************************************************************************
echo   Choose your desired syntax, this will be saved and set by default when
echo   starting the tool.
echo.
"tools/cecho"   {0A}1{#} - metadata (set_metadata/_recursive)
echo.
"tools/cecho"   {0A}2{#} - permission (set_perm/_recursive)
echo.
echo.
echo ********************************************************************************
echo.
SET /P menunr=Please make your decision: 
IF %menunr% == 1 goto changetometadata
IF %menunr% == 2 goto changetosetperm
"tools/cecho" {0C}OOOPS, looks like you typed something wrong..{#}
echo.
pause>nul
goto changesyntax

:changetometadata
rmdir /s /q "tools/config/toolsettings/syntax"
mkdir "tools/config/toolsettings/syntax"
echo AUTOGENERATED > tools/config/toolsettings/syntax/metadata
call tools/scripts/done
goto settings

:changetosetperm
rmdir /s /q "tools/config/toolsettings/syntax"
mkdir "tools/config/toolsettings/syntax"
echo AUTOGENERATED > tools/config/toolsettings/syntax/perm
call tools/scripts/done
goto settings

:changecompression
cls
echo ********************************************************************************
echo.
echo                    Enter the desired compression level now
echo                   1 to 9. 9 being the best compression level
echo        note: this will be saved and set by default when running the tool
echo.
echo ********************************************************************************
set /P tmp=Make your decision:
rmdir /s /q "tools/config/toolsettings/compression"
mkdir "tools/config/toolsettings/compression"
echo AUTOGENERATED > tools/config/toolsettings/compression/%tmp%
call tools/scripts/done
goto settings

:changeheap
cls
echo ********************************************************************************
echo.
echo                       Enter the desired heapsize now
echo        note: this will be saved and set by default when running the tool
echo.
echo ********************************************************************************
set /P tmp=Make your decision:
rmdir /s /q "tools/config/toolsettings/heapsize"
mkdir "tools/config/toolsettings/heapsize"
echo AUTOGENERATED > tools/config/toolsettings/heapsize/%tmp%
call tools/scripts/done
goto settings

:deleteproject
cls
echo.
echo ********************************************************************************
echo.
"tools/cecho"   {0A}1{#} - Delete current project %romname%
echo.
"tools/cecho"   {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 0 goto main
echo Deleting old data
call tools/scripts/deleteproject>nul
call tools/scripts/done
goto settings

:revertsettings
cls
echo.
echo ********************************************************************************
echo.
"tools/cecho"   {0A}1{#} - Revert all settings
echo.
"tools/cecho"   {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 0 goto main
echo Deleting old settings
call tools/scripts/revertsettings>nul
call tools/scripts/done
goto settings

:freshtool
cls
echo.
echo ********************************************************************************
echo.
"tools/cecho"   {0A}1{#} - Delete all data and revert all settings
echo.
"tools/cecho"   {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 0 goto main
echo Deleting old data
call tools/scripts/deleteproject>nul
echo Deleting old settings
call tools/scripts/revertsettings>nul
call tools/scripts/done
goto settings

:setworking
cls
echo.
echo ********************************************************************************
echo.
"tools/cecho"   {0A}1{#} - Delete current project %romname% and setup new project
echo.
"tools/cecho"   {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 0 goto main
echo Deleting old data
call tools/scripts/deleteproject>nul
call tools/scripts/rebuild>nul
set romname=
cls
echo.
echo ********************************************************************************
echo                                SETUP PROJECT         
echo ********************************************************************************
echo.
set /p romname=Type a name for your rom with no spaces:
echo AETOGENERATED >> "tools/config/romsettings/romname/%romname%"
cls
echo.
echo ********************************************************************************
"tools/cecho"    {0A}PLACE YOUR ZIP OR IMG FILE IN THE "ORIGINAL" FOLDER THEN SELECT AN OPTION{#}
echo.
echo.
"tools/cecho"   {0A}1{#} - Start from scratch (nothing)
echo.
"tools/cecho"   {0A}2{#} - Make the rom from my current device state
echo.
"tools/cecho"   {0A}3{#} - I have a zip i would like to work on
echo.
"tools/cecho"   {0A}4{#} - I have odin firmare to work on
echo.
"tools/cecho"   {0A}5{#} - Ive got system.img and boot.img
echo.
echo.
echo ********************************************************************************
echo.
set /P selection=Please make your decision: 
IF %selection% == 1 goto startfresh
IF %selection% == 2 goto extractsystem
IF %selection% == 3 goto startfromzip
IF %selection% == 4 goto startfromodin
IF %selection% == 5 goto startfromimage
"tools/cecho" {0C}OOOPS, looks like you typed something wrong..{#}
echo.
pause>nul
goto continusetup

:startfromodin
cls
echo.
echo ********************************************************************************
"tools/cecho" {0A}  THIS OPTION EXTRACTS THE SYSTEM AND KERNEL FROM AN ODIN FLASHABLE FIRMWARE{#}
echo.
echo ********************************************************************************
mkdir "WORKING/tmp"
echo extracting tar.md5 file..
"tools/7za" x "ORIGINAL\*" -o"WORKING\tmp" "*.md5">nul
echo making md5 file zip compatible..
ren WORKING\tmp\*.md5 tmp.zip
echo extracting system..
"tools/7za" x "WORKING\tmp\tmp.zip" -o"WORKING\tmp" "system.img">nul
echo extracting kernel..
"tools/7za" x "WORKING\tmp\tmp.zip" -o"WORKING" "boot.img">nul
goto startfromimage

:startfromimage
cls
echo.
echo ********************************************************************************
"tools/cecho" {0A}  DUE TO THE FILESYSTEMS BEING UNABLE TO BE READ BY WINDOWS ITS REQUIRES SOME{#}
echo.
"tools/cecho" {0A}  HELP UNPACKING, YOU MAY NEED TO WAIT ABIT FOR EXT4UNPACKER BUT WHEN IT DOES{#}
echo.
"tools/cecho" {0A}  OPEN THE FOLLOWING FILE WITH IT{#}
echo.
echo   %current%/WORKING/tmp/system.img
"tools/cecho" {0A}  AND SELECT ALL THE FILES AND FOLDERS AND RIGHT CLICK EXTRACT TO THE FOLLOWING{#}
echo.
"tools/cecho" {0A}  FOLDER AND PRESS ENTER WHEN EXTRACTION COMPLETES{#}
echo.
echo   %current%/WORKING/system
echo ********************************************************************************
if not exist WORKING/tmp mkdir "WORKING/tmp"
IF %selection% == 4 echo extracting tar.md5 file..
IF %selection% == 4 echo making md5 file zip compatible..
if exist ORIGINAL/system.img xcopy "ORIGINAL/system.img" "WORKING/tmp/system.img*">nul
echo extracting system..
if exist ORIGINAL/boot.img xcopy "ORIGINAL/boot.img" "WORKING/tmp/boot.img*">nul
echo extracting kernel..
mkdir "WORKING\system"
"tools/ext4_unpacker.exe"
pause>nul
rmdir /s /q "WORKING/tmp"
goto buildscript

:startfresh
cls
echo.
echo ********************************************************************************
"tools/cecho" {0A}                           SETTING UP FRESH FILES{#}
echo.
echo ********************************************************************************
mkdir WORKING/system
call tools/scripts/done
goto main

:extractsystem
cls
echo.
echo ********************************************************************************
"tools/cecho" {0A}   MOVE THIS FILE TO YOUR DEVICE AND FLASH IN RECOVERY, THEN SELECT START NEW{#}
echo.
"tools/cecho" {0A}  PROJECT AND USE THE ZIP MY SYSTEM ARCHIVER MADE ON YOUR SDCARD CALLED ROM.ZIP{#}  
echo.
echo ********************************************************************************
mkdir temporary
xcopy "tools\files\systemarchiver\SystemArchiver.zip" "temporary\SystemArchiver.zip*"
%SystemRoot%\explorer.exe "temporary"
press enter once you have your "rom.zip" on yor pc
pause>nul
rmdir /s /q temporary
goto startfromzip

:startfromzip
cls
echo.
echo ********************************************************************************
"tools/cecho" {0A}                          SETTING UP ROM FROM ZIP{#}
echo.
echo ********************************************************************************
echo.
cls
echo extracting files..
"tools/7za" x "ORIGINAL\*" -o"WORKING">nul
goto buildscript

:buildscript
call tools/scripts/refresh
echo implementing rom name as display id..
if not exist "tools/config/romsettings/displayid/DisplayIdToken" (
cscript "tools/sed.vbs" "WORKING/system/build.prop" "ro.build.display.id=" "ro.build.display.id=%romname% - ">nul
echo AUTOGENERATED >> tools/config/romsettings/displayid/DisplayIdToken
)
echo detecting aroma..
if exist "WORKING/META-INF/com/google/android/aroma-config" echo aroma detected
if exist "WORKING/META-INF/com/google/android/aroma-config" echo AETOGENERATED >> tools\config\romsettings\romtoken\AromaToken>nul
echo aroma not detetcted
echo detecting installation..
if exist "WORKING/META-INF/com/google/android/updater-script" echo installation files detected
if exist "WORKING/META-INF/com/google/android/updater-script" call tools/scripts/done
if exist "WORKING/META-INF/com/google/android/updater-script" goto main
echo installation files not detected
echo removing obsolete data..
if exist "WORKING/META-INF" rmdir /s /q "WORKING/META-INF"
if %syntax% == metadata (
call tools/scripts/setmetadatasyntax
)
if %syntax% == perm (
call tools/scripts/setpermsyntax
)
echo generating tool token..
echo AUTOGENERATED >> tools/config/romsettings/installationfiles/InstallationToken
cls
if %device% == unsupported (
echo ********************************************************************************
echo  it appears your device is unsupported, the tool can be used however the only 
echo  disadvantage is that you have to manually edit the updater-script to add
echo  kernel extraction.
echo  the lines are there but commented out, all thats needed is to uncomment and 
echo  add the correct block path.
echo  also consider contacting me ricky310711@xda-developers to gain support so all
echo  users can benefit.
echo ********************************************************************************
pause
)
call tools/scripts/done
goto main

:openworking
cls
%SystemRoot%\explorer.exe "WORKING"
call tools/scripts/done
goto main

:openbuild
cls
%SystemRoot%\explorer.exe "ROMBUILD"
call tools/scripts/done
goto main

:aromaoptions
cls
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
"tools/cecho"                                  {0A}AROMA OPTIONS {#} 
echo.
echo ********************************************************************************
echo.
if not exist "tools/config/romsettings/romtoken/AromaToken" ("tools/cecho"   {0A}1{#} - Install aroma installer
echo.
"tools/cecho"   {0A}2{#} - View current aroma settings
echo.
"tools/cecho"   {0A}3{#} - Reconfigure aroma
echo.
"tools/cecho"   {0A}4{#} - Remove aroma
echo.
)
if exist "tools/config/romsettings/romtoken/AromaToken" ("tools/cecho"   {0A}C{#} - Configure preinstalled aroma
echo.
)
"tools/cecho"   {0A}0{#} - Back
echo.
echo.
echo ********************************************************************************
echo.
set menur=ricky310711
SET /P menunr=Please make your decision: 
IF %menunr% == 1 goto addaroma
IF %menunr% == 2 goto viewaromasettings
IF %menunr% == 3 goto configurearoma
IF %menunr% == 4 goto removearoma
IF %menunr% == c goto manualconfigaroma
IF %menunr% == C goto manualconfigaroma
IF %menunr% == 0 goto main
"tools/cecho" {0C}OOOPS, looks like you typed something wrong..{#}
echo.
pause>nul
goto aromaoptions

:manualconfigaroma
if exist "tools/config/romsettings/romtoken/AromaToken" goto continuemanualaromaconfig
"tools/cecho" {0A}OOPS! aroma must have been installed by this tool or after {#}
echo.
"tools/cecho" {0A}setting up your working folder, you can try running this again{#}
echo.
"tools/cecho" {0A}or reconfiguring, otherwise install aroma again with this tool{#}
echo.
"tools/cecho" {0A}or configure it manually{#}
echo.
pause
goto aromaoptions
:continuemanualaromaconfig
cls
echo.
Echo ********************************************************************************
echo.
echo   Step 1. Open the "aroma-config file with notepad++
echo   Step 2. these are the lines you have to change, they explain themselves.
echo           only edit the red parts
echo.
"tools/cecho"               ini_set("rom_name",             "{0A}EDIT-HERE{#}");
echo.
"tools/cecho"               ini_set("rom_version",          "{0A}EDIT-HERE{#}");
echo.
"tools/cecho"               ini_set("rom_author",           "{0A}EDIT-HERE{#}");
echo.
"tools/cecho"               ini_set("rom_device",           "{0A}EDIT-HERE{#}");
echo.
"tools/cecho"               ini_set("rom_date",             "{0A}EDIT-HERE{#}");
echo.
echo.
echo   Step 3. Save the file, exit and press any key!
echo ********************************************************************************
ping -n 3 -w 300 127.0.0.1 > nul
%SystemRoot%\explorer.exe "WORKING\META-INF\com\google\android"
pause
goto aromaoptions

:addaroma
if exist WORKING/META-INF/com/google/android/aroma-config "tools/cecho" {0C}ERROR: aroma is already installed.{#}
if exist WORKING/META-INF/com/google/android/aroma-config echo.
if exist WORKING/META-INF/com/google/android/aroma-config "tools/cecho" {0C}reconfigure it.{#}
if exist WORKING/META-INF/com/google/android/aroma-config echo.
if exist WORKING/META-INF/com/google/android/aroma-config pause
if exist WORKING/META-INF/com/google/android/aroma-config goto aromaoptions
cls
echo.
echo ********************************************************************************
echo.
echo  Aroma installer is a GUI installer for android, its the only one in the world
echo  and can be tricky to configure, this tool can add it for you automagically ;)
echo  credits to Amarullz for this
echo.
"tools/cecho"   {0A}1{#} - Delete current aroma files if existing(aromaconfig/binary/dir) and add the
echo.
echo       ones from this tool
echo.
"tools/cecho"   {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 0 goto aromaoptions
goto configurearoma

:removearoma
if not exist WORKING/META-INF/com/google/android/aroma-config "tools/cecho" {0C}ERROR: aroma is not yet installed.{#}
if not exist WORKING/META-INF/com/google/android/aroma-config echo.
if not exist WORKING/META-INF/com/google/android/aroma-config "tools/cecho" {0C}install it first.{#}
if not exist WORKING/META-INF/com/google/android/aroma-config echo.
if not exist WORKING/META-INF/com/google/android/aroma-config pause
if not exist WORKING/META-INF/com/google/android/aroma-config goto aromaoptions
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
echo.
echo  This will completely remove aroma and all componants. do you wish to continue?
echo.
"tools/cecho"   {0A}1{#} - Delete all aroma files 
echo.
"tools/cecho"   {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 0 goto aromaoptions
del "WORKING\META-INF\com\google\android\aroma-config"
del "WORKING\META-INF\com\google\android\update-binary"
del "WORKING\META-INF\com\google\android\update-binary-installer"
rmdir /s /q "WORKING/META-INF/com/google/android/aroma"
del "WORKING\META-INF\com\google\android\aroma\license.txt"
rmdir /s /q "tools/config/romsettings/romlicense"
rmdir /s /q "tools/config/romsettings/romversion"
rmdir /s /q "tools/config/romsettings/romdate"
rmdir /s /q "tools/config/romsettings/romdevice"
rmdir /s /q "tools/config/romsettings/romauthor"
rmdir /s /q "tools/config/romsettings/aromatheme"
mkdir "tools/config/romsettings/romdate"
mkdir "tools/config/romsettings/romauthor"
mkdir "tools/config/romsettings/romversion"
mkdir "tools/config/romsettings/romdevice"
mkdir "tools/config/romsettings/romlicense"
mkdir "tools/config/romsettings/aromatheme"
xcopy "tools\files\binary" "WORKING" /e /i /h>nul
call tools/scripts/done
goto aromaoptions

:configurearoma
del "WORKING\META-INF\com\google\android\aroma-config"
del "WORKING\META-INF\com\google\android\update-binary"
del "WORKING\META-INF\com\google\android\update-binary-installer"
rmdir /s /q "WORKING/META-INF/com/google/android/aroma"
xcopy "tools\files\aroma" "WORKING" /e /i /h>nul
del "WORKING\META-INF\com\google\android\aroma\license.txt"
rmdir /s /q "tools/config/romsettings/romlicense"
rmdir /s /q "tools/config/romsettings/romversion"
rmdir /s /q "tools/config/romsettings/romdate"
rmdir /s /q "tools/config/romsettings/romdevice"
rmdir /s /q "tools/config/romsettings/romauthor"
rmdir /s /q "tools/config/romsettings/aromatheme"
mkdir "tools/config/romsettings/romdate"
mkdir "tools/config/romsettings/romauthor"
mkdir "tools/config/romsettings/romversion"
mkdir "tools/config/romsettings/romdevice"
mkdir "tools/config/romsettings/romlicense"
mkdir "tools/config/romsettings/aromatheme"
cls 
echo.
echo ********************************************************************************
"tools/cecho"  {0A}To configure aroma follow the instructions below. {#}{0C}DO NOT{#} {0A}use special characters{#} 
echo.
echo ********************************************************************************
SET /P romauthor=Enter rom developer: 
echo AUTOGENERATED > tools/config/romsettings/romauthor/%romauthor%
SET /P romversion=Enter rom version: 
echo AUTOGENERATED > tools/config/romsettings/romversion/%romversion%
echo AUTOGENERATED > tools/config/romsettings/romdevice/%device%
SET /P romdate=Enter rom date DD.MM.YYYY: 
echo AUTOGENERATED > tools/config/romsettings/romdate/%romdate%
SET /P romlicense=Enter a quick license: 
echo %romlicense% > tools/config/romsettings/romlicense/license.txt
echo %romlicense% > WORKING/META-INF/com/google/android/aroma/license.txt
cls
echo ********************************************************************************
"tools/cecho"  {0A}Choose a theme for the aroma installer{#} 
echo.
echo ********************************************************************************
echo.
echo  1 - Honami                                   - Ayush Singh
echo  2 - Ics                                      - DemonWav ^& amarullz
echo  3 - Metrolight                               - iamareebjamal
echo  4 - Miui                                     - mickey-r ^& amarullz
echo  5 - Miui4                                    - DemonWav ^& amarullz ^& Lennox
echo  6 - Sense                                    - ???????
echo  7 - xNXT                                     - DC07
echo.
echo ********************************************************************************
SET /P selection=choose a theme: 
if %selection% == 1 echo AUTOGENERATED > tools/config/romsettings/aromatheme/hanomi
if %selection% == 2 echo AUTOGENERATED > tools/config/romsettings/aromatheme/ics
if %selection% == 3 echo AUTOGENERATED > tools/config/romsettings/aromatheme/metro
if %selection% == 4 echo AUTOGENERATED > tools/config/romsettings/aromatheme/miui
if %selection% == 5 echo AUTOGENERATED > tools/config/romsettings/aromatheme/miui4
if %selection% == 6 echo AUTOGENERATED > tools/config/romsettings/aromatheme/sense
if %selection% == 7 echo AUTOGENERATED > tools/config/romsettings/aromatheme/xnxt
FOR %%F IN (tools/config/romsettings/aromatheme/*) DO (
set tmpdata=%%~nF%%~xF
)
set romtheme=%tmpdata%
call tools/scripts/buildaroma
call tools/scripts/done
goto aromaoptions

:viewaromasettings
if not exist WORKING/META-INF/com/google/android/aroma-config "tools/cecho" {0C}ERROR: aroma is not yet installed.{#}
if not exist WORKING/META-INF/com/google/android/aroma-config echo.
if not exist WORKING/META-INF/com/google/android/aroma-config "tools/cecho" {0C}install it first.{#}
if not exist WORKING/META-INF/com/google/android/aroma-config echo.
if not exist WORKING/META-INF/com/google/android/aroma-config pause
if not exist WORKING/META-INF/com/google/android/aroma-config goto aromaoptions
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
"tools/cecho"                                   {0A}AROMA SETTINGS{#}
echo.
echo ********************************************************************************
echo.
"tools/cecho"                               {0A}Rom name{#} : %romname%
echo.
"tools/cecho"                        {0A}Aroma installer{#} : %aromaconfig%
echo.
"tools/cecho"                            {0A}Rom version{#} : %romversion%
echo.
"tools/cecho"                             {0A}Rom author{#} : %romauthor%
echo.
"tools/cecho"                         {0A}Rom build date{#} : %romdate%
echo.
"tools/cecho"                            {0A}Aroma theme{#} : %romtheme%
echo.
"tools/cecho"                                   {0A}-Aroma License-{#}
echo.
echo.
type "tools\config\romsettings\romlicense\license.txt"
echo.
echo ********************************************************************************
echo.
echo Press enter to go back
pause>nul
goto aromaoptions

:addinitd
if %initdconfig% == Yes ("tools/cecho"   {0A}You already have init.d via the tools method{#}
echo.
"tools/cecho"   {0A}no need to do this again{#}
echo.
pause
goto main
)
if %initdconfig% == Possibly ("tools/cecho"   {0A}an init.d folder was found, if you have init.d via another{#}
echo.
"tools/cecho"   {0A}method please dont use this one.{#}
echo.
"tools/cecho"   {0A}otherwise delete WORKING/system/etc/init.d folder and try again{#}
echo.
pause
goto main
)
cls
echo.
echo ********************************************************************************
echo.
echo  Init.d is the process of a trigger running scripts from /system/etc/init.d 
echo  folder on every boot, this is widely used in the android community for tweaks
echo  and even su privelleges, its also now added by default in almost all roms
echo  built from source.
echo  credits to JustArchi for his method
echo.
"tools/cecho"   {0A}1{#} - Add init.d support
echo.
"tools/cecho"   {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set /P selection=Make your decision:
IF %selection% == 0 goto main
ren WORKING\system\bin\debuggerd debuggerd.orig>nul
rmdir /s /q "WORKING/system/etc/init.d">nul
xcopy "tools\files\initd" "WORKING" /e /i /h>nul
call tools/scripts/done
goto main

:installbusybox
cls
echo.
echo ********************************************************************************
echo.
echo  Busybox is important in modern day tech, alot of apps and utillities often
echo  rely on busybox to be functional, although it is not needed its ALWAYS
echo  advised to add this to your rom.
echo  credits
echo.
"tools/cecho"    {0A}1{#} - Add busybox
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set /P selection=Make your decision:
IF %selection% == 0 goto extractionoptions
if not exist "tools/config/romsettings/installationfiles/InstallationToken" ("tools/cecho"    {0A}This doesnt contain the tools extraction files{#}
echo.
"tools/cecho"    {0A}select "Add rom extraction" to fix this{#}
echo.
pause
)
if not exist "tools/config/romsettings/installationfiles/InstallationToken" goto extractionoptions
if exist "tools/config/romsettings/busybox/BusyboxToken" ("tools/cecho"    {0A}Busybox is already included, no need to repeat this{#}
echo.
pause
goto main
)
if exist "tools/config/romsettings/busybox/BusyboxToken" goto main
if not exist "tools/config/romsettings/busybox/BusyboxToken" (if exist "WORKING/system/xbin/busybox" (if exist "tools/config/romsettings/installationfiles/InstallationToken" (echo AUTOGENERATED >> tools/config/romsettings/busybox/BusyboxToken
cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##BUSYBOXLINE##" ""
call tools/scripts/done
goto main
)
)
)
xcopy "tools\files\busybox\%architecture%" "WORKING" /e /i /h>nul
echo AUTOGENERATED >> tools/config/romsettings/busybox/BusyboxToken
cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##BUSYBOXLINE##" ""
call tools/scripts/done
goto main

:rootrom
cls
echo.
echo ********************************************************************************
echo.
echo  With root lets cut to the chase, root gives your device the abillity to mount
echo  any part of the device enabling you to make system modifications.
echo.
"tools/cecho"  {0A}MAKE SURE YOU HAVE INIT.D BEFORE YOU CONTINUE.{#}
echo.
echo.
"tools/cecho"    {0A}1{#} - Root the rom
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 1 goto startrootprocess
IF %selection% == 0 goto main
goto rootrom

:startrootprocess
if not exist "tools/config/romsettings/installationfiles/InstallationToken" ("tools/cecho"    {0A}This doesnt contain the tools extraction files{#}
echo.
"tools/cecho"    {0A}select "Add rom extraction" from extraction options to fix this{#}
echo.
pause
goto main
)
if exist "tools/config/romsettings/root/RootToken" ("tools/cecho"    {0A}This rom is already rooted, no need to repeat this{#}
echo.
pause
goto main
)
del "WORKING\system\app\Superuser.apk"
del "WORKING\system\etc\.installed_su_daemon"
del "WORKING\system\etc\install-recovery.sh"
del "WORKING\system\etc\init.d\99SuperSUDaemon"
del "WORKING\system\xbin\su"
del "WORKING\system\xbin\daemonsu"
rmdir /s /q "WORKING/system/bin/.ext"
xcopy "tools\files\root\all" "WORKING" /e /i /h
xcopy "tools\files\root\%architecture%" "WORKING" /e /i /h
echo AUTOGENERATED >> tools/config/romsettings/root/RootToken
cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##ROOTLINE##" ""
call tools/scripts/done
goto main

:extractionoptions
cls
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
"tools/cecho"                                  {0A}EXTRACTION OPTIONS {#} 
echo.
echo ********************************************************************************
echo.
"tools/cecho"   {0A}1{#} - Remove old installation files and rebuild scripts
echo.
"tools/cecho"   {0A}2{#} - Add /data extraction
echo.
"tools/cecho"   {0A}3{#} - Change what partitions to wipe
echo.
"tools/cecho"   {0A}4{#} - Add app autobackup/restore
echo.
"tools/cecho"   {0A}0{#} - Back
echo.
echo.
echo ********************************************************************************
echo.
SET /P menunr=Please make your decision: 
IF %menunr% == 1 goto addextraction 
IF %menunr% == 2 goto adddataextraction
IF %menunr% == 3 goto changewipes
IF %menunr% == 4 goto addautobackup
IF %menunr% == 0 goto main
"tools/cecho" {0C}OOOPS, looks like you typed something wrong..{#}
echo.
pause>nul
goto extractionoptions

:addextraction
cls
echo.
echo ********************************************************************************
echo.
echo  To extract and write the rom to /system the package needs to contain certain
echo  binary and a file to parse commands to recovery for instructions to unpack.
echo  these files are the updater-binary and updater-script, luckily my tool builds
echo  the script in real time to make this completely automatic.
echo  this removes all updater-script/binary and aroma files and adds the rebuils
echo  with the tools.
echo.
"tools/cecho"    {0A}1{#} - Delete current installation files if existing(updater-script/binary)
echo.
echo         aswell as aroma files and add the ones from this tool
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set /P selection=Make your decision:
IF %selection% == 0 goto extractionoptions
rmdir /s /q "WORKING\META-INF">nul
goto buildscript

:adddataextraction
cls
echo.
echo ********************************************************************************
echo.
echo  This option adds the abillity to extract a "data" folder from the package
echo.
"tools/cecho"    {0A}1{#} - Add /data extraction to installation
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set /P selection=Make your decision:
IF %selection% == 0 goto extractionoptions
if not exist "tools/config/romsettings/installationfiles/InstallationToken" ("tools/cecho"    {0A}This doesnt contain the tools extraction files{#}
echo.
"tools/cecho"    {0A}select "Add rom extraction" to fix this{#}
echo.
pause
goto extractionoptions
)
if exist "tools/config/romsettings/dataextraction/ExtractionToken" ("tools/cecho"    {0A}Data is already being extracted, no need to repeat this{#}
echo.
pause
goto extractionoptions
)
mkdir "WORKING/data"
echo AUTOGENERATED >> tools/config/romsettings/dataextraction/ExtractionToken
cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##DATALINE##" ""
call tools/scripts/done
goto extractionoptions

:changewipes
cls
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
echo.
echo  This changes what partitions to wipe on the device. by default system is
echo  alread active
echo.
if exist "tools/config/romsettings/wipes/WipedataToken" "tools/cecho"    {0A}1{#} - Data will be wiped
if not exist "tools/config/romsettings/wipes/WipedataToken" "tools/cecho"    {0A}1{#} - Wipe data on installation
echo.
if exist "tools/config/romsettings/wipes/WipecacheToken" "tools/cecho"    {0A}2{#} - Cache will be wiped
if not exist "tools/config/romsettings/wipes/WipecacheToken" "tools/cecho"    {0A}2{#} - Wipe cache on installation
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 1 goto wipedata
IF %selection% == 2 goto wipecache
goto extractionoptions

:wipedata
if not exist "tools/config/romsettings/installationfiles/InstallationToken" ("tools/cecho"    {0A}This doesnt contain the tools extraction files{#}
echo.
"tools/cecho"    {0A}select "Add rom extraction" to fix this{#}
echo.
pause
goto extractionoptions
)
if exist "tools/config/romsettings/wipes/WipedataToken" ("tools/cecho"    {0A}Data is already gonna be wiped, no need to repeat this{#}
echo.
pause
goto changewipes
)
if %devicetype% == samsung xcopy "tools\files\safewipe" "WORKING" /e /i /h>nul
if not exist "tools/config/romsettings/wipes/WipedataToken" echo AUTOGENERATED >> tools/config/romsettings/wipes/WipedataToken
call tools/scripts/done
goto changewipes

:wipecache
if not exist "tools/config/romsettings/installationfiles/InstallationToken" ("tools/cecho"    {0A}This doesnt contain the tools extraction files{#}
echo.
"tools/cecho"    {0A}select "Add rom extraction" to fix this{#}
echo.
pause
goto extractionoptions
)
if exist "tools/config/romsettings/wipes/WipecacheToken" ("tools/cecho"    {0A}Cache is already gonna be wiped, no need to repeat this{#}
echo.
pause
goto changewipes
)
if not exist "tools/config/romsettings/wipes/WipecacheToken" echo AUTOGENERATED >> tools/config/romsettings/wipes/WipecacheToken
call tools/scripts/done
goto changewipes

:addautobackup
cls
echo.
echo ********************************************************************************
echo.
echo  This is a system i made to backup and resore the apps in /data/app and restore
echo  after the rom installation, this script renders a data wipe available without
echo  without losing apps and should be considered by default with every rom.
echo.
"tools/cecho"    {0A}1{#} - Add /data/app backup script to rom
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set /P selection=Make your decision:
IF %selection% == 0 goto extractionoptions
if not exist "tools/config/romsettings/installationfiles/InstallationToken" ("tools/cecho"    {0A}This doesnt contain the tools extraction files{#}
echo.
"tools/cecho"    {0A}select "Add rom extraction" to fix this{#}
echo.
pause
goto extractionoptions
)
if exist "tools/config/romsettings/autobackup/BackupToken" ("tools/cecho"    {0A}Autobackup is already implemented, no need to repeat this{#}
echo.
pause
goto extractionoptions
)
cls
xcopy "tools\files\appbackup" "WORKING" /e /i /h>nul
if not exist "tools/config/romsettings/autobackup/BackupToken" echo AUTOGENERATED >> tools/config/romsettings/autobackup/BackupToken
cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##BACKUPAPPSLINE##" ""
call tools/scripts/done
goto extractionoptions

:requestdevicesupport
echo.
echo ********************************************************************************
echo.
echo  This device is unsupported, everyting in the tool still works, however, the
echo  kernel will not be flashed with the rom.
echo  To add support for your device, contact me ricky310711@xda-developers.com to 
echo  request support, it takes 2 seconds to add support for the device!
echo.
echo ********************************************************************************
pause

:information
cls
call tools/scripts/refresh
cls
echo.
echo ********************************************************************************
"tools/cecho"                        {0A}  RICKYS ROM KITCHEN BY RICKY310711{#}
echo.
echo ********************************************************************************
echo.
"tools/cecho"                               {0A}Rom name{#} : %romname%
echo.
"tools/cecho"                        {0A}Aroma installer{#} : %aromaconfig%
echo.
"tools/cecho"                            {0A}Rom version{#} : %romversion%
echo.
"tools/cecho"                             {0A}Rom author{#} : %romauthor%
echo.
"tools/cecho"                         {0A}Rom build date{#} : %romdate%
echo.
"tools/cecho"                            {0A}Aroma theme{#} : %romtheme%
echo.
"tools/cecho"                                  {0A}Wipes{#} : system%wipedata%%wipecache%
echo.
"tools/cecho"                                 {0A}Init.d{#} : %initdconfig%
echo.
"tools/cecho"                       {0A}Root permissions{#} : %rootconfig%
echo.
"tools/cecho"                                {0A}Busybox{#} : %busyboxconfig%
echo.
"tools/cecho"                               {0A}Deodexed{#} : %deodexconfig%
echo.
"tools/cecho"                     {0A}Sysrw/Sysro binary{#} : %sysrwrobinary%
echo.
"tools/cecho"                    {0A}Device architecture{#} : %architecture%
echo.
"tools/cecho"                            {0A}Kernel path{#} : %kernel%
echo.
"tools/cecho"                       {0A}Insecure ramdisk{#} : %insecureramdisk%
echo.
"tools/cecho"                                   {0A}Knox{#} : %knox%
echo.
"tools/cecho"                     {0A}Installation files{#} : %installationconfig%
echo.
"tools/cecho"                 {0A}Data folder extraction{#} : %dataextraction%
echo.
"tools/cecho"                         {0A}App autobackup{#} : %autobackup%
echo.
"tools/cecho"                       {0A}Modified density{#} : %densityconfig%
echo.
"tools/cecho"                          {0A}GPU rendering{#} : %gpurendering%
echo.
"tools/cecho"              {0A}Current permission syntax{#} : %currentsyntax%
echo.
"tools/cecho"                   {0A}Bitcode verification{#} : %bitcodeverification%
echo.
"tools/cecho"                          {0A}Bootanimation{#} : %bootanimation%
echo.
"tools/cecho"                      {0A}Compression level{#} : %compression%
echo.
"tools/cecho"                              {0A}API level{#} : %api%
echo.
"tools/cecho"                               {0A}Heapsize{#} : %heapsize%  
echo.
if exist "tools\config\romsettings\romlicense\license.txt" "tools/cecho"                                   {0A}-Aroma License-{#}
if exist "tools\config\romsettings\romlicense\license.txt" echo.
echo.
if exist "tools\config\romsettings\romlicense\license.txt" type "tools\config\romsettings\romlicense\license.txt"
if exist "tools\config\romsettings\romlicense\license.txt" echo.
echo ********************************************************************************
echo.
echo Press enter to go back to main menu
pause>nul
goto main

:buildrom
cls
echo.
echo ********************************************************************************
echo.
echo  This option will build the rom from the WORKING folder
echo.
"tools/cecho"    {0A}1{#} - Build rom from working folder
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 0 goto main
echo.
echo this could take a while, go grab a snack!
echo.
set tmpdata=
FOR %%F IN (ROMBUILD/*) DO (
set tmpdata=%%~nF%%~xF
)
set delfile=%tmpdata%
if exist WORKING/META-INF/CERT.RSA del /Q "WORKING\META-INF\CERT.RSA">nul
if exist WORKING/META-INF/CERT.SF del /Q "WORKING\META-INF\CERT.SF">nul
if exist WORKING/META-INF/MANIFEST.MF del /Q "WORKING\META-INF\MANIFEST.MF">nul
del /Q "ROMBUILD\%delfile%">nul
set tmpdata=
set delfile=
cd WORKING
call "../tools/7za.exe" a -mx9 -tzip "../ROMBUILD/tmp" * >nul
cd ..
echo.
cls
echo.
echo ********************************************************************************
echo.
echo                               Sign rom aswell?
echo                                     y/n
echo.
echo ********************************************************************************
set /P selection=Make your decision:
IF %selection% == n ren "ROMBUILD\tmp.zip" "unsigned_%romname%_%Date:~-7,2%-%Date:~-10,2%-%Date:~-4,4%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%.zip"
IF %selection% == n goto main
java -Xmx%heapsize%m -jar "tools/signapk.jar" -w "tools/testkey.x509.pem" "tools/testkey.pk8" "ROMBUILD/tmp.zip" "ROMBUILD/%romname%_%Date:~-7,2%-%Date:~-10,2%-%Date:~-4,4%_%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2%.zip"
del /Q "ROMBUILD\tmp.zip">nul
call tools/scripts/done
goto main

:pushbuild
cls
echo.
echo ********************************************************************************
echo.
echo  This option will push the rom to the device.
echo.
"tools/cecho"    {0A}1{#} - Push the latest build to sdcard via adb
echo.
"tools/cecho"    {0A}2{#} - Sideload the latest build via adb
echo.
"tools/cecho"    {0A}0{#} - Go back
echo.
echo.
echo ********************************************************************************
echo.
set selection=RICKY310711
set /P selection=Make your decision:
IF %selection% == 1 goto pushsdcard
IF %selection% == 2 goto pushsideload
IF %selection% == 0 goto main
goto pushbuild

:pushsdcard
if not exist "ROMBUILD/*.zip" ("tools/cecho"    {0A}No build was found, please build first.{#}
echo.
pause
goto main
)
set tmpdata=
FOR %%F IN (ROMBUILD/*) DO (
set tmpdata=%%~nF%%~xF
)
set pushfile=%tmpdata%
echo Waiting for device response
"tools/adb" wait-for-device
echo Pushing %pushfile% to /sdcard, this could take some time..
"tools/adb" push "ROMBUILD/%pushfile%" sdcard/
call tools/scripts/done
goto main

:pushsideload
if not exist "ROMBUILD/*.zip" ("tools/cecho"    {0A}No build was found, please build first.{#}
echo.
pause
goto main
)
set tmpdata=
FOR %%F IN (ROMBUILD/*) DO (
set tmpdata=%%~nF%%~xF
)
set pushfile=%tmpdata%
echo put your device in recovery and activate sideloading now.
pause
echo Pushing %pushfile% to /sdcard, this could take some time..
"tools/adb" sideload "ROMBUILD/%pushfile%"
call tools/scripts/done
goto main
