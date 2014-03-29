"tools/cecho" {0A} REFRESHING ROM STATS{#}
set romname=None
set romversion=None
set romauthor=None
set romdate=None
set aromaconfig=No
set romdevice=None
set architecture=None
set romlicence=None
set romtheme=None
set initdconfig=No
set knox=Yes
set rootconfig=No
set busyboxconfig=No
set deodexconfig=No
set bitcodeverification=Yes
set installationconfig=No
set densityconfig=Stock
set sysrwrobinary=No
set insecureramdisk=No
set wipedata=
set devicetype=normal
set wipecache=
set api=
set compression=
set heapsize=
set syntax=
set autobackup=
set dataextraction=
set bootanimation=
set gpurendering=
set kernel=
set device=

set tmpdata=
FOR %%F IN (tools/config/toolsettings/compression/*) DO (
set tmpdata=%%~nF%%~xF
)
set compression=%tmpdata%
set tmpdata=
FOR %%F IN (tools/config/toolsettings/heapsize/*) DO (
set tmpdata=%%~nF%%~xF
)
set heapsize=%tmpdata%
set tmpdata=
FOR %%F IN (tools/config/toolsettings/syntax/*) DO (
set tmpdata=%%~nF%%~xF
)
set syntax=%tmpdata%
set tmpdata=
FOR %%F IN (tools/config/romsettings/romname/*) DO (
set tmpdata=%%~nF%%~xF
)
set romname=%tmpdata%
set tmpdata=
FOR %%F IN (tools/config/romsettings/romversion/*) DO (
set tmpdata=%%~nF%%~xF
)
set romversion=%tmpdata%
set tmpdata=
FOR %%F IN (tools/config/romsettings/romauthor/*) DO (
set tmpdata=%%~nF%%~xF
)
set romauthor=%tmpdata%
set tmpdata=
FOR %%F IN (tools/config/romsettings/romdevice/*) DO (
set tmpdata=%%~nF%%~xF
)
set romdevice=%tmpdata%
set tmpdata=
FOR %%F IN (tools/config/romsettings/romdate/*) DO (
set tmpdata=%%~nF%%~xF
)
set romdate=%tmpdata%
set tmpdata=
FOR %%F IN (tools/config/romsettings/romlicense/*) DO (
set tmpdata=%%~nF%%~xF
)
set romlicense=%tmpdata%
set tmpdata=
FOR %%F IN (tools/config/romsettings/aromatheme/*) DO (
set tmpdata=%%~nF%%~xF
)
set romtheme=%tmpdata%

"tools/fart" "WORKING\system\build.prop" "abi=x86" "abi=x86tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "abi=x86tmp" "abi=x86" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set architecture=x86
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "abi=arm" "abi=armtmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "abi=armtmp" "abi=arm" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set architecture=arm
set tmp=
)

"tools/fart" "WORKING\system\build.prop" "sdk=19" "sdk=19tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=19tmp" "sdk=19" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=19
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=18" "sdk=18tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=18tmp" "sdk=18" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=18
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=17" "sdk=17tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=17tmp" "sdk=17" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=17
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=16" "sdk=16tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=16tmp" "sdk=16" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=16
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=15" "sdk=15tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=15tmp" "sdk=15" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=15
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=14" "sdk=14tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=14tmp" "sdk=14" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=14
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=13" "sdk=13tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=13tmp" "sdk=13" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=13
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=12" "sdk=12tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=12tmp" "sdk=12" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=12
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=11" "sdk=11tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=11tmp" "sdk=11" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=11
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=10" "sdk=10tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=10tmp" "sdk=10" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=10
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=9" "sdk=9tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=9tmp" "sdk=9" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=18
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=8" "sdk=8tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=8tmp" "sdk=8" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=8
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=7" "sdk=7tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=7tmp" "sdk=7" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=7
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=6" "sdk=6tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=6tmp" "sdk=6" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=6
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=5" "sdk=5tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=5tmp" "sdk=5" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=5
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=4" "sdk=4tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=4tmp" "sdk=4" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=4
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "sdk=3" "sdk=3tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "sdk=3tmp" "sdk=3" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set api=3
set tmp=
)

"tools/fart" "WORKING\META-INF\com\google\android\updater-script" "set_perm" "set_permtmp" >tmp.txt
"tools/fart" "WORKING\META-INF\com\google\android\updater-script" "set_permtmp" "set_perm" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\META-INF\com\google\android\updater-script" (
set currentsyntax=set_perm
set tmp=
)
"tools/fart" "WORKING\META-INF\com\google\android\updater-script" "set_metadata" "set_metadatatmp" >tmp.txt
"tools/fart" "WORKING\META-INF\com\google\android\updater-script" "set_metadatatmp" "set_metadata" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\META-INF\com\google\android\updater-script" (
set currentsyntax=set_metadata
set tmp=
)

set device=unsupported
set kernel=##KERNELBLOCKPATH##
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9000" "ro.product.model=GT-I9000tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9000tmp" "ro.product.model=GT-I9000" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9000
set kernel=/dev/block/bml7
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9001" "ro.product.model=GT-I9001tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9001tmp" "ro.product.model=GT-I9001" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9001
set kernel=/dev/block/mmcblk0p8
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9100G" "ro.product.model=GT-I9100Gtmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9100Gtmp" "ro.product.model=GT-I9100G" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9100G
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9300" "ro.product.model=GT-I9300tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9300tmp" "ro.product.model=GT-I9300" >tmp.txt
set /p tmp=<tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop">nul (
set device=GT-I9300
set kernel=/dev/block/mmcblk0p5
set tmp
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9305" "ro.product.model=GT-I9305tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9305tmp" "ro.product.model=GT-I9305" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9305
set kernel=/dev/block/mmcblk0p8
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9500" "ro.product.model=GT-I9500tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9500tmp" "ro.product.model=GT-I9500" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9500
set kernel=/dev/block/mmcblk0p9
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9505" "ro.product.model=GT-I9505tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9505tmp" "ro.product.model=GT-I9505" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9505
set kernel=/dev/block/mmcblk0p20
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-N7100" "ro.product.model=GT-N7100tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-N7100tmp" "ro.product.model=GT-N7100" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-N7100
set kernel=/dev/block/mmcblk0p8
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-N7105" "ro.product.model=GT-N7105tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-N7105tmp" "ro.product.model=GT-N7105" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-N7105
set kernel=/dev/block/mmcblk0p8
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3100" "ro.product.model=GT-P3100tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3100tmp" "ro.product.model=GT-P3100" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P3100
set kernel=/dev/block/mmcblk0p5
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3110" "ro.product.model=GT-P3110tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3110tmp" "ro.product.model=GT-P3110" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P3110
set kernel=/dev/block/mmcblk0p5
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3113" "ro.product.model=GT-P3113tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3113tmp" "ro.product.model=GT-P3113" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-N7105
set kernel=/dev/block/mmcblk0p5
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-D802" "ro.product.model=LG-D802tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-D802tmp" "ro.product.model=LG-D802" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=LG-D802
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-MS870" "ro.product.model=LG-MS870tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-MS870tmp" "ro.product.model=LG-MS870" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=LG-MS870
set kernel=/dev/block/mmcblk0p7
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SGH-M919" "ro.product.model=SGH-M919tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SGH-M919tmp" "ro.product.model=SGH-M919" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SGH-M919
echo set kernel=/dev/block/mmcblk0p20
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-G900F" "ro.product.model=SM-G900Ftmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-G900Ftmp" "ro.product.model=SM-G900F" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SM-G900F
echo set kernel=/dev/block/mmcblk0p15
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-N900T" "ro.product.model=SM-N900Ttmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-N900Ttmp" "ro.product.model=SM-N900T" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SM-N900T
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-N9005" "ro.product.model=SM-N9005tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-N9005tmp" "ro.product.model=SM-N9005" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SM-N9005
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P7500" "ro.product.model=GT-P7500tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P7500tmp" "ro.product.model=GT-P7500" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P7500
set kernel=/dev/block/platform/sdhci-tegra.3/by-num/p3 
set tmp=
call tools/devicedatabase/%device%
)
"tools/fart" "WORKING\system\build.prop" "ro.product.manufacturer=samsung" "ro.product.manufacturer=samsungtmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.manufacturer=samsungtmp" "ro.product.manufacturer=samsung" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set devicetype=samsung
set tmp=
)

set autobackup=No
if exist "WORKING/tmp/appbackup.sh" (
if exist "WORKING/tmp/apprestore.sh" echo AUTOGENERATED > tools/config/romsettings/autobackup/BackupToken
if exist "WORKING/tmp/apprestore.sh" set autobackup=Yes
if exist "WORKING/tmp/apprestore.sh" if exist "tools/config/romsettings/autobackup/No" del "tools/config/romsettings/autobackup/No"
)

if exist WORKING/META-INF/com/google/android/aroma (
if exist WORKING/META-INF/com/google/android/aroma-config (
if exist WORKING/META-INF/com/google/android/update-binary (
if exist WORKING/META-INF/com/google/android/update-binary-installer (
set aromaconfig=Yes
)
)
)
)

set knox=Yes
if not exist WORKING/system/app/KNOXAgent.apk (
if not exist WORKING/system/app/KNOXAgent.odex (
if not exist WORKING/system/app/KLMSAgent.apk (
if not exist WORKING/system/app/KNOXAgent.odex (
if not exist WORKING/system/app/KnoxAttestationAgent.apk (
if not exist WORKING/system/app/KnoxAttestationAgent.odex (
if not exist WORKING/system/app/ContainerAgent.apk (
if not exist WORKING/system/app/ContainerAgent.odex (
if not exist WORKING/system/app/ContainerEventsRelayManager.apk (
if not exist WORKING/system/app/ContainerEventsRelayManager.odex (
if not exist WORKING/system/app/KNOXStub.apk (
if not exist WORKING/system/app/KNOXStub.odex (
if not exist WORKING/system/priv-app/KLMSAgent.apk (
if not exist WORKING/system/priv-app/KLMSAgent.odex (
if not exist WORKING/system/etc/secure_storage/com.sec.knox.store (
if not exist WORKING/system/lib/libknoxdrawglfunction.so (
if not exist WORKING/system/containers (
if not exist WORKING/system/preloadedkiosk (
if not exist WORKING/system/preloadedsso (
set knox=No
echo AUTOGENERATED > tools/config/romsettings/knox/KnoxToken
if exist "tools/config/romsettings/knox/No" del "tools/config/romsettings/knox/No"
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)
)

set installationconfig=No
if exist "META-INF/com/google/android/updater-script" set installationconfig=Pre-installed
if exist "tools/config/romsettings/installationfiles/InstallationToken" set installationconfig=Yes

set dataextraction=No
if exist "WORKING/data" (
if exist "WORKING/META-INF/com/google/android/updater-script" cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##DATALINE##" "">nul
set dataextraction=Yes>nul
echo AUTOGENERATED > tools/config/romsettings/dataextraction/ExtractionToken
if exist "tools/config/romsettings/dataextraction/No" del "tools/config/romsettings/dataextraction/No">nul
)

set rootconfig=No
echo AUTOGENERATED > tools/config/romsettings/root/No
if exist "tools/config/romsettings/root/RootToken" del "tools\config\romsettings\root\RootToken"
if exist "WORKING/system/xbin/su" (
if exist "WORKING/system/bin/.ext/.su" (
if exist "WORKING/system/etc/.installed_su_daemon" (
if exist "WORKING/system/etc/init.d/99SuperSUDaemon" (
if exist "WORKING/system/xbin/daemonsu" (
set rootconfig=Yes
echo AUTOGENERATED > tools/config/romsettings/root/RootToken
)
)
)
)
)
if exist "tools/config/romsettings/root/No" del "tools\config\romsettings\root\No"

set busyboxconfig=No
echo AUTOGENERATED > tools/config/romsettings/busybox/No
if exist "tools/config/romsettings/busybox/BusyboxToken" del "tools\config\romsettings\busybox\BusyboxToken"
if exist "WORKING/system/xbin/busybox" set busyboxconfig=Yes
if exist "WORKING/system/xbin/busybox" echo AUTOGENERATED > tools/config/romsettings/busybox/BusyboxToken
if exist "tools/config/romsettings/busybox/BusyboxToken" del "tools\config\romsettings\busybox\BusyboxToken"

set initdconfig=No
if exist "WORKING/system/etc/init.d" set initdconfig=Possibly
if exist "WORKING/system/bin/debuggerd.orig" set initdconfig=Yes

set deodexconfig=No
if exist "tools/config/romsettings/deodexed/DeodexToken" del "tools\config\romsettings\deodexed\DeodexToken"
echo AUTOGENERATED > tools/config/romsettings/deodexed/No
if not exist WORKING/system/app/*.odex set deodexconfig=Apps
if not exist WORKING/system/framework/*.odex set deodexconfig=Framework
if not exist WORKING/system/app/*.odex echo AUTOGENERATED > tools/config/romsettings/deodexed/Apps
if not exist WORKING/system/framework/*.odex echo AUTOGENERATED > tools/config/romsettings/deodexed/Framework
if not exist WORKING/system/app/*.odex echo AUTOGENERATED > tools/config/romsettings/deodexed/Deodex
if not exist WORKING/system/framework/*.odex ren tools\config\romsettings\deodexed\Deodex DeodexToken
if not exist "tools/config/romsettings/deodexed/No" del "tools/config/romsettings/deodexed/No"
if not exist "tools/config/romsettings/deodexed/No" del "tools/config/romsettings/deodexed/No"
if exist tools/config/romsettings/deodexed/DeodexToken set deodexconfig=Yes
if not exist WORKING/system/app/*.apk set deodexconfig=No files
if not exist WORKING/system/framework/*.jar set deodexconfig=No files
if exist "tools/config/romsettings/deodexed/DeodexToken" (
if exist "tools/config/romsettings/deodexed/No" del "tools\config\romsettings\deodexed\No"
if exist "tools/config/romsettings/deodexed/Deodex" del "tools\config\romsettings\deodexed\Deodex"
if exist "tools/config/romsettings/deodexed/Apps" del "tools\config\romsettings\deodexed\Apps"
if exist "tools/config/romsettings/deodexed/Framework" del "tools\config\romsettings\deodexed\Framework"
)

set sysrwrobinary=No
echo AUTOGENERATED > tools/config/romsettings/sysrwro/No
if exist "tools/config/romsettings/sysrwro/SysrwroToken" del "tools\config\romsettings\sysrwro\SysrwroToken"
if exist "WORKING/system/bin/sysrw" set sysrwrobinary=Yes
if exist "WORKING/system/bin/sysrw" echo AUTOGENERATED > tools/config/romsettings/sysrwro/SysrwroToken
if exist "tools/config/romsettings/sysrwro/No" del "tools\config\romsettings\sysrwro\No"

set insecureramdisk=No
if exist "tools/config/romsettings/insecureramdisk/InsecureToken" set insecureramdisk=Yes

set bitcodeverification=Yes
if exist "tools/config/romsettings/bitcodeverification/BitcodeToken" set bitcodeverification=No
if exist "tools/config/romsettings/bitcodeverification/BitcodeToken" echo AUTOGENERATED > tools/config/romsettings/bitcodeverification/BitcodeToken

set bootanimation=Yes
if exist "tools/config/romsettings/bootanimation/AnimationToken" set bootanimation=No
if exist "tools/config/romsettings/bootanimation/AnimationToken" echo AUTOGENERATED > tools/config/romsettings/bootanimation/AnimationToken

set gpurendering=Yes
if exist "tools/config/romsettings/gpurendering/GPUToken" set gpurendering=No
if exist "tools/config/romsettings/gpurendering/GPUToken" echo AUTOGENERATED > tools/config/romsettings/gpurendering/GPUToken

if exist "tools/config/romsettings/wipes/WipedataToken" set wipedata=, data
if exist "tools/config/romsettings/wipes/WipecacheToken" set wipecache=, cache
if exist "tools/config/romsettings/wipes/WipedataToken" if exist "WORKING/META-INF/com/google/android/updater-script" cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##WIPELINE1##" "">nul
if exist "tools/config/romsettings/wipes/WipedataToken" if exist "WORKING/META-INF/com/google/android/updater-script" cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##WIPELINE1##" "">nul
if exist "tools/config/romsettings/wipes/WipecacheToken" if exist "WORKING/META-INF/com/google/android/updater-script" cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##WIPELINE2##" "">nul
if exist "tools/config/romsettings/wipes/WipecacheToken" if exist "WORKING/META-INF/com/google/android/updater-script" cscript "tools/sed.vbs" "WORKING/META-INF/com/google/android/updater-script" "##WIPELINE2##" "">nul

if exist WORKING/META-INF/com/google/android/updater-script "tools/dos2unix" WORKING/META-INF/com/google/android/updater-script>nul
if exist WORKING/META-INF/com/google/android/aroma-config "tools/dos2unix" WORKING/META-INF/com/google/android/aroma-config>nul
