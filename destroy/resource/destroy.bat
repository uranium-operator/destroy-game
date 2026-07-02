@echo off
set ach14=0
set ach80=0
set achWIN=0
set trig=0
set "build1=Statue Of Liberty"
set "build2=New York"
set "build3=School"
set "build4=Houses"
set "build5=Sentinel Island"
set build1HP=1000
set build2HP=15000
set build3HP=48
set build4HP=5000
set build5HP=80000
:destroy
set "save="
set "load="
if %build1HP% LEQ 0 (
 set "build1=(destroyed)"
 set build1HP=0
)
if %build2HP% LEQ 0 (
 set "build2=(destroyed)"
 set build2HP=0
 set trig=%trig%+1
 set ach14=1
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content achievement15000.txt -Raw), 'achievement')"
)
if %build3HP% LEQ 0 (
 set "build3=(destroyed)"
 set build3HP=0
)
if %build4HP% LEQ 0 (
 set "build4=(destroyed)"
 set build4HP=0
)
if %build5HP% LEQ 0 (
 set "build5=(destroyed)"
 set build5HP=0
 set /a trig=%trig%+1
 set ach80=1
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content achievement80000.txt -Raw), 'achievement')"
)
if %trig% EQU 2 (
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content achievementWIN.txt -Raw), 'achievement')
 set achWIN=1
)

(
echo Type help if you don't know how to play
echo %build1% : %build1HP%HP
echo %build2% : %build2HP%HP
echo %build3% : %build3HP%HP
echo %build4% : %build4HP%HP
echo %build5% : %build5HP%HP
echo achievement:
echo Conquering New York : %ach14%
echo Conquering Sentinel Island : %ach80%
echo WIN : %achWIN%
) > data.txt
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content data.txt -Raw), 'status')"
::input
set "type="
for /F "delims=" %%i in ('powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Destroy:', 'Destroy')}"') do set type=%%i
::logic
if "%type%" EQU "%build1%" (
 set /a build1HP=%build1HP%-1
 goto destroy
) else if "%type%" EQU "%build2%" (
 set /a build2HP=%build2HP%-1
 goto destroy
) else if "%type%" EQU "%build3%" (
 set /a build3HP=%build3HP%-1
 goto destroy
) else if "%type%" EQU "quit" (
 exit
) else if "%type%" EQU "%build4%" (
 set /a build4HP=%build4HP%-1
 goto destroy 
) else if "%type%" EQU "%build5%" (
 set /a build5HP=%build5HP%-1
 goto destroy
) else if "%type%" EQU "help" (
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content help.txt -Raw), 'help')"
 goto destroy
) else if "%type%" EQU "save" (
 goto save
) else if "%type%" EQU "load" (
 goto load
) else (
 echo no available building
 goto destroy
)

:save
cd..
if exist saves\ (
 cd saves
) else (
 mkdir saves
 cd saves
)
for /F "delims=" %%i in ('powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('saves name: ', 'save')}"') do set save=%%i
mkdir %save%
cd %save%
echo %build1HP% > "%build1%.txt"
echo %build2HP% > "%build2%.txt"
echo %build3HP% > "%build3%.txt"
echo %build4HP% > "%build4%.txt"
echo %build5HP% > "%build5%.txt"
echo %ach14% > "ach14.txt"
echo %ach80% > "ach80.txt"
echo %achWIN% > "achWIN.txt"
cd /d %~dp0
goto destroy

:load
cd..
cd saves
for /F "delims=" %%i in ('powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('load: ', 'load')}"') do set load=%%i
cd %load%
set /p build1HP=<"%build1%.txt"
set /p build2HP=<"%build2%.txt"
set /p build3HP=<"%build3%.txt"
set /p build4HP=<"%build4%.txt"
set /p build5HP=<"%build5%.txt"
set /p ach14=<"ach14.txt"
set /p ach80=<"ach80.txt"
set /p achWIN=<"achWIN.txt"
cd /d %~dp0
goto destroy
