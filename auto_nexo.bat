@echo on
:start
if not exist "script_hub_apps" goto setup
if not exist "C:\users\%username%\appdata\config.sav" goto setup
echo [33mperforming file number check[0m
< C:\users\%username%\appdata\config.sav (
  set /p previous_file_count=
)
cd script_hub_apps
dir /b>..\dir.txt
cd ..
find /c "bat" dir.txt>find.txt
powershell -Command "(gc find.txt) -replace '---------- DIR.TXT: ', '' | Out-File -encoding ASCII replace.txt"
powershell (Get-Content -Path .\replace.txt -TotalCount 2)[-1]>replace2.txt
< replace2.txt (
  set /p file_count=
)
if %file_count% neq %previous_file_count% goto begin_process
echo [92mno new files where detected[0m
echo [33mdeleting temp files[0m
del dir.txt&del find.txt&del replace.txt&del replace2.txt
echo waiting 10 secconds untill next check, press any key to skip cooldown.
timeout 10 >nul
goto start
:setup
echo app folder not detected, creating app folder and "config.sav" for save storage
mkdir script_hub_apps
if exist "script_hub_apps" (echo [92mcreated script_hub_apps folder[0m) else (echo [31m error when trying to create script folder[0m)
echo 0 >C:\users\%username%\appdata\config1.sav
powershell -Command "(gc C:\users\%username%\appdata\config1.sav) -replace ' ', '' | Out-File -encoding ASCII C:\users\%username%\appdata\config.sav"
del C:\users\%username%\appdata\config1.sav
if exist C:\users\%username%\appdata\config.sav (echo created config.sav with value: 0) else (echo [31merror when trying to create config.txt[0m)
goto start
:begin_process
echo [33m new files where detected, creating content-table...[0m
cd script_hub_apps
dir /b>..\table.txt
cd ..
echo [33m commiting any new files
if not exist "\script_hub_apps\.git" (echo [33m no repo was found, creating it now[0m
cd script_hub_apps
git init
git remote add origin https://github.com/Guest257351/hub-scripts.git
cd ..)
cd script_hub_apps
set CN=0
:add_loop
set /a CN=%CN%+1
PowerShell "GC ..\table.txt -TotalCount %CN%|Select -L 1">..\script_name.txt
< ..\script_name.txt (
  set /p script_name=
)
git add %script_name%
if %CN% neq %file_count% goto add_loop
git commit -m "updates"
cd ..
echo starting hub rebuilding...
echo [33mpulling prefix script...[0m
echo accessing url: https://raw.githubusercontent.com/Guest257351/script-hub/main/prefix-script
Powershell (Invoke-webrequest -URI "https://raw.githubusercontent.com/Guest257351/script-hub/main/prefix-script").Content >"script hub.bat"
>nul find "At" "script hub.bat" && (
  goto offline
) || (
  echo [92m prefix script was pulled and added to "script hub.bat", previous contents have been wiped[0m
)
echo [33m starting choice list generation[0m
set CN=0
:choice_list_loop
set /a CN=%CN%+1
PowerShell "GC .\table.txt -TotalCount %CN%|Select -L 1">script_name.txt
< script_name.txt (
  set /p script_name=
)
echo echo %CN%(%script_name%>>"script hub.bat"
echo [92mchoice %CN% completed[0m
if %CN% neq %file_count% goto choice_list_loop
echo [92mchoice generation complete[0m
echo [33madding set statement[0m
echo set /p menu_choice=>>"script hub.bat"
echo [92mset statement added[0m
echo [33mgenerating if statements... [31mTHIS COULD TAKE A WHILE![0m
set CN=0
Powershell (Invoke-webrequest -URI "https://raw.githubusercontent.com/Guest257351/script-hub/main/if-code").Content >"temp_if.txt"
:if_loop
set /a CN=%CN%+1
PowerShell "GC .\table.txt -TotalCount %CN%|Select -L 1">script_name.txt
< script_name.txt (
  set /p script_name=
)
copy /b "script hub.bat" + "temp_if.txt" file.tmp
del "script hub.bat"
ren file.tmp "script hub.bat"
powershell -Command "(gc 'script hub.bat') -replace 'REPnum', '%CN%' | Out-File -encoding ASCII 'script hub.bat'"
powershell -Command "(gc 'script hub.bat') -replace 'REPname', '%script_name%' | Out-File -encoding ASCII 'script hub.bat'"
echo [92mif number %CN% completed[0m
if %CN% neq %file_count% goto if_loop
echo [92mif statement generation complete[0m
echo [33mcreating script downloading, running, and updating scripts. [31mTHIS COULD TAKE A WHILE![0m
echo downloading script localy to speed up process. URL: https://raw.githubusercontent.com/Guest257351/script-hub/main/run-script
Powershell (Invoke-webrequest -URI "https://raw.githubusercontent.com/Guest257351/script-hub/main/run-script").Content >"temp_script.txt"
>nul find "At" temp_script.bat && (
  goto offline
) || (
  echo [92mrun script was pulled and added to "temp_script.txt", previous contents have been wiped[0m
)
set CN=0
:run_loop
set /a CN=%CN%+1
PowerShell "GC .\table.txt -TotalCount %CN%|Select -L 1">script_name.txt
< script_name.txt (
  set /p script_name=
)
copy /b "script hub.bat" + "temp_script.txt" file.tmp
del "script hub.bat"
ren file.tmp "script hub.bat"
echo copied script to end of "script hub.bat"
powershell -Command "(gc 'script hub.bat') -replace 'REPtxt1', '%script_name%' | Out-File -encoding ASCII 'script hub.bat'"
echo replaced REPtxt1 with %script_name% in all occurences 
echo [92mrun script %CN% completed[0m
if %CN% neq %file_count% goto run_loop
echo [92mall run scripts where added[0m
echo [33mpushing files to github...[0m
cd script_hub_apps
git push --set-upstream origin master
echo [92mfiles pushed![0m
echo deleting temp files
cd ..
del dir.txt + find.txt + replace.txt + replace2.txt + script_name.txt + table.txt + temp_if.txt + temp_script.txt
echo saving file amount
echo %file_count% >C:\users\%username%\appdata\config.sav
powershell -Command "(gc C:\users\%username%\appdata\config1.sav) -replace ' ', '' | Out-File -encoding ASCII C:\users\%username%\appdata\config.sav"
echo [92mprocess completed,! returning to loop search in 10 secconds[0m
goto start





copy /b "script hub.bat" + "temp_script.txt" file.tmp
del "script hub.bat"
ren file.tmp "script hub.bat"
:offline
echo [31mprogram requires an internet connection to work, press any key to exit...[0m
pause >nul
exit