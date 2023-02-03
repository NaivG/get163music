@echo off
md music
cls
echo running in normal mode
echo type "switchtoartist" to switch artist mode
set runmode=normal
:idd
title Download Music b0.2.6
set /p id=:
if "%id%"=="switchtoartist" (
echo switched.
set runmode=artist
goto :setupartist
)
if "%id%"=="artist" (
goto :setupartist
)
set /p name=name:
if "%runmode%"=="artist" (
title Download Music b0.2.6-Downloading %id%  artist:%artist%
) else (
title Download Music b0.2.6-Downloading %id%
)
if "%runmode%"=="artist" (
if exist "%cd%\music\%name% - %artist%.mp3" (
echo exist.skipping...
goto :idd
)
) else (
if exist "%cd%\music\%name%.mp3" (
echo exist.skipping...
goto :idd
)
)
if exist "%cd%\backup\%name%.mp3" (
echo exist.skipping...
goto :idd
)
echo =============ÏÂÔØÖÐ=============
if "%runmode%"=="artist" (
aria2c.exe --file-allocation=none -V --max-connection-per-server=16 --min-split-size=1M --dir music --out "%name% - %artist%.mp3" http://music.163.com/song/media/outer/url?id=%id%.mp3
) else (
aria2c.exe --file-allocation=none -V --max-connection-per-server=16 --min-split-size=1M --dir music --out "%name%.mp3" http://music.163.com/song/media/outer/url?id=%id%.mp3
)
::wget http://music.163.com/song/media/outer/url?id=%id%.mp3 --output-file="%name%.mp3"
::title Download Music 0.1-Downloading %id%
::copy *.mp3 %cd%\music
::del /q "%name%.mp3"
goto idd

:setupartist
set /p artist=setupartist:
echo switch to %artist%.
pause
goto :idd
echo Done!
echo Press Any Key To Exit...
pause>nul
exit
