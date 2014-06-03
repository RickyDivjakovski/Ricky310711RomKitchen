if exist tools/config/toolsettings.cfg (
findstr "compression:" "tools\config\toolsettings.cfg" >tmp.txt
cscript "tools/sed.vbs" "tmp.txt" "compression:" "">nul
set /p compression=<tmp.txt
del "tmp.txt"
)

if exist tools/config/toolsettings.cfg (
findstr "heapsize:" "tools\config\toolsettings.cfg" >tmp.txt
cscript "tools/sed.vbs" "tmp.txt" "heapsize:" "">nul
set /p heapsize=<tmp.txt
del "tmp.txt"
)

if exist tools/config/toolsettings.cfg (
findstr "rootmode:" "tools\config\toolsettings.cfg" >tmp.txt
cscript "tools/sed.vbs" "tmp.txt" "rootmode:" "">nul
set /p rootmode=<tmp.txt
del "tmp.txt"
)

if exist tools/config/toolsettings.cfg (
findstr "syntax:" "tools\config\toolsettings.cfg" >tmp.txt
cscript "tools/sed.vbs" "tmp.txt" "syntax:" "">nul
set /p syntax=<tmp.txt
del "tmp.txt"
)

if exist tools/config/toolsettings.cfg (
findstr "imageformat:" "tools\config\toolsettings.cfg" >tmp.txt
cscript "tools/sed.vbs" "tmp.txt" "imageformat:" "">nul
set /p imageformat=<tmp.txt
del "tmp.txt"
)

