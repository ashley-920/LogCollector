@echo off

echo  __________________________
echo ^|.-----------..-----------.^|
echo ^|^|           ^|^|           ^|^|
echo ^|^|           ^|^|           ^|^|
echo ^|^|           ^|^|           ^|^|
echo ^|^|           ^|^|           ^|^|
echo ^|^|_          ^|^|           ^|^|
echo ^|^| '.        ^|^|           ^|^|
echo ^|^|^|\ \       ^|^|           ^|^|
echo ^|^|;_\_;______^|^|___________^|^|
echo ^|^|--,-.------..-----------.^|
echo ^|^| \^| ^|    _.^|^|"'--.      ||
echo ^|^|\ ^| ^| _." .||-"_) `)    ^|^|    Log Collector 
echo ^|^|_)  `"  .-.|| __.-'     ||    by Ash :)
echo ^|^|       (   ^|^|`          ^|^|
echo ^|^|  ' .  ^|   ^|^|           ^|^|
echo ^|^|  ()    \  ^|^| .-.       ^|^|
echo ^|^|\/_     ^| _^|^|' _;\      ^|^|
echo ^|^|_`_____/_'_^|^|____/______^|^|
echo '--------------------------'

cd /d %~dp0 
echo Start to collect Log.............
For /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set mydate=%%a-%%b-%%c)
For /f "tokens=1-3 delims=/: " %%a in ("%time%") do (set mytime=%%a-%%b-%%c)
set foldername=Log_Result_%mydate%_%mytime%
MKDIR %foldername%

echo Start to dump memory
if "%PROCESSOR_ARCHITECTURE%"=="x86" (
echo .|win32dd /a /r /f .\%foldername%\physmem.bin 
)
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
echo .|win64dd /a /r /f .\%foldername%\physmem.bin 
)
echo Finish to dump memory

echo Start to collect System Info 
systeminfo >> .\%foldername%\systeminfo.txt
echo Finished collecting System Info

echo Start to collect System Info 
systeminfo >> .\%foldername%\systeminfo.txt
echo Finished collecting System Info

echo Start to collect Net Info
echo =================== Net User =================== >> .\%foldername%\net.txt
net user >> .\%foldername%\net.txt
echo =================== Net accounts =================== >> .\%foldername%\net.txt
net accounts >> .\%foldername%\net.txt
echo =================== Net Localgroup =================== >> .\%foldername%\net.txt
net localgroup >> .\%foldername%\net.txt
echo =================== Net Localgroup Administrator =================== >> .\%foldername%\net.txt
net localgroup administrators >> .\%foldername%\net.txt
echo =================== Net Share =================== >> .\%foldername%\net.txt
net share >> .\%foldername%\net.txt
echo =================== Net View =================== >> .\%foldername%\net.txt
net view >> .\%foldername%\net.txt
echo Finished collect net Information

echo Start to collect TCPView Log
Tcpvcon.exe -c >> .\%foldername%\tcpview_log.txt
echo Finished to collect TCPView Log


echo Start to collect Network Config
echo =================== IPConfig =================== >> .\%foldername%\net_config.txt
ipconfig /all >> .\%foldername%\net_config.txt
echo =================== NetState =================== >> .\%foldername%\net_config.txt
netstat -n -a >> .\%foldername%\net_config.txt
echo =================== Route =================== >> .\%foldername%\net_config.txt
route PRINT >> .\%foldername%\net_config.txt
echo =================== ARP =================== >> .\%foldername%\net_config.txt
arp -a >> .\%foldername%\net_config.txt
echo Finished collecting Network Config


echo Start to collect Registry Key info
autoruns.exe -a .\%foldername%\autorun.arn 
echo Finish collect Registry Key info

echo Start to collect Event Log
psloglist.exe -s >> .\%foldername%\event_log.txt
echo Finished collecting Event Log

echo Start to collect Process Info
psinfo.exe /accepteula -d -h -s >> .\%foldername%\process_info.txt 
echo Finish collect Registry Key info

pause