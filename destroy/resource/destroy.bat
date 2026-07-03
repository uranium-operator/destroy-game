@echo off
::default-reset
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

:menu
for /f "delims=" %%a in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f=New-Object Windows.Forms.Form; $f.Text='Destroy beta 1.4'; $f.Width=300; $f.Height=300; $l=New-Object Windows.Forms.Label; $l.Text=(Get-Content menu.txt -Raw -ErrorAction SilentlyContinue); $l.Dock='Top'; $f.Controls.Add($l); $p=New-Object Windows.Forms.Panel; $p.Dock='Bottom'; $f.Controls.Add($p); @('new game','load','help') | ForEach-Object -Begin {$x=10} -Process {$b=New-Object Windows.Forms.Button; $b.Text=$_; $b.Left=$x; $b.Width=80; $b.Add_Click({$global:res=$this.Text; $f.Close()}); $p.Controls.Add($b); $x+=90}; $f.ShowDialog()|Out-Null; $global:res"') do set "menu=%%a"
if "%menu%" EQU "new game" (
 goto new-game
)
if "%menu%" EQU "load" (
 set menu-recv=1
 goto load
)
if "%menu%" EQU "help" (
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content help.txt -Raw), 'help')"
 goto menu
)
goto menu
:new-game
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
if %build2HP% LEQ 0 if %ach14% EQU 0 (
 set "build2=(destroyed)"
 set build2HP=0
 set /a trig+=1
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
if %build5HP% LEQ 0 if %ach80% EQU 0 (
 set "build5=(destroyed)"
 set build5HP=0
 set /a trig+=1
 set ach80=1
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content achievement80000.txt -Raw), 'achievement')"
)
if %trig% EQU 2 if %achWIN% EQU 0 (
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content achievementWIN.txt -Raw), 'achievement')"
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
echo.
echo.
echo.
echo.
echo.
echo.
echo Attack? :
) > data.txt
::input
set "type="
for /f "delims=" %%a in ('powershell -Command "Add-Type -AssemblyName System.Windows.Forms; $f=New-Object Windows.Forms.Form; $f.Text='Destroy Game'; $b=New-Object Windows.Forms.Button; $b.Text='OK'; $b.Dock='Bottom'; $b.Add_Click({$f.Close()}); $f.Controls.Add($b); $c=New-Object Windows.Forms.ComboBox; $c.Items.AddRange(@('Statue Of Liberty','New York','School','Houses','Sentinel Island','save','load','help','quit')); $c.Dock='Bottom'; $f.Controls.Add($c); $l=New-Object Windows.Forms.Label; $l.Text=(Get-Content data.txt -Raw -ErrorAction SilentlyContinue); $l.Dock='Fill'; $b.BringToFront(); $f.Controls.Add($l); $f.ShowDialog()|Out-Null; $c.SelectedItem"') do set "type=%%a"
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
if not exist list.txt type nul > list.txt
for /F "delims=" %%i in ('powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('saves name: ', 'save')}"') do set save=%%i
if "%save%" EQU "" goto destroy
findstr /x /c:"%save%" list.txt
if %errorlevel% EQU 1 (
 echo %save% >> list.txt
 mkdir "%save%"
 cd "%save%"
 echo %build1HP% > "%build1%.txt"
 echo %build2HP% > "%build2%.txt"
 echo %build3HP% > "%build3%.txt"
 echo %build4HP% > "%build4%.txt"
 echo %build5HP% > "%build5%.txt"
 echo %trig% > "trig".txt
 echo %ach14% > "ach14.txt"
 echo %ach80% > "ach80.txt"
 echo %achWIN% > "achWIN.txt"
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Saved to %save%', 'load')"
 cd /d %~dp0
 goto destroy
) else (
 cd "%save%"
 echo %build1HP% > "%build1%.txt"
 echo %build2HP% > "%build2%.txt"
 echo %build3HP% > "%build3%.txt"
 echo %build4HP% > "%build4%.txt"
 echo %build5HP% > "%build5%.txt"
 echo %trig% > "trig".txt
 echo %ach14% > "ach14.txt"
 echo %ach80% > "ach80.txt"
 echo %achWIN% > "achWIN.txt"
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Saved to %save%', 'load')"
 cd /d %~dp0
 goto destroy
)


:load
cd..
cd "saves"
if exist list.txt (
 goto load-con
) else (
 if %menu-recv% EQU 1 (
  powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content sav-de.txt -Raw), 'load')"
  set menu-recv=0
  goto menu 
 ) else (
  powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content sav-de.txt -Raw), 'load')"
  goto destroy
 )
)
:load-con

powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show((Get-Content list.txt -Raw), 'saves list')"
for /F "delims=" %%i in ('powershell -Command "& {Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('load : ', 'load')}"') do set load=%%i
if exist "%load%\" (
 goto load-con2
) else (
 powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('There's no "%load%" in saves', saves list')"
)
:load-con2
cd "%load%"
set /p build1HP=<"%build1%.txt"
set /p build2HP=<"%build2%.txt"
set /p build3HP=<"%build3%.txt"
set /p build4HP=<"%build4%.txt"
set /p build5HP=<"%build5%.txt"
set /p trig=<"trig.txt"
set /p ach14=<"ach14.txt"
set /p ach80=<"ach80.txt"
set /p achWIN=<"achWIN.txt"
cd /d %~dp0
goto destroy