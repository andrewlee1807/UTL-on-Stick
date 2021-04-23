@echo off

set EXE=Mojo.exe
set num=0
:loop

tasklist /NH /FI "IMAGENAME eq %EXE%" /FO CSV >> %%a >> search.log

echo %a%


timeout /t 1
goto loop

FOR /F %%A IN (search.log) DO echo %%A 


::tasklist /FI "IMAGENAME eq Mojo.exe" /FO CSV >> search.log

::FOR /F %%A IN (search.log) DO echo %%A 

::start Mojo.exe



