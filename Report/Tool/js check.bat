@if (@X)==(@Y) @end /* JSCRIPT COMMENT **
@echo off

::tasklist /FI "IMAGENAME eq Mojo.exe" 

::loop

for /f %a in ('wmic process where "Name='Mojo.exe'" get WorkingSetSize^|findstr [0-9]') do set "var=%a"


::timeout /t 1

::goto loop