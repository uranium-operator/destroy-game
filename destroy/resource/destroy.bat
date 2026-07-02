@echo off
set "build1=Statue Of Liberty"
set "build2=New York"
set "build3=School"
set build1HP=100
set build2HP=15000
set build3HP=48
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
cls
(
echo %build1% : %build1HP%
echo %build2% : %build2HP%
echo %build3% : %build3HP%
) > data.txt
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content data.txt -Raw), 'Pesan')"
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
) else (
 echo no available building
 goto destroy
)
