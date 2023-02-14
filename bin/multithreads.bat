@echo off
echo.
echo ===========thread info===========
echo thread name: %0
echo music id: %1
echo music name: %~2
echo download lyric: %3
echo running mode: %4
echo artist: %5
echo multithreads: %6
set id=%1
set name=%~2
set dlyric=%3
set runmode=%4
set artist=%5
set downmode=%6
echo =================================
echo. 
call bin\download.module
if "%downmode%"=="true" exit