@echo on
echo.
echo select folder to search through
echo.
set /p opt1=folder: 
cd %opt1%
if exist index.txt (goto index_exists) else (goto index_create)
:index_exists
echo.
echo search string
echo.
set /p string=search: 
findstr "%string%" index.txt>temp00.txt
find /c "\" temp00.txt>temp01.txt
powershell -Command "(gc temp01.txt) -replace '---------- TEMP00.TXT: ', '' | Out-File -encoding ASCII temp02.txt"
powershell (Get-Content -Path .\temp02.txt -TotalCount 2)[-1]>temp03.txt
< temp03.txt (
  set /p file_count=
)
del temp01.txt temp02.txt temp03.txt
if %file_count% leq 15 (type temp00.txt) else (echo there are %file_count% results would you like to display them?
choice)
if %errorlevel% equ 1 (type temp00.txt)
echo.
echo.
echo.
echo press any key to exit...
pause>nul
exit /b
:index_create
cls
echo.
echo folder is not indexed, creating index now...
dir /s /b>index.txt
goto index_exists