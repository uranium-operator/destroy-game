@echo off
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
if %build1HP% LEQ 0 (
 set "build1=(destroyed)"
 set build1HP=0
)
if %build2HP% LEQ 0 (
 set "build2=(destroyed)"
 set build2HP=0
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
)
cls
(
echo Type help if you don't know how to play
echo %build1% : %build1HP%HP
echo %build2% : %build2HP%HP
echo %build3% : %build3HP%HP
echo %build4% : %build4HP%HP
echo %build5% : %build5HP%HP
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
) else (
 echo no available building
 goto destroy
)