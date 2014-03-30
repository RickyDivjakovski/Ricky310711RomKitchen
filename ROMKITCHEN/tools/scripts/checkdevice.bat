"tools/cecho" {0A} CHECKING DEVICE{#}

set device=unsupported
set kernel=##KERNELBLOCKPATH##


echo ########################## SAMSUNG >> tmp.txt
del tmp.txt

"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I8262" "ro.product.model=GT-I8262tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I8262tmp" "ro.product.model=GT-I8262" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I8262
set kernel=/dev/block/mmcblk0p8
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9000" "ro.product.model=GT-I9000tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9000tmp" "ro.product.model=GT-I9000" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9000
set kernel=/dev/block/bml7
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9001" "ro.product.model=GT-I9001tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9001tmp" "ro.product.model=GT-I9001" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9001
set kernel=/dev/block/mmcblk0p8
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9082" "ro.product.model=GT-I9082tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9082tmp" "ro.product.model=GT-I9082" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9082
set kernel=/dev/block/mmcblk0p5
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9100G" "ro.product.model=GT-I9100Gtmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9100Gtmp" "ro.product.model=GT-I9100G" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9100G
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
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
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9500" "ro.product.model=GT-I9500tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9500tmp" "ro.product.model=GT-I9500" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9500
set kernel=/dev/block/mmcblk0p9
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9505" "ro.product.model=GT-I9505tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-I9505tmp" "ro.product.model=GT-I9505" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-I9505
set kernel=/dev/block/mmcblk0p20
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-N7100" "ro.product.model=GT-N7100tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-N7100tmp" "ro.product.model=GT-N7100" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-N7100
set kernel=/dev/block/mmcblk0p8
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-N7105" "ro.product.model=GT-N7105tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-N7105tmp" "ro.product.model=GT-N7105" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-N7105
set kernel=/dev/block/mmcblk0p8
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3100" "ro.product.model=GT-P3100tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3100tmp" "ro.product.model=GT-P3100" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P3100
set kernel=/dev/block/mmcblk0p5
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3110" "ro.product.model=GT-P3110tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3110tmp" "ro.product.model=GT-P3110" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P3110
set kernel=/dev/block/mmcblk0p5
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3113" "ro.product.model=GT-P3113tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P3113tmp" "ro.product.model=GT-P3113" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P3113
set kernel=/dev/block/mmcblk0p5
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P5100" "ro.product.model=GT-P5100tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P5100tmp" "ro.product.model=GT-P5100" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P5100
set kernel=/dev/block/mmcblk0p5
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P5110" "ro.product.model=GT-P5110tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P5110tmp" "ro.product.model=GT-P5110" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P5110
set kernel=/dev/block/mmcblk0p5
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P5113" "ro.product.model=GT-P5113tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P5113tmp" "ro.product.model=GT-P5113" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P5113
set kernel=/dev/block/mmcblk0p5
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P7500" "ro.product.model=GT-P7500tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-P7500tmp" "ro.product.model=GT-P7500" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-P7500
set kernel=/dev/block/platform/sdhci-tegra.3/by-num/p3 
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-S6310" "ro.product.model=GT-S6310tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=GT-S6310tmp" "ro.product.model=GT-S6310" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=GT-S6310
set kernel=/dev/block/mmcblk0p8
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SGH-I317" "ro.product.model=SGH-I317tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SGH-I317tmp" "ro.product.model=SGH-I317" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SGH-I317
set kernel=/dev/block/mmcblk0p8
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SGH-M919" "ro.product.model=SGH-M919tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SGH-M919tmp" "ro.product.model=SGH-M919" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SGH-M919
set kernel=/dev/block/mmcblk0p20
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SGH-M919" "ro.product.model=SGH-M919tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SGH-M919tmp" "ro.product.model=SGH-M919" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SGH-M919
echo set kernel=/dev/block/mmcblk0p20
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-G900F" "ro.product.model=SM-G900Ftmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-G900Ftmp" "ro.product.model=SM-G900F" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SM-G900F
echo set kernel=/dev/block/mmcblk0p15
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-N900T" "ro.product.model=SM-N900Ttmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-N900Ttmp" "ro.product.model=SM-N900T" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SM-N900T
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-N9005" "ro.product.model=SM-N9005tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-N9005tmp" "ro.product.model=SM-N9005" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SM-N9005
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-T320" "ro.product.model=SM-T320tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=SM-T320tmp" "ro.product.model=SM-T320" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=SM-T320
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
)


echo ########################## LG >> tmp.txt
del tmp.txt

"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-D802" "ro.product.model=LG-D802tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-D802tmp" "ro.product.model=LG-D802" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=LG-D802
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-MS870" "ro.product.model=LG-MS870tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-MS870tmp" "ro.product.model=LG-MS870" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=LG-MS870
set kernel=/dev/block/mmcblk0p7
set tmp=
)
"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-P760" "ro.product.model=LG-P760tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=LG-P760tmp" "ro.product.model=LG-P760" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=LG-P760
set kernel=/dev/block/platform/omap/omap_hsmmc.1
set tmp=
)


echo ########################## MOTOROLA >> tmp.txt
del tmp.txt

"tools/fart" "WORKING\system\build.prop" "ro.product.model=XT1032" "ro.product.model=XT1032tmp" >tmp.txt
"tools/fart" "WORKING\system\build.prop" "ro.product.model=XT1032tmp" "ro.product.model=XT1032" >tmp.txt
set /p tmp= < tmp.txt
del tmp.txt
if "%tmp%" == "WORKING\system\build.prop" (
set device=XT1032
set kernel=/dev/block/platform/msm_sdcc.1/by-name/boot
set tmp=
)