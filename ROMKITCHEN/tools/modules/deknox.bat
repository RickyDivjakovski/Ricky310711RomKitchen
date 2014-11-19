set knox=Yes
if not exist WORKING/system/app/Bridge.apk (
if not exist WORKING/system/app/Bridge.odex (
if not exist WORKING/system/app/ContainerAgent.apk (
if not exist WORKING/system/app/ContainerAgent.odex (
if not exist WORKING/system/app/ContainerEventsRelayManager.apk (
if not exist WORKING/system/app/ContainerEventsRelayManager.odex (
if not exist WORKING/system/app/KLMSAgent.apk (
if not exist WORKING/system/app/KNOXAgent.apk (
if not exist WORKING/system/app/KNOXAgent.odex (
if not exist WORKING/system/app/KNOXAgent.odex (
if not exist WORKING/system/app/KnoxAttestationAgent.apk (
if not exist WORKING/system/app/KnoxAttestationAgent.odex (
if not exist WORKING/system/app/KnoxSetupWizardClient.apk (
if not exist WORKING/system/app/KnoxSetupWizardClient.odex (
if not exist WORKING/system/app/KNOXStore.apk (
if not exist WORKING/system/app/KNOXStore.odex (
if not exist WORKING/system/app/KNOXStub.apk (
if not exist WORKING/system/app/KNOXStub.odex (
if not exist WORKING/system/priv-app/KLMSAgent.apk (
if not exist WORKING/system/priv-app/KLMSAgent.odex (
if not exist WORKING/system/priv-app/SPDClient.apk (
if not exist WORKING/system/priv-app/SPDClient.odex (
if not exist WORKING/system/etc/secure_storage/com.sec.knox.store (
if not exist WORKING/system/lib/libknoxdrawglfunction.so (
if not exist WORKING/system/lib/libknox_encryption.so (
if not exist WORKING/system/lib/libskmipc.a (
if not exist WORKING/system/containers (
if not exist WORKING/system/preloadedsso (
set knox=No
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
)
)
)
)
)
)
)
)
)

cls
echo.
echo ********************************************************************************
echo.
echo                              knox status:%knox%
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
IF %selection% == 0 goto finishmodule
goto modulesmenu

:startdeknoxing
IF %knox% == No (
"tools/cecho" {0C}THE ROM IS ALREADY KNOX-FREE{#}
echo.
"tools/cecho" {0C}NO NEED TO REPEAT{#}
echo.
pause
goto finishmodule
)
if exist WORKING/system/app/Bridge.apk del WORKING\system\app\Bridge.apk
if exist WORKING/system/app/Bridge.odex del WORKING\system\app\Bridge.odex
if exist WORKING/system/app/ContainerAgent.apk del WORKING\system\app\ContainerAgent.apk
if exist WORKING/system/app/ContainerAgent.odex del WORKING\system\app\ContainerAgent.odex
if exist WORKING/system/app/ContainerEventsRelayManager.apk del WORKING\system\app\ContainerEventsRelayManager.apk
if exist WORKING/system/app/ContainerEventsRelayManager.odex del WORKING\system\app\ContainerEventsRelayManager.odex
if exist WORKING/system/app/KLMSAgent.apk del WORKING\system\app\KLMSAgent.apk
if exist WORKING/system/app/KLMSAgent.odex del WORKING\system\app\KLMSAgent.odex
if exist WORKING/system/app/KNOXAgent.apk del WORKING\system\app\KNOXAgent.apk
if exist WORKING/system/app/KNOXAgent.odex del WORKING\system\app\KNOXAgent.odex
if exist WORKING/system/app/KnoxSetupWizardClient.apk del WORKING\system\app\KnoxSetupWizardClient.apk
if exist WORKING/system/app/KnoxSetupWizardClient.odex del WORKING\system\app\KnoxSetupWizardClient.odex
if exist WORKING/system/app/KNOXStore.apk del WORKING\system\app\KNOXStore.apk
if exist WORKING/system/app/KNOXStore.odex del WORKING\system\app\KNOXStore.odex
if exist WORKING/system/app/KNOXStub.apk del WORKING\system\app\KNOXStub.apk
if exist WORKING/system/app/KNOXStub.odex del WORKING\system\app\KNOXStub.odex
if exist WORKING/system/app/KnoxAttestationAgent.apk del WORKING\system\app\KnoxAttestationAgent.apk
if exist WORKING/system/app/KnoxAttestationAgent.odex del WORKING\system\app\KnoxAttestationAgent.odex
if exist WORKING/system/priv-app/KLMSAgent.apk del WORKING\system\priv-app\KLMSAgent.apk
if exist WORKING/system/priv-app/KLMSAgent.odex del WORKING\system\priv-app\KLMSAgent.odex
if exist WORKING/system/priv-app/SPDClient.apk del WORKING/system/priv-app/SPDClient.apk
if exist WORKING/system/priv-app/SPDClient.odex del WORKING/system/priv-app/SPDClient.odex
if exist WORKING/system/etc/secure_storage/com.sec.knox.store rmdir /s /q WORKING\system\etc\secure_storage\com.sec.knox.store
if exist WORKING/system/lib/libknoxdrawglfunction.so del WORKING\system\lib\libknoxdrawglfunction.so
if exist WORKING/system/lib/libknox_encryption.so del WORKING\system\lib\libknox_encryption.so
if exist WORKING/system/lib/libskmipc.a del WORKING\system\lib\libskmipc.a
if exist WORKING/system/containers rmdir /s /q WORKING\system\containers
if exist WORKING/system/preloadedsso rmdir /s /q WORKING\system\preloadedsso
call tools/scripts/done
goto finishmodule

:finishmodule


