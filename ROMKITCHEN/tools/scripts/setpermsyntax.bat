echo copying update-binary..
xcopy "tools\files\binary" "WORKING" /e /i /h>nul

echo building updater-script..

echo adding introduction lines..
echo ui_print("******************************************");  >> WORKING/META-INF/com/google/android/updater-script
echo ui_print("            Installing %romname%");  >> WORKING/META-INF/com/google/android/updater-script
echo ui_print("******************************************");  >> WORKING/META-INF/com/google/android/updater-script
echo ui_print("    BROUGHT TO YOU BY RICKYS KITCHEN"); >> WORKING/META-INF/com/google/android/updater-script
echo ui_print("             BY RICKY310711"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo adding mount syntax..
echo unmount("/system"); >> WORKING/META-INF/com/google/android/updater-script
echo ui_print("Mounting System"); >> WORKING/META-INF/com/google/android/updater-script
echo run_program("/sbin/mount", "-t", "auto", "/system"); >> WORKING/META-INF/com/google/android/updater-script
echo ui_print("Mounting Data"); >> WORKING/META-INF/com/google/android/updater-script
echo run_program("/sbin/mount", "-t", "auto", "/data"); >> WORKING/META-INF/com/google/android/updater-script
echo ui_print("Mounting Cache"); >> WORKING/META-INF/com/google/android/updater-script
echo run_program("/sbin/mount", "-t", "auto", "/cache"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo adding placeholder lines..
if %autobackup% == No echo ##BACKUPAPPSLINE##ui_print("Backing up apps"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##package_extract_file("tmp/appbackup.sh", "/tmp/appbackup.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##set_perm(0, 0, 0777, "/tmp/appbackup.sh"); >> WORKING/META-INF/com/google/android/updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##run_program("/tmp/appbackup.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo ui_print("Backing up apps"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo package_extract_file("tmp/appbackup.sh", "/tmp/appbackup.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo set_perm(0, 0, 0777, "/tmp/appbackup.sh"); >> WORKING/META-INF/com/google/android/updater-script
if %autobackup% == Yes echo run_program("/tmp/appbackup.sh"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo adding wipe syntax..
echo ui_print("Wiping System"); >> WORKING/META-INF/com/google/android/updater-script
echo delete_recursive("/system"); >> WORKING/META-INF/com/google/android/updater-script
echo ##WIPELINE1##ui_print("Wiping Data"); >> WORKING/META-INF/com/google/android/updater-script
if %devicetype% == normal echo ##WIPELINE1##delete_recursive("/data"); >> WORKING/META-INF/com/google/android/updater-script
if %devicetype% == samsung echo ##WIPELINE1##package_extract_file("tmp/safewipe.sh", "/tmp/safewipe.sh"); >> WORKING/META-INF/com/google/android/updater-script
if %devicetype% == samsung echo ##WIPELINE1##package_extract_file("tmp/bash", "/tmp/bash"); >> WORKING/META-INF/com/google/android/updater-script
if %devicetype% == samsung echo ##WIPELINE1##set_perm(0, 0, 0777, "/tmp/safewipe.sh"); >> WORKING/META-INF/com/google/android/updater-script
if %devicetype% == samsung echo ##WIPELINE1##set_perm(0, 0, 0777, "/tmp/bash"); >> WORKING/META-INF/com/google/android/updater-script
if %devicetype% == samsung echo ##WIPELINE1##run_program("/tmp/safewipe.sh"); >> WORKING/META-INF/com/google/android/updater-script
echo ##WIPELINE2##ui_print("Wiping Cache"); >> WORKING/META-INF/com/google/android/updater-script
echo ##WIPELINE2##delete_recursive("/cache"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo inserting extraction lines..
echo ui_print("Extracting System"); >> WORKING/META-INF/com/google/android/updater-script
echo package_extract_dir("system", "/system"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/data echo ##DATALINE##ui_print("Extracting Data"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/data echo ##DATALINE##package_extract_dir("data", "/data"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo detecting symlinks..
echo ui_print("Symlinking"); >> WORKING/META-INF/com/google/android/updater-script
echo symlink("dumpstate", "/system/bin/dumpcrash"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("libGLESv2.so", "/system/lib/libGLESv3.so"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("logcat", "/system/bin/lolcat"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("mksh", "/system/bin/sh"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("Roboto-Bold.ttf", "/system/fonts/DroidSans-Bold.ttf"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("Roboto-Regular.ttf", "/system/fonts/DroidSans.ttf"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/cat"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/chcon"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/chmod"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/chown"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/clear"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/cmp"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/cp"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/date"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/dd"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/df"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/dmesg"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/du"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/getenforce"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/getevent"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/getprop"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/getsebool"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/grep"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/hd"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/id"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/ifconfig"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/iftop"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/insmod"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/ioctl"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/ionice"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/kill"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/ln"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/load_policy"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/log"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/ls"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/lsmod"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/lsof"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/md5"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/mkdir"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/mount"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/mv"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/nandread"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/netstat"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/newfs_msdos"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/notify"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/playback"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/printenv"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/ps"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/reboot"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/renice"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/restorecon"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/rm"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/rmdir"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/rmmod"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/route"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/runcon"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/schedtop"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/sendevent"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/setconsole"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/setenforce"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/setprop"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/setsebool"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/sleep"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/smd"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/start"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/stop"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/sync"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/top"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/touch"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/touchinput"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/umount"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/uptime"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/vmstat"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/watchprops"); >> WORKING\META-INF\com\google\android\updater-script
echo symlink("toolbox", "/system/bin/wipe"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo setting permissions..
echo ui_print("Setting Permissions"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system echo set_perm_recursive(0, 0, 0755, 0644, "/system"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin echo set_perm_recursive(0, 0, 0755, 0644, "/system/bin"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/init.d echo set_perm_recursive(0, 2000, 0755, 0755, "/system/etc/init.d"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/init.d echo set_perm(0, 0, 0, 0755, "/system/etc/init.d"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/dhcpcd echo set_perm_recursive(0, 0, 0755, 0644, "/system/etc/init.d"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/ppp echo set_perm_recursive(0, 0, 0755, 0555, "/system/etc/init.d"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/lib echo set_perm_recursive(0, 0, 0755, 0644, "/system/lib"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor echo set_perm_recursive(0, 2000, 0755, 0644, "/system/vendor"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin echo set_perm_recursive(0, 2000, 0755, 0755, "/system/xbin"); >> WORKING/META-INF/com/google/android/updater-script

if exist WORKING/system/bin/ATFWD-daemon echo set_perm(0, 2000, 0755, "/system/bin/ATFWD-daemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/adsprpcd echo set_perm(0, 2000, 0755, "/system/bin/at_adsprpcd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/androidshmservice echo set_perm(0, 2000, 0755, "/system/bin/androidshmservice"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/apaservice echo set_perm(0, 2000, 0755, "/system/bin/apaservice"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/app_process echo set_perm(0, 2000, 0755, "/system/bin/app_process"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/at_distributor echo set_perm(0, 2000, 0755, "/system/bin/at_distributor"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/auditd echo set_perm(0, 2000, 0755, "/system/bin/auditd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/bintvoutservice echo set_perm(0, 2000, 0755, "/system/bin/bintvoutservice"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/bootchecker echo set_perm(0, 2000, 0755, "/system/bin/bootchecker"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/bootanimation echo set_perm(0, 2000, 0755, "/system/bin/bootanimation"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/bugreport echo set_perm(0, 2000, 0755, "/system/bin/bugreport"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/charger_monitor echo set_perm(0, 2000, 0755, "/system/bin/charger_monitor"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/charon echo set_perm(0, 2000, 0755, "/system/bin/charon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/clatd echo set_perm(0, 2000, 0755, "/system/bin/clatd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/cnd echo set_perm(0, 2000, 0755, "/system/bin/cnd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/connfwexe echo set_perm(0, 2000, 0755, "/system/bin/connfwexe"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/createsystemfile echo set_perm(0, 2000, 0755, "/system/bin/createsystemfile"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/cs echo set_perm(0, 2000, 0755, "/system/bin/cs"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/debuggerd echo set_perm(0, 2000, 0755, "/system/bin/debuggerd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/dhcp echo set_perm(0, 2000, 0755, "/system/bin/dhcp"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/diag_uart_log echo set_perm(0, 2000, 0755, "/system/bin/diag_uart_log"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/dnsmasq echo set_perm(0, 2000, 0755, "/system/bin/dnsmasq"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/drmserver echo set_perm(0, 2000, 0755, "/system/bin/drmserver"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/drsd echo set_perm(0, 2000, 0755, "/system/bin/drsd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/dumpstate echo set_perm(0, 2000, 0755, "/system/bin/dumpstate"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/dumpsys echo set_perm(0, 2000, 0755, "/system/bin/dumpsys"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/efsks echo set_perm(0, 2000, 0755, "/system/bin/efsks"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/gsiff_daemon echo set_perm(0, 2000, 0755, "/system/bin/gsiff_daemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/hostapd echo set_perm(0, 2000, 0755, "/system/bin/hostapd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/icd echo set_perm(0, 2000, 0755, "/system/bin/icd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/immvibed echo set_perm(0, 2000, 0755, "/system/bin/immvibed"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/imsqmidaemon echo set_perm(0, 2000, 0755, "/system/bin/imsqmidaemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/installd echo set_perm(0, 2000, 0755, "/system/bin/installd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/insthk echo set_perm(0, 2000, 0755, "/system/bin/insthk"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/ipruleset echo set_perm(0, 2000, 0755, "/system/bin/ipruleset"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/jackservice echo set_perm(0, 2000, 0755, "/system/bin/jackservice"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/keystore echo set_perm(0, 2000, 0755, "/system/bin/keystore"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/ks echo set_perm(0, 2000, 0755, "/system/bin/ks"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/logwrapper echo set_perm(0, 2000, 0755, "/system/bin/logwrapper"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/mcDriverDaemon echo set_perm(0, 2000, 0755, "/system/bin/mcDriverDaemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/mdnsd echo set_perm(0, 2000, 0755, "/system/bin/mdnsd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/mediaserver echo set_perm(0, 2000, 0755, "/system/bin/mediaserver"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/mksh echo set_perm(0, 2000, 0755, "/system/bin/mksh"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/mm-pp-daemon echo set_perm(0, 2000, 0755, "/system/bin/mm-pp-daemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/mm-qcamera-daemon echo set_perm(0, 2000, 0755, "/system/bin/mm-qcamera-daemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/mpdecision echo set_perm(0, 2000, 0755, "/system/bin/mpdecision"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/mtpd echo set_perm(0, 2000, 0755, "/system/bin/mtpd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/netcfg echo set_perm(0, 3003, 02750, "/system/bin/netcfg"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/netd echo set_perm(0, 2000, 0755, "/system/bin/netd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/npsmobex echo set_perm(0, 2000, 0755, "/system/bin/npsmobex"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/ping echo set_perm(0, 3004, 02755, "/system/bin/ping"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/pppd echo set_perm(0, 2000, 0755, "/system/bin/pppd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/prepare_param.sh echo set_perm(0, 2000, 0755, "/system/bin/prepare_param.sh"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/qcks echo set_perm(0, 2000, 0755, "/system/bin/qcks"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/qmuxd echo set_perm(0, 2000, 0755, "/system/bin/qmuxd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/qosmgr echo set_perm(0, 2000, 0755, "/system/bin/qosmgr"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/qrngd echo set_perm(0, 2000, 0755, "/system/bin/qrngd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/qseecomd echo set_perm(0, 2000, 0755, "/system/bin/qseecomd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/racoon echo set_perm(0, 2000, 0755, "/system/bin/racoon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/rfs_access echo set_perm(0, 2000, 0755, "/system/bin/rfs_access"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/rild echo set_perm(0, 2000, 0755, "/system/bin/rild"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/rmt_storage echo set_perm(0, 2000, 0755, "/system/bin/rmt_storage"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/run-as echo set_perm(0, 2000, 06750, "/system/bin/run-as"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/samsungpowersoundplay echo set_perm(0, 2000, 0755, "/system/bin/samsungpowersoundplay"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/scranton_RD echo set_perm(0, 2000, 0755, "/system/bin/scranton_RD"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/sdcard echo set_perm(0, 2000, 0755, "/system/bin/sdcard"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/secure_storage_daemon echo set_perm(0, 2000, 0755, "/system/bin/secure_storage_daemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/sensorhubservice echo set_perm(0, 2000, 0755, "/system/bin/sensorhubservice"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/servicemanager echo set_perm(0, 2000, 0755, "/system/bin/servicemanager"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/smdexe echo set_perm(0, 2000, 0755, "/system/bin/smdexe"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/ss_conn_daemon echo set_perm(0, 2000, 0755, "/system/bin/ss_conn_daemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/ssr_diag echo set_perm(0, 2000, 0755, "/system/bin/ssr_diag"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/surfaceflinger echo set_perm(0, 2000, 0755, "/system/bin/surfaceflinger"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/thermal-engine echo set_perm(0, 2000, 0755, "/system/bin/thermal-engine"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/thermald echo set_perm(0, 2000, 0755, "/system/bin/thermald"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/tima_dump_log echo set_perm(0, 2000, 0755, "/system/bin/tima_dump_log"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/time_daemon echo set_perm(0, 2000, 0755, "/system/bin/time_daemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/vold echo set_perm(0, 2000, 0755, "/system/bin/vold"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/wpa_supplicant echo set_perm(0, 2000, 0755, "/system/bin/wpa_supplicant"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/dhcpcd/dhcpcd-run-hooks echo set_perm(1014, 2000, 0550, "/system/etc/dhcpcd/dhcpcd-run-hooks"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor echo set_perm(0, 2000, 0755, "/system/vendor/firmware"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/etc echo set_perm(0, 2000, 0755, "/system/vendor/etc"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/etc/nxp echo set_perm(0, 2000, 0755, "/system/vendor/etc/nxp"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/etc/nxp/BargeIn echo set_perm(0, 2000, 0755, "/system/vendor/etc/nxp/BargeIn"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/etc/nxp/mVoIP echo set_perm(0, 2000, 0755, "/system/vendor/etc/nxp/mVoIP"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/etc/nxp/mVoIPFMC echo set_perm(0, 2000, 0755, "/system/vendor/etc/nxp/mVoIPFMC"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/etc/nxp/mVoIPSec echo set_perm(0, 2000, 0755, "/system/vendor/etc/nxp/mVoIPSec"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/firmware echo set_perm(0, 2000, 0755, "/system/vendor/firmware"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/lib echo set_perm(0, 2000, 0755, "/system/vendor/lib"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/lib/drm echo set_perm(0, 2000, 0755, "/system/vendor/lib/drm"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/lib/egl echo set_perm(0, 2000, 0755, "/system/vendor/lib/egl"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/lib/hw echo set_perm(0, 2000, 0755, "/system/vendor/lib/hw"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/lib/mediadrm echo set_perm(0, 2000, 0755, "/system/vendor/lib/mediadrm"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/lib/rfsa echo set_perm(0, 2000, 0755, "/system/vendor/lib/rfsa"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/lib/rfsa/adsp echo set_perm(0, 2000, 0755, "/system/vendor/lib/rfsa/adsp"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/media echo set_perm(0, 2000, 0755, "/system/vendor/media"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/pittpatt echo set_perm(0, 2000, 0755, "/system/vendor/pittpatt"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/pittpatt/models echo set_perm(0, 2000, 0755, "/system/vendor/pittpatt/models"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/pittpatt/models/detection echo set_perm(0, 2000, 0755, "/system/vendor/pittpatt/models/detection"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7 echo set_perm(0, 2000, 0755, "/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.6 echo set_perm(0, 2000, 0755, "/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.6"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/vendor/pittpatt/models/recognition echo set_perm(0, 2000, 0755, "/system/vendor/pittpatt/models/recognition"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/debuggerd echo set_perm(0, 2000, 06755, "/system/xbin/debuggerd"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/librank echo set_perm(0, 0, 06755, "/system/xbin/librank"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/procmem echo set_perm(0, 0, 06755, "/system/xbin/procmem"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/procrank echo set_perm(0, 0, 06755, "/system/vendor/lib/hw"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo detecting root..
if exist WORKING/system/xbin/su echo root detected
if exist WORKING/system/xbin/su echo ui_print("Initializing Root"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin/su echo set_perm(0, 0, 06755, "/system/xbin/su"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin/daemonsu echo set_perm(0, 0, 06755, "/system/xbin/daemonsu"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin/supolicy echo set_perm(0, 0, 06755, "/system/xbin/supolicy"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/.ext echo set_perm(0, 0, 0777, "/system/bin/.ext"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/.ext/.su echo set_perm(0, 0, 06755, "/system/system/bin/.ext/.su"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/install-recovery.sh echo set_perm(0, 0, 0755, "/system/etc/install-recovery.sh"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/init.d/99SuperSUDaemon echo set_perm(0, 0, 0755, "/system/etc/init.d/99SuperSUDaemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/.installed_su_daemon echo set_perm(0, 0, 0644, "/system/etc/.installed_su_daemon"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/app/Superuser.apk echo set_perm(0, 0, 0644, "/system/app/Superuser.apk"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin/su echo run_program("/system/xbin/su", "--install"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/su echo root not detected
if not exist WORKING/system/xbin/su echo ##ROOTLINE##set_perm(0, 0, 06755, "/system/xbin/su"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/supolicy echo ##ROOTLINE##set_perm(0, 0, 06755, "/system/xbin/supolicy"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/daemonsu echo ##ROOTLINE##set_perm(0, 0, 06755, "/system/xbin/daemonsu"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/bin/.ext echo ##ROOTLINE##set_perm(0, 0, 0777, "/system/bin/.ext"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/bin/.ext/.su echo ##ROOTLINE##set_perm(0, 0, 06755, "/system/system/bin/.ext/.su"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/etc/install-recovery.sh echo ##ROOTLINE##set_perm(0, 0, 0755, "/system/etc/install-recovery.sh"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/etc/init.d/99SuperSUDaemon echo ##ROOTLINE##set_perm(0, 0, 0755, "/system/etc/init.d/99SuperSUDaemon"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/etc/.installed_su_daemon echo ##ROOTLINE##set_perm(0, 0, 0644, "/system/etc/.installed_su_daemon"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/app/Superuser.apk echo ##ROOTLINE##set_perm(0, 0, 0644, "/system/app/Superuser.apk"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/su echo ##ROOTLINE##run_program("/system/xbin/su", "--install"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo detecting busybox..
if exist WORKING/system/xbin/busybox echo busybox detected
if exist WORKING/system/xbin/busybox echo ui_print("Installing Busybox"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin/busybox echo symlink("/system/xbin/busybox", "/system/bin/busybox"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin/busybox echo run_program("/system/xbin/busybox", "--install", "-s", "/system/xbin"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/busybox echo busybox not detected
if not exist WORKING/system/xbin/busybox echo ##BUSYBOXLINE##ui_print("Installing Busybox"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/busybox echo ##BUSYBOXLINE##symlink("/system/xbin/busybox", "/system/bin/busybox"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/busybox echo ##BUSYBOXLINE##run_program("/system/xbin/busybox", "--install", "-s", "/system/xbin"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo adding more placeholder lines..
if %autobackup% == No echo ##BACKUPAPPSLINE##ui_print("Restoring Apps"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##package_extract_file("tmp/apprestore.sh", "/tmp/apprestore.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##set_perm(0, 0, 0777, "/tmp/apprestore.sh"); >> WORKING/META-INF/com/google/android/updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##run_program("/tmp/apprestore.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo ui_print("Restoring Apps"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo package_extract_file("tmp/apprestore.sh", "/tmp/apprestore.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo set_perm(0, 0, 0777, "/tmp/apprestore.sh"); >> WORKING/META-INF/com/google/android/updater-script
if %autobackup% == Yes echo run_program("/tmp/apprestore.sh"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo adding kernel lines..
if %device% == unsupported echo ##ui_print("Unpacking Kernel"); >> WORKING/META-INF/com/google/android/updater-script
if %device% == unsupported echo ##package_extract_file("boot.img", "%kernel%"); >> WORKING/META-INF/com/google/android/updater-script
if not %device% == unsupported echo ui_print("Unpacking Kernel"); >> WORKING/META-INF/com/google/android/updater-script
if not %device% == unsupported echo package_extract_file("boot.img", "%kernel%"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo adding completion lines..
echo ui_print("******************************************"); >> WORKING/META-INF/com/google/android/updater-script
echo ui_print("        Successfully Installed"); >> WORKING/META-INF/com/google/android/updater-script
echo ui_print("******************************************"); >> WORKING/META-INF/com/google/android/updater-script
echo set_progress(1.0); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script
