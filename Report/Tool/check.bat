@echo off
: Rich Kreider <rjk@techish.net>
: report processor time for given process until process exits (could be expanded to use a PID to be more
: precise)
: Depends:  typeperf
: Usage:  foo.cmd <processname>

::set process=Wondershare Filmora9

set process=Mojo

echo Press CTRL-C To Stop...
:begin
for /f "tokens=2 delims=," %%c in ('typeperf "\Process(%process%)\%% Processor Time" -si 1 -sc 1 ^| find /V "\\"') do (
if %%~c==-1 (
goto :end
) else (
set %t% = %%~c
echo %%~t
echo %%~c%%

goto begin
)
)

:end
echo Process seems to have terminated.