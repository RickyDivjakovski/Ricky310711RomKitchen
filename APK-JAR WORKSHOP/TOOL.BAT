@ECHO off
mode con:cols=123 lines=40
set /A count+=1
if %count%==1 del "tools\LOG.TXT"
if %count%==1 echo. >> tools/LOG.TXT
if %count%==1 echo ################################################################################ >> tools/LOG.TXT
if %count%==1 echo START DATE: %Date:~-7,2%-%Date:~-10,2%-%Date:~-4,4% >> tools/LOG.TXT
if %count%==1 echo START TIME:%TIME:~0,2%.%TIME:~3,2%.%TIME:~6,2% >> tools/LOG.TXT
if %count%==1 echo. >> tools/LOG.TXT
if %count%==1 echo. >> tools/LOG.TXT
if %count%==1 echo. >> tools/LOG.TXT
if %count%==1 call TOOL 0 2>> tools/LOG.TXT
set count=0
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
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "%~s0", "%params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
cls
COLOR 0B
IF (%1)==(0) goto yeap
IF (%1) neq () goto quit
ECHO ********************************************************************************************* >> tools/LOG.TXT
ECHO                                  %date%/%time% >> tools/LOG.TXT
ECHO ********************************************************************************************* >> tools/LOG.TXT
ECHO ********************************************************************************************* >> tools/VERBALLOG.TXT
ECHO                     VERBAL LOG STARTED AT %date%/%time% >> tools/VERBALLOG.TXT
ECHO ********************************************************************************************* >> tools/VERBALLOG.TXT
:yeap
cd "%~dp0"
mkdir framework
mkdir add_apk_here
mkdir add_jar_here
mkdir compiled_apk
mkdir compiled_jar
CLS
set comp=9
set heap=512
set apk=
set jar=
java -version 
IF errorlevel 1 goto nojava
ECHO  Java installation detected >> tools/VERBALLOG.TXT
ECHO  Compression level 9 >> tools/VERBALLOG.TXT
ECHO  Java heap size 512 >> tools/VERBALLOG.TXT
ECHO  Working apk %apk% >> tools/VERBALLOG.TXT
ECHO  Working jar %jar% >> tools/VERBALLOG.TXT
ECHO ********************************************************************************************* >> tools/VERBALLOG.TXT
:start
set apk=
set jar=
set cla=
FOR %%F IN (add_apk_here/*.apk) DO (
set apk=%%~nF%%~xF
)
FOR %%F IN (add_jar_here/*.jar) DO (
set jar=%%~nF%%~xF
)
IF EXIST "add_classes_here/classes.dex" set cla=Yes
COLOR 0B
cd "%~dp0"
CLS
ECHO  --------------------------------------------------------------------------------------------------------------------------
ECHO                                          ^| Compression-Level: %comp% ^| Heap Size: %heap%mb ^|
ECHO  --------------------------------------------------------------------------------------------------------------------------
ECHO                                            Working Apk:    %apk% 
ECHO                                            Working Jar:    %jar% 
ECHO                                            Classes.dex:    %cla%   
ECHO.
ECHO  ------------------------------------       ------------------------------------       ------------------------------------
ECHO           Apk Code Editing                          Classes.dex Editing                           Jar Code Editing
ECHO  ------------------------------------       ------------------------------------       ------------------------------------
ECHO   1    Decompile apk                             4    Decompile classes.dex             6    Decompile classes from jar
ECHO   2    Compile apk                               5    Compile classes.dex               7    Compile classes for jar
ECHO   3    Sign apk                                                                        
ECHO.
ECHO  ------------------------------------                                                  ------------------------------------
ECHO            Advanced Options                                                                        Other Options
ECHO  ------------------------------------                                                  ------------------------------------
ECHO   8    Select compression level                                                         C    Clear tool data
ECHO   9    Set max memory size                                                              R    Refresh
ECHO  10    View process log                                                                 Q    Quit
ECHO  11    View verbose log
ECHO  12    Install framework
ECHO  --------------------------------------------------------------------------------------------------------------------------
set choice=
SET /P choice=What would you like to do:
IF %choice%==1 (goto apkdecompile)
IF %choice%==2 (goto apkcompile)
IF %choice%==3 (goto apksign)
IF %choice%==4 (goto decomcla)
IF %choice%==5 (goto comcla)
IF %choice%==6 (goto decomjar)
IF %choice%==7 (goto comjar)
IF %choice%==8 (goto comp)
IF %choice%==9 (goto heap)
IF %choice%==10 (goto logone)
IF %choice%==11 (goto logtwo)
IF %choice%==12 (goto installframework)
IF %choice%==c (goto clear)
IF %choice%==C (goto clear)
IF %choice%==r (goto start)
IF %choice%==R (goto start)
IF %choice%==Q (goto quit)
IF %choice%==q (goto quit)
echo.
COLOR 0C
echo                                                  PLEASE MAKE A VALID SELECTION
ping -n 2 -w 200 127.0.0.1 > nul
goto start

:decomcla
IF NOT EXIST "add_classes_here/classes.dex" goto decomclaerror
ECHO  Starting decompiling process for classes.dex file >> tools/VERBALLOG.TXT
rmdir "working/classout" /s /q
java -jar tools/baksmali.jar -o "working/classout/" "add_classes_here/classes.dex" >nul
IF errorlevel 1 (
ECHO "An Error Occured, Check The Log"
PAUSE
goto decomerror
)
ECHO  Finished decompiling process for classes.dex file >> tools/VERBALLOG.TXT
ECHO  Folder created "working/classout" >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:comcla
ECHO  Starting compiling classes.dex process for jar file %jar% >> tools/VERBALLOG.TXT
IF NOT EXIST "%~dp0working\classout" GOTO clacompilenothing
rmdir "compiled_classes" /s /q
mkdir "compiled_classes"
java -Xmx%heap%M -jar tools/smali.jar "working/classout/" -o "compiled_classes/classes.dex" >nul
IF errorlevel 1 (
ECHO "An Error Occured, Check The Log"
PAUSE
goto comerror
)
ECHO  Finished compiling classes.dex process process >> tools/VERBALLOG.TXT
ECHO  File created "compiled_classes/classes.dex" >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:clacompilenothing
ECHO  No classout folder to compile >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:decomclaerror
ECHO  Error while decompiling classes.dex, file not detected >> tools/VERBALLOG.TXT >nul
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT >nul
goto start 

:decomjar
ECHO  Starting decompiling process for jar file %jar% >> tools/VERBALLOG.TXT
rmdir "working/%jar%" /s /q
"%~dp0tools\7za.exe" x -o"working/%jar%" "add_jar_here/%jar%"
copy "working\%jar%\classes.dex" "working" 
rmdir "working/%jar%" /s /q
mkdir "working/%jar%"
copy "working\classes.dex" "working/%jar%" 
del "working\classes.dex" /q
java -jar tools/baksmali.jar -o "working/%jar%/classout/" "working/%jar%/classes.dex" >nul
IF errorlevel 1 (
ECHO "An Error Occured, Check The Log"
PAUSE
goto decomerror
)
ECHO  Finished decompiling process for jar file %jar% >> tools/VERBALLOG.TXT
ECHO  Folder created "working/%jar%" >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:decomerror
ECHO  Error while decompiling jar file %jar% >> tools/VERBALLOG.TXT >nul
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT >nul
goto start 

:comjar
ECHO  Starting compiling classes.dex process for jar file %jar% >> tools/VERBALLOG.TXT
IF NOT EXIST "%~dp0working\%jar%\classout" GOTO jarcompilenothing
rmdir "compiled_jar/%jar%" /s /q
mkdir "compiled_jar/%jar%"
del "add_jar_here\classes.dex" /q
del "compiled_jar\%jar%\old-classes.dex" /q
copy "add_jar_here\%jar%" "compiled_jar/%jar%"
java -Xmx%heap%M -jar tools/smali.jar "working/%jar%/classout/" -o "compiled_jar/%jar%/classes.dex" >nul
IF errorlevel 1 (
ECHO "An Error Occured, Check The Log"
PAUSE
goto comerror
)
copy "add_jar_here/classes.dex" "compiled_jar/%jar%/new-classes.dex" 
ECHO  Finished compiling classes.dex process for jar file %jar% >> tools/VERBALLOG.TXT
ECHO  File created "add_jar_here/classes.dex" >> tools/VERBALLOG.TXT
ECHO  Old classes at "compiled_jar\%jar%\old-classes.dex" >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:jarcompilenothing
ECHO  Nothing found in "working/%jar%" to compile >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:comerror
ECHO  Error while compiling classes.dex for jar file %jar% >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:heap
set /P INPUT=Enter max size for java heap space in megabytes (eg 512) : %=%
set heap=%INPUT%
ECHO  Java heap size changed to %INPUT% >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
CLS
goto start

:comp
set /P INPUT=Enter Compression Level (0-9) : %=%
set comp=%INPUT%
ECHO  Compression level changed to %INPUT% >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
CLS
goto start

:apkdecompile
ECHO  Starting decompiling process for apk file %apk% >> tools/VERBALLOG.TXT
cd tools
IF EXIST "../add_apk_here/unsigned%apk%" (del /Q "../add_apk_here\unsigned%apk%")
IF EXIST "../add_apk_here/signed%apk%" (del /Q "../add_apk_here\signed%apk%")
IF EXIST "../working/%apk%" (rmdir /S /Q "../working/%apk%")
java -Xmx%heap%m -jar apktool.jar d ../add_apk_here/%apk% ../working/%apk%
IF errorlevel 1 (
ECHO "An Error Occured,Check The Log"
PAUSE
cd ..
goto apkdecomerror
)
cd ..
ECHO  Finished decompiling process for apk file %apk% >> tools/VERBALLOG.TXT
ECHO  Folder created "working/%apk%" >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:apkdecomerror
ECHO  Error while decompiling apk file %apk% >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:apkcompile
IF EXIST "compiled_apk/%apk%" (rmdir /S /Q "compiled_apk/%apk%")
mkdir "compiled_apk/%apk%"
copy "add_apk_here\%apk%" "compiled_apk/%apk%" 
ECHO  Starting compiling process for apk file %apk% >> tools/VERBALLOG.TXT
IF NOT EXIST "%~dp0working\%apk%" GOTO apkcompilenothing
cd tools
IF EXIST "%~dp0compiled_apk\%apk%\unsigned%apk%" (del /Q "%~dp0compiled_apk\%apk%\unsigned%apk%")
java -Xmx%heap%m -jar apktool.jar b "../working/%apk%" "%~dp0compiled_apk\%apk%\unsigned%apk%"
IF errorlevel 1 (
ECHO.
ECHO.
ECHO.
ECHO ERROR, CHECK THE LOG
PAUSE
goto apkacomerror
)
7za x -o"../working/temp" "../add_apk_here/%apk%" META-INF -r
7za a -tzip "../compiled_apk/%apk%/unsigned%apk%" "../working/temp/*" -mx%comp% -r
cd ..
rmdir working\temp /s /q
rmdir "working\%apk%\build" /s /q
ECHO  Finished compiling apk file %apk% >> tools/VERBALLOG.TXT
ECHO  File created "compiled_apk/%apk%\unsigned%apk%" >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:apkcompilenothing
ECHO  Nothing found in "working/%apk%" to compile >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:apkacomerror
cd ..
ECHO  Error while compiling apk file %apk% >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:apksign
ECHO  Starting signing process for apk file %apk% >> tools/VERBALLOG.TXT
IF NOT EXIST "%~dp0compiled_apk\%apk%\unsigned%apk%" GOTO apksignnothing
cd tools
ECHO Signing Apk
java -Xmx%heap%m -jar signapk.jar -w testkey.x509.pem testkey.pk8 ../compiled_apk/%apk%/unsigned%apk% ../compiled_apk/%apk%/signed%apk%
IF errorlevel 1 (
ECHO "An Error Occured, Check The Log"
PAUSE
goto apksignerror
)
cd ..
ECHO  Finished signing apk file %apk% >> tools/VERBALLOG.TXT
ECHO  File created in "/compiled_apk/%apk%/signed%apk%" >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:apksignnothing
ECHO  No unsigned%apk% to sign >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:apksignerror
cd..
ECHO  Error while signing apk file %apk% >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
goto start

:logone
cd tools
start readlog1
cd ..
goto start

:logtwo
cd tools
Start readlog2
cd ..
goto start

:installframework
cls
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  --------------------------------------------------------------------------------------------------------------------------
ECHO                          To install framework place the following files in the framework folder     
ECHO                                         If you dont have some, dont be alarmed 
ECHO.
ECHO                                                framework-res.apk                                  
ECHO                                               twframework-res.apk                                 
ECHO                                              com.htc.resources.apk                                
ECHO                                              SemcGenericUxpRes.apk                               
ECHO                                                  SystemUI.apk                                    
ECHO  --------------------------------------------------------------------------------------------------------------------------
ECHO                                            Press enter to continue
pause >nul
copy "framework\framework-res.apk" "tools" >nul
copy "framework\twframework-res.apk" "tools" >nul
copy "framework\com.htc.resources.apk" "tools" >nul
copy "framework\SemcGenericUxpRes.apk" "tools" >nul
copy "framework\SystemUI.apk" "tools" >nul
cd tools
ECHO ********************************************************************************************* >> INSTALLLOG.TXT
ECHO                     FRAMEWORK INSTALLATION LOG STARTED AT %date%/%time% >> INSTALLLOG.TXT
ECHO ********************************************************************************************* >> INSTALLLOG.TXT
IF NOT EXIST framework-res.apk (
ECHO  No framework-res.apk detected >> INSTALLLOG.TXT
)
IF EXIST framework-res.apk (
ECHO  Framework-res.apk detected >> INSTALLLOG.TXT
ECHO Installing framework-res.apk
ECHO  Installing framework-res.apk >> INSTALLLOG.TXT
java -jar apktool.jar if framework-res.apk
ECHO  Installed framework-res.apk
ECHO  Installed framework-res.apk >> INSTALLLOG.TXT
)

ECHO  --------------------------------------------- >> INSTALLLOG.TXT
IF NOT EXIST twframework-res.apk (
ECHO  No twframework-res.apk detected >> INSTALLLOG.TXT
)
IF EXIST twframework-res.apk (
ECHO  twframework-res.apk detected >> INSTALLLOG.TXT
ECHO Installing twframework-res.apk
ECHO  Installing twframework-res.apk >> INSTALLLOG.TXT
java -jar apktool.jar if twframework-res.apk
ECHO  Installed twframework-res.apk
ECHO  Installed twframework-res.apk >> INSTALLLOG.TXT
)

ECHO  --------------------------------------------- >> INSTALLLOG.TXT
IF NOT EXIST com.htc.resources.apk (
ECHO  No com.htc.resources.apk detected >> INSTALLLOG.TXT
)
IF EXIST com.htc.resources.apk (
ECHO  com.htc.resources.apk detected >> INSTALLLOG.TXT
ECHO Installing com.htc.resources.apk
ECHO  Installing com.htc.resources.apk >> INSTALLLOG.TXT
java -jar apktool.jar if com.htc.resources.apk
ECHO  Installed com.htc.resources.apk
ECHO  Installed com.htc.resources.apk >> INSTALLLOG.TXT
)

ECHO  --------------------------------------------- >> INSTALLLOG.TXT
IF NOT EXIST SemcGenericUxpRes.apk (
ECHO  No SemcGenericUxpRes.apk detected >> INSTALLLOG.TXT
)
IF EXIST SemcGenericUxpRes.apk (
ECHO  SemcGenericUxpRes.apk detected >> INSTALLLOG.TXT
ECHO Installing SemcGenericUxpRes.apk
ECHO  Installing SemcGenericUxpRes.apk >> INSTALLLOG.TXT
java -jar apktool.jar if SemcGenericUxpRes.apk
ECHO  Installed SemcGenericUxpRes.apk
ECHO  Installed SemcGenericUxpRes.apk >> INSTALLLOG.TXT
)

ECHO  --------------------------------------------- >> INSTALLLOG.TXT
IF NOT EXIST SystemUI.apk (
ECHO  No SystemUI.apk detected >> INSTALLLOG.TXT
)
IF EXIST SystemUI.apk (
ECHO  SystemUI.apk detected >> INSTALLLOG.TXT
ECHO Installing SystemUI.apk
ECHO  Installing SystemUI.apk >> INSTALLLOG.TXT
java -jar apktool.jar if SystemUI.apk
ECHO  Installed SystemUI.apk
ECHO  Installed SystemUI.apk >> INSTALLLOG.TXT
)
del framework-res.apk /q
del twframework-res.apk /q
del com.htc.resources.apk /q
del SystemUI.apk /q
del SemcGenericUxpRes.apk /q
cls
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  --------------------------------------------------------------------------------------------------------------------------
ECHO                                        Framework successfully installed                        
ECHO  --------------------------------------------------------------------------------------------------------------------------
ping -n 4 -w 400 127.0.0.1 > nul
cd ..
goto start

:clear
echo.
ECHO  --------------------------------------------------------------------------------------------------------------------------
ECHO                         THIS COULD TAKE A WHILE DEPENDING ON THE ITEMS IN YOUR WORKING FOLDER                    
ECHO  --------------------------------------------------------------------------------------------------------------------------
del tools\LOG.TXT /q
del tools\VERBALLOG.TXT /q
del tools\INSTALLLOG.TXT /q
rmdir framework /s /q
mkdir framework
rmdir working /s /q
mkdir working
rmdir add_apk_here /s /q
mkdir add_apk_here
rmdir add_jar_here /s /q
mkdir add_jar_here
rmdir add_classes_here /s /q
mkdir add_classes_here
rmdir compiled_classes /s /q
mkdir compiled_classes
rmdir compiled_apk /s /q
mkdir compiled_apk
rmdir compiled_jar /s /q
mkdir compiled_jar
goto start

:nojava
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 10 SECONDS
ECHO  Java installation not detected >> tools/VERBALLOG.TXT
ECHO  Tool shutting down >> tools/VERBALLOG.TXT
ECHO ---------------------------------------------------- >> tools/VERBALLOG.TXT
ping -n 1 -w 100 127.0.0.1 > nul
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 9 SECONDS
ping -n 1 -w 100 127.0.0.1 > nul
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 8 SECONDS
ping -n 1 -w 100 127.0.0.1 > nul
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 7 SECONDS
ping -n 1 -w 100 127.0.0.1 > nul
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 6 SECONDS
ping -n 1 -w 100 127.0.0.1 > nul
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 5 SECONDS
ping -n 1 -w 100 127.0.0.1 > nul
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 4 SECONDS
ping -n 1 -w 100 127.0.0.1 > nul
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 3 SECONDS
ping -n 1 -w 100 127.0.0.1 > nul
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 2 SECONDS
ping -n 1 -w 100 127.0.0.1 > nul
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                             A JAVA INSTALLATION WAS NOT FOUND, YOU CANNOT CONTINUE WITHOUT IT
ECHO                                                TOOL CLOSING IN 1 SECONDS
ping -n 1 -w 100 127.0.0.1 > nul

:quit
exit