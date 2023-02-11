@echo off
echo.
echo ===========thread info===========
echo thread name: %0
echo music id: %1
echo music name: %~2
echo download lyric: %3
echo running mode: %4
echo artist: %5
set id=%1
set name=%~2
set dlyric=%3
set runmode=%4
set artist=%5
echo =================================
echo. 
call bin\download.module
exit