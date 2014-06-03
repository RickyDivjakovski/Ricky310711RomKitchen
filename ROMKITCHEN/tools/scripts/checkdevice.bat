echo.

set /A count=0
FOR %%F IN (tools/config/romsettings/romname/*) DO (
set tmpdata=%%~nF%%~xF
set /A count+=1
)
if %count%==0 goto complete

if not exist WORKING/system/build.prop goto complete
"tools/cecho" {0A} CHECKING DEVICE{#}
findstr "ro.product.model=" "WORKING\system\build.prop" >tmp.txt
cscript "tools/sed.vbs" "tmp.txt" "ro.product.model=" "">nul
set /p device=<tmp.txt
del "tmp.txt"
echo.
"tools/cecho"  {0A}%device% DETECTED{#}

echo ########################## SAMSUNG >> tmp.txt
del tmp.txt

if %device% == GT-I8160 (
set kernel=/dev/block/mmcblk0p15
goto complete
)

if %device% == GT-I8262 (
set kernel=/dev/block/mmcblk0p8
goto complete
)

if %device% == GT-I9000 (
set kernel=/dev/block/bml7
goto complete
)

if %device% == GT-I9001 (
set kernel=/dev/block/mmcblk0p8
goto complete
)

if %device% == GT-I9082 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-I9100G (
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
goto complete
)

if %device% == GT-I9300 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-I9305 (
set kernel=/dev/block/mmcblk0p8
goto complete
)

if %device% == GT-I9500 (
set kernel=/dev/block/mmcblk0p9
goto complete
)

if %device% ==  GT-I9505 (
set kernel=/dev/block/mmcblk0p20
goto complete
)

if %device% == GT-N7100 (
set kernel=/dev/block/mmcblk0p8
goto complete
)

if %device% == GT-N7105 (
set kernel=/dev/block/mmcblk0p8
goto complete
)

if %device% == GT-N8010 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-N8013 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-P3100 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-P3110 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-P3113 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-P5100 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-P5110 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-P5113 (
set kernel=/dev/block/mmcblk0p5
goto complete
)

if %device% == GT-P7500 (
set kernel=/dev/block/platform/sdhci-tegra.3/by-num/p3 
goto complete
)

if %device% == GT-S6310 (
set kernel=/dev/block/mmcblk0p8
goto complete
)

if %device% == SGH-I145 (
set kernel=/dev/block/mmcblk0p21
goto complete
)

if %device% == SCH-I545 (
set kernel=/dev/block/mmcblk0p21
goto complete
)

if %device% == SCH-I605 (
set kernel=/dev/block/mmcblk0p9
goto complete
)

if %device% == SGH-I317 (
set kernel=/dev/block/mmcblk0p8
goto complete
)

if %device% == SGH-1747 (
set kernel=/dev/block/mmcblk0p7
goto complete
)

if %device% == SGH-M919 (
set kernel=/dev/block/mmcblk0p20
goto complete
)

if %device% == SGH-M919 (
echo set kernel=/dev/block/mmcblk0p20
goto complete
)

if %device% == SM-N900 (
echo set kernel=/dev/block/mmcblk0p9
goto complete
)

if %device% == SM-G900F (
echo set kernel=/dev/block/mmcblk0p15
goto complete
)

if %device% == SM-N900T (
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
goto complete
)

if %device% == SM-N9005 (
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
goto complete
)

if %device% == SM-T320 (
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
goto complete
)

echo ########################## HUAWEI >> tmp.txt
del tmp.txt


if %device% == G526-L22 (
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
goto complete
)

if %device% == P6-U06 (
set kernel=/dev/block/platform/hi_mci.1/by-name/boot
goto complete
)

echo ########################## LG >> tmp.txt
del tmp.txt


if %device% == LG-D802 (
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
goto complete
)

if %device% == LG-MS870 (
set kernel=/dev/block/mmcblk0p7
goto complete
)

if %device% == LG-P760 (
set kernel=/dev/block/platform/omap/omap_hsmmc.1
goto complete
)

if %device% == LG-P990 (
set kernel=/dev/block/mmcblk0p6
goto complete
)

echo ########################## MOTOROLA >> tmp.txt
del tmp.txt


if %device% == "DROID RAZR" (
set kernel=/dev/block/mmcblk1p9
goto complete
)

if %device% == XT1032 (
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
goto complete
)

echo ########################## HTC >> tmp.txt
del tmp.txt


if %device% == 831C (
set kernel=/dev/block/mmcblk0p42
goto complete
)

echo ########################## SONY >> tmp.txt
del tmp.txt


if %device% == D6503 (
set kernel=/dev/block/mmcblk0p14
goto complete
)

if %device% == LT25i (
set kernel=/dev/block/mmcblk0p4
goto complete
)

if %device% == LT29i (
set kernel=/dev/block/mmcblk0p4
goto complete
)

if %device% == LT30i (
set kernel=/dev/block/mmcblk0p4
goto complete
)

if %device% == ST25i (
set kernel=/dev/block/mmcblk0p9
goto complete
)

if %device% == ST25a (
set kernel=/dev/block/mmcblk0p9
goto complete
)

if %device% == MT27i (
set kernel=/dev/block/mmcblk0p9
goto complete
)

if %device% == MT27a (
set kernel=/dev/block/mmcblk0p9
goto complete
)

echo ########################## MEDIATEK >> tmp.txt
del tmp.txt


if %device% == GSmart Aku A1 (
set kernel=/dev/block/mmcblk0
goto complete
)

echo ########################## UNSUPPORTED >> tmp.txt
del tmp.txt


set device=unsupported
set kernel=##KERNELBLOCKPATH##


del tmp.txt
:complete