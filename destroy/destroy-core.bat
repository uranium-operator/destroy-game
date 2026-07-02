@echo off
if exist resource\ (
 goto con
) else (
 mkdir resource
 goto con
)
:con
if exist destroy.bat (
 move destroy.bat resource\
 goto con2
) else (
 goto con2
)
:con2
if exist help.txt (
 move help.txt resource\
 goto con3
) else (
 goto con3
)
:con3
echo cd
cd resource
echo starting...
call destroy.bat
cd %~dp0