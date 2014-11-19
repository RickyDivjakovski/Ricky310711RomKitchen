echo copying update-binary..
xcopy "tools\files\binary" "WORKING" /e /i /h>nul

echo building updater-script..

echo adding introduction lines..
echo ui_print("******************************************");  >> WORKING\META-INF\com\google\android\updater-script
echo ui_print("            Installing %romname%");  >> WORKING\META-INF\com\google\android\updater-script
echo ui_print("******************************************");  >> WORKING\META-INF\com\google\android\updater-script
echo ui_print("    BROUGHT TO YOU BY RICKYS KITCHEN"); >> WORKING\META-INF\com\google\android\updater-script
echo ui_print("             BY RICKY310711"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING\META-INF\com\google\android\updater-script

echo adding mount syntax..
echo unmount("/system"); >> WORKING\META-INF\com\google\android\updater-script
echo ui_print("Mounting System"); >> WORKING\META-INF\com\google\android\updater-script
echo run_program("/sbin/mount", "-t", "auto", "/system"); >> WORKING\META-INF\com\google\android\updater-script
echo ui_print("Mounting Data"); >> WORKING\META-INF\com\google\android\updater-script
echo run_program("/sbin/mount", "-t", "auto", "/data"); >> WORKING\META-INF\com\google\android\updater-script
echo ui_print("Mounting Cache"); >> WORKING\META-INF\com\google\android\updater-script
echo run_program("/sbin/mount", "-t", "auto", "/cache"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING\META-INF\com\google\android\updater-script

echo adding placeholder lines..
if %autobackup% == No echo ##BACKUPAPPSLINE##ui_print("Backing up apps"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##package_extract_file("tmp/appbackup.sh", "/tmp/appbackup.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##set_metadata("/tmp/appbackup.sh", "uid", 0, "gid", 0, "mode", 0777, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##run_program("/tmp/appbackup.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo ui_print("Backing up apps"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo package_extract_file("tmp/appbackup.sh", "/tmp/appbackup.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo set_metadata("/tmp/appbackup.sh", "uid", 0, "gid", 0, "mode", 0777, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo run_program("/tmp/appbackup.sh"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING\META-INF\com\google\android\updater-script

echo adding wipe syntax..
echo ui_print("Wiping System"); >> WORKING\META-INF\com\google\android\updater-script
echo delete_recursive("/system"); >> WORKING\META-INF\com\google\android\updater-script
echo ##WIPELINE1##ui_print("Wiping Data"); >> WORKING\META-INF\com\google\android\updater-script
if %devicetype% == normal echo ##WIPELINE1##delete_recursive("/data"); >> WORKING\META-INF\com\google\android\updater-script
if %devicetype% == samsung echo ##WIPELINE1##package_extract_file("tmp/safewipe.sh", "/tmp/safewipe.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %devicetype% == samsung echo ##WIPELINE1##package_extract_file("tmp/bash", "/tmp/bash"); >> WORKING\META-INF\com\google\android\updater-script
if %devicetype% == samsung echo ##WIPELINE1##set_metadata("/tmp/safewipe.sh", "uid", 0, "gid", 0, "mode", 0777, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if %devicetype% == samsung echo ##WIPELINE1##set_metadata("/tmp/bash", "uid", 0, "gid", 0, "mode", 0777, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if %devicetype% == samsung echo ##WIPELINE1##run_program("/tmp/safewipe.sh"); >> WORKING\META-INF\com\google\android\updater-script
echo ##WIPELINE2##ui_print("Wiping Cache"); >> WORKING\META-INF\com\google\android\updater-script
echo ##WIPELINE2##delete_recursive("/cache"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING\META-INF\com\google\android\updater-script

echo inserting extraction lines..
echo ui_print("Extracting System"); >> WORKING\META-INF\com\google\android\updater-script
echo package_extract_dir("system", "/system"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/data echo ##DATALINE##ui_print("Extracting Data"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/data echo ##DATALINE##package_extract_dir("data", "/data"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING\META-INF\com\google\android\updater-script

echo detecting symlinks..
echo ui_print("Symlinking"); >> WORKING\META-INF\com\google\android\updater-script
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
echo. >> WORKING\META-INF\com\google\android\updater-script

echo setting meta-data..
echo ui_print("Setting Metadata"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system echo set_metadata_recursive("/system", "uid", 0, "gid", 0, "dmode", 0755, "fmode", 0644, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin echo set_metadata_recursive("/system/bin", "uid", 0, "gid", 2000, "dmode", 0755, "fmode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/etc/init.d echo set_metadata_recursive("/system/etc/init.d", "uid", 0, "gid", 2000, "dmode", 0755, "fmode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0");
if exist WORKING/system/etc/init.d echo set_metadata("/system/etc/init.d", "uid", 0, "gid", 0, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0");
if exist WORKING/system/etc/dhcpcd echo set_metadata_recursive("/system/etc/dhcpcd", "uid", 0, "gid", 0, "dmode", 0755, "fmode", 0644, "capabilities", 0x0, "selabel", "u:object_r:dhcp_system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/etc/ppp echo set_metadata_recursive("/system/etc/ppp", "uid", 0, "gid", 0, "dmode", 0755, "fmode", 0555, "capabilities", 0x0, "selabel", "u:object_r:ppp_system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/lib echo set_metadata_recursive("/system/lib", "uid", 0, "gid", 0, "dmode", 0755, "fmode", 0644, "capabilities", 0x0, "selabel", "u:object_r:system_library_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor echo set_metadata_recursive("/system/vendor", "uid", 0, "gid", 2000, "dmode", 0755, "fmode", 0644, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/xbin echo set_metadata_recursive("/system/xbin", "uid", 0, "gid", 2000, "dmode", 0755, "fmode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script

if exist WORKING/system/bin/ATFWD-daemon echo set_metadata("/system/bin/ATFWD-daemon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:ATFWD-daemon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/adsprpcd echo set_metadata("/system/bin/adsprpcd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:adsprpcd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/androidshmservice echo set_metadata("/system/bin/androidshmservice", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:androidshmservice_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/apaservice echo set_metadata("/system/bin/apaservice", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:apaservice_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/app_process echo set_metadata("/system/bin/app_process", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:zygote_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/at_distributor echo set_metadata("/system/bin/at_distributor", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:at_distributor_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/auditd echo set_metadata("/system/bin/auditd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:auditd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/bintvoutservice echo set_metadata("/system/bin/bintvoutservice", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:bintvoutservice_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/bootanimation echo set_metadata("/system/bin/bootanimation", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:bootanimation_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/bootchecker echo set_metadata("/system/bin/bootchecker", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:bootchecker_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/bugreport echo set_metadata("/system/bin/bugreport", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:bugreport_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/charger_monitor echo set_metadata("/system/bin/charger_monitor", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:charger_monitor_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/charon echo set_metadata("/system/bin/charon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:charon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/clatd echo set_metadata("/system/bin/clatd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:clatd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/cnd echo set_metadata("/system/bin/cnd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:cnd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/connfwexe echo set_metadata("/system/bin/connfwexe", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:connfwexe_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/createsystemfile echo set_metadata("/system/bin/createsystemfile", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:createsystemfile_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/cs echo set_metadata("/system/bin/cs", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:cs_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/debuggerd echo set_metadata("/system/bin/debuggerd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:debuggerd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/dhcpcd echo set_metadata("/system/bin/dhcpcd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:dhcp_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/diag_uart_log echo set_metadata("/system/bin/diag_uart_log", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:diag_uart_log_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/dnsmasq echo set_metadata("/system/bin/dnsmasq", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:dnsmasq_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/drmserver echo set_metadata("/system/bin/drmserver", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:drmserver_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/drsd echo set_metadata("/system/bin/drsd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:drsd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/dumpstate echo set_metadata("/system/bin/dumpstate", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:dumpstate_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/dumpsys echo set_metadata("/system/bin/dumpsys", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:dumpsys_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/efsks echo set_metadata("/system/bin/efsks", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:efsks_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/gsiff_daemon echo set_metadata("/system/bin/gsiff_daemon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:gsiff_daemon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/hostapd echo set_metadata("/system/bin/hostapd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:hostapd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/icd echo set_metadata("/system/bin/icd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:icd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/immvibed echo set_metadata("/system/bin/immvibed", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:immvibed_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/imsqmidaemon echo set_metadata("/system/bin/imsqmidaemon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:imsqmidaemon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/installd echo set_metadata("/system/bin/installd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:installd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/insthk echo set_metadata("/system/bin/insthk", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:insthk_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/ipruleset echo set_metadata("/system/bin/ipruleset", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:ipruleset_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/jackservice echo set_metadata("/system/bin/jackservice", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:jackservice_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/keystore echo set_metadata("/system/bin/keystore", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:keystore_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/ks echo set_metadata("/system/bin/ks", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:ks_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/logwrapper echo set_metadata("/system/bin/logwrapper", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:logwrapper_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/mcDriverDaemon echo set_metadata("/system/bin/mcDriverDaemon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:mobicoredaemon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/mdnsd echo set_metadata("/system/bin/mdnsd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:mdnsd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/mediaserver echo set_metadata("/system/bin/mediaserver", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:mediaserver_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/mksh echo set_metadata("/system/bin/mksh", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:shell_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/mm-pp-daemon echo set_metadata("/system/bin/mm-pp-daemon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:mm-pp-daemon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/mm-qcamera-daemon echo set_metadata("/system/bin/mm-qcamera-daemon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:mm-qcamera-daemon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/mpdecision echo set_metadata("/system/bin/mpdecision", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:mpdecision_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/mtpd echo set_metadata("/system/bin/mtpd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:mtp_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/netcfg echo set_metadata("/system/bin/netcfg", "uid", 0, "gid", 3003, "mode", 02750, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/netd echo set_metadata("/system/bin/netd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:netd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/npsmobex echo set_metadata("/system/bin/npsmobex", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:mobexdaemon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/ping echo set_metadata("/system/bin/ping", "uid", 0, "gid", 0, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:ping_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/pppd echo set_metadata("/system/bin/pppd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:ppp_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/prepare_param.sh echo set_metadata("/system/bin/prepare_param.sh", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:prepare_param_sh_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/qcks echo set_metadata("/system/bin/qcks", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:qcks_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/qmuxd echo set_metadata("/system/bin/qmuxd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:qmuxd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/qosmgr echo set_metadata("/system/bin/qosmgr", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:qosmgr_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/qrngd echo set_metadata("/system/bin/qrngd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:qrngd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/qseecomd echo set_metadata("/system/bin/qseecomd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:qseecomd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/racoon echo set_metadata("/system/bin/racoon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:racoon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/rfs_access echo set_metadata("/system/bin/rfs_access", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:rfs_access_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/rild echo set_metadata("/system/bin/rild", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:rild_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/rmt_storage echo set_metadata("/system/bin/rmt_storage", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:rmt_storage_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/run-as echo set_metadata("/system/bin/run-as", "uid", 0, "gid", 2000, "mode", 0750, "capabilities", 0x0, "selabel", "u:object_r:runas_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/samsungpowersoundplay echo set_metadata("/system/bin/samsungpowersoundplay", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:samsungpowersoundplay_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/scranton_RD echo set_metadata("/system/bin/scranton_RD", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:playready_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/sdcard echo set_metadata("/system/bin/sdcard", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:sdcardd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/secure_storage_daemon echo set_metadata("/system/bin/secure_storage_daemon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:secure_storage_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/sensorhubservice echo set_metadata("/system/bin/sensorhubservice", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:sensorhubservice_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/servicemanager echo set_metadata("/system/bin/servicemanager", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:servicemanager_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/smdexe echo set_metadata("/system/bin/smdexe", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:smdexe_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/ss_conn_daemon echo set_metadata("/system/bin/ss_conn_daemon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:ss_conn_daemon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/ssr_diag echo set_metadata("/system/bin/ssr_diag", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:ssr_diag_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/surfaceflinger echo set_metadata("/system/bin/surfaceflinger", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:surfaceflinger_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/thermal-engine echo set_metadata("/system/bin/thermal-engine", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:thermald_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/thermald echo set_metadata("/system/bin/thermald", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:thermald_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/tima_dump_log echo set_metadata("/system/bin/tima_dump_log", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:tima_dump_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/time_daemon echo set_metadata("/system/bin/time_daemon", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:time_daemon_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/vold echo set_metadata("/system/bin/vold", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:vold_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/wpa_supplicant echo set_metadata("/system/bin/wpa_supplicant", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:wpa_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/etc/dhcpcd/dhcpcd-run-hooks echo set_metadata("/system/etc/dhcpcd/dhcpcd-run-hooks", "uid", 1014, "gid", 2000, "mode", 0550, "capabilities", 0x0, "selabel", "u:object_r:dhcp_system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor echo set_metadata("/system/vendor", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/etc echo set_metadata("/system/vendor/etc", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/etc/nxp echo set_metadata("/system/vendor/etc/nxp", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/etc/nxp/BargeIn echo set_metadata("/system/vendor/etc/nxp/BargeIn", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/etc/nxp/mVoIP echo set_metadata("/system/vendor/etc/nxp/mVoIP", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/etc/nxp/mVoIPFMC echo set_metadata("/system/vendor/etc/nxp/mVoIPFMC", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/etc/nxp/mVoIPSec echo set_metadata("/system/vendor/etc/nxp/mVoIPSec", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/firmware echo set_metadata("/system/vendor/firmware", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/lib echo set_metadata("/system/vendor/lib", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/lib/drm echo set_metadata("/system/vendor/lib/drm", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/lib/egl echo set_metadata("/system/vendor/lib/egl", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/lib/hw echo set_metadata("/system/vendor/lib/hw", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/lib/mediadrm echo set_metadata("/system/vendor/lib/mediadrm", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/lib/rfsa echo set_metadata("/system/vendor/lib/rfsa", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/lib/rfsa/adsp echo set_metadata("/system/vendor/lib/rfsa/adsp", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/media echo set_metadata("/system/vendor/media", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/pittpatt echo set_metadata("/system/vendor/pittpatt", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/pittpatt/models echo set_metadata("/system/vendor/pittpatt/models", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/pittpatt/models/detection echo set_metadata("/system/vendor/pittpatt/models/detection", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7 echo set_metadata("/system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.7", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.6 echo set_metadata("/system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.6", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/vendor/pittpatt/models/recognition echo set_metadata("/system/vendor/pittpatt/models/recognition", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/debuggerd echo set_metadata("/system/xbin/debuggerd", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:debuggerd_exec:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/librank echo set_metadata("/system/xbin/librank", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/procmem echo set_metadata("/system/xbin/procmem", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/bin/procrank echo set_metadata("/system/xbin/procrank", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING\META-INF\com\google\android\updater-script

echo detecting root..
if exist WORKING/system/xbin/su echo root detected
if exist WORKING/system/xbin/su echo ui_print("Initializing Root"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin/su echo set_metadata("/system/xbin/su", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
<<<<<<< HEAD
if exist WORKING/system/xbin/supolicy echo set_metadata("/system/xbin/supolicy", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
=======
>>>>>>> 04c0b1f956f76f863ba24aa2ff0ad29fc242af16
if exist WORKING/system/xbin/daemonsu echo set_metadata("/system/xbin/daemonsu", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/.ext echo set_metadata("/system/bin/.ext", "uid", 0, "gid", 0, "mode", 0777, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/bin/.ext/.su echo set_metadata("/system/bin/.ext/.su", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/install-recovery.sh echo set_metadata("/system/etc/install-recovery.sh", "uid", 0, "gid", 0, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/init.d/99SuperSUDaemon echo set_metadata("/system/etc/init.d/99SuperSUDaemon", "uid", 0, "gid", 0, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/etc/.installed_su_daemon echo set_metadata("/system/etc/.installed_su_daemon", "uid", 0, "gid", 0, "mode", 0644, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/app/Superuser.apk echo set_metadata("/system/app/Superuser.apk", "uid", 0, "gid", 0, "mode", 0644, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin/su echo run_program("/system/xbin/su", "--install"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/su echo root not detected
if not exist WORKING/system/xbin/su echo ##ROOTLINE##ui_print("Initializing Root"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/su echo ##ROOTLINE##set_metadata("/system/xbin/su", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
<<<<<<< HEAD
if not exist WORKING/system/xbin/supolicy echo ##ROOTLINE##set_metadata("/system/xbin/supolicy", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
=======
>>>>>>> 04c0b1f956f76f863ba24aa2ff0ad29fc242af16
if not exist WORKING/system/xbin/daemonsu echo ##ROOTLINE##set_metadata("/system/xbin/daemonsu", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/bin/.ext echo ##ROOTLINE##set_metadata("/system/bin/.ext", "uid", 0, "gid", 0, "mode", 0777, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/bin/.ext/.su echo ##ROOTLINE##set_metadata("/system/bin/.ext/.su", "uid", 0, "gid", 0, "mode", 06755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/etc/install-recovery.sh echo ##ROOTLINE##set_metadata("/system/etc/install-recovery.sh", "uid", 0, "gid", 0, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/etc/init.d/99SuperSUDaemon echo ##ROOTLINE##set_metadata("/system/etc/init.d/99SuperSUDaemon", "uid", 0, "gid", 0, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/etc/.installed_su_daemon echo ##ROOTLINE##set_metadata("/system/etc/.installed_su_daemon", "uid", 0, "gid", 0, "mode", 0644, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/app/Superuser.apk echo ##ROOTLINE##set_metadata("/system/app/Superuser.apk", "uid", 0, "gid", 0, "mode", 0644, "capabilities", 0x0, "selabel", "u:object_r:su_exec:s0"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/su echo ##ROOTLINE##run_program("/system/xbin/su", "--install"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo detecting busybox..
if exist WORKING/system/xbin/busybox echo busybox detected
if exist WORKING/system/xbin/busybox echo ui_print("Installing Busybox"); >> WORKING/META-INF/com/google/android/updater-script
if exist WORKING/system/xbin/busybox echo symlink("/system/xbin/busybox", "/system/bin/busybox"); >> WORKING\META-INF\com\google\android\updater-script
if exist WORKING/system/xbin/busybox echo run_program("/system/xbin/busybox", "--install", "-s", "/system/xbin"); >> WORKING\META-INF\com\google\android\updater-script
if not exist WORKING/system/xbin/busybox echo busybox not detected
if not exist WORKING/system/xbin/busybox echo ##BUSYBOXLINE##ui_print("Installing Busybox"); >> WORKING/META-INF/com/google/android/updater-script
if not exist WORKING/system/xbin/busybox echo ##BUSYBOXLINE##symlink("/system/xbin/busybox", "/system/bin/busybox"); >> WORKING\META-INF\com\google\android\updater-script
if not exist WORKING/system/xbin/busybox echo ##BUSYBOXLINE##run_program("/system/xbin/busybox", "--install", "-s", "/system/xbin"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING\META-INF\com\google\android\updater-script

echo adding app backup lines
if %autobackup% == No echo ##BACKUPAPPSLINE##ui_print("Restoring Apps"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##package_extract_file("tmp/apprestore.sh", "/tmp/apprestore.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##set_metadata("/tmp/apprestore.sh", "uid", 0, "gid", 0, "mode", 0777, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == No echo ##BACKUPAPPSLINE##run_program("/tmp/apprestore.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo ui_print("Restoring Apps"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo package_extract_file("tmp/apprestore.sh", "/tmp/apprestore.sh"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo set_metadata("apprestore.sh", "uid", 0, "gid", 0, "mode", 0777, "capabilities", 0x0, "selabel", "u:object_r:system_file:s0"); >> WORKING\META-INF\com\google\android\updater-script
if %autobackup% == Yes echo run_program("/tmp/apprestore.sh"); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING\META-INF\com\google\android\updater-script

echo adding kernel lines..
if %device% == unsupported echo ##ui_print("Unpacking Kernel"); >> WORKING/META-INF/com/google/android/updater-script
if %device% == unsupported echo ##package_extract_file("boot.img", "%kernel%"); >> WORKING/META-INF/com/google/android/updater-script
if not %device% == unsupported echo ui_print("Unpacking Kernel"); >> WORKING/META-INF/com/google/android/updater-script
if not %device% == unsupported echo package_extract_file("boot.img", "%kernel%"); >> WORKING/META-INF/com/google/android/updater-script
echo. >> WORKING/META-INF/com/google/android/updater-script

echo adding completion lines..
echo ui_print("******************************************"); >> WORKING\META-INF\com\google\android\updater-script
echo ui_print("        Successfully Installed"); >> WORKING\META-INF\com\google\android\updater-script
echo ui_print("******************************************"); >> WORKING\META-INF\com\google\android\updater-script
echo set_progress(1.0); >> WORKING\META-INF\com\google\android\updater-script
echo. >> WORKING\META-INF\com\google\android\updater-script
