@echo off
md music
set version=b0.2.8
set runmode=normal
set dlyric=false
cls
echo running in normal mode
echo type "switchtoartist" to switch artist mode
echo since b0.2.8 update,you can use pullplaylist beta.
echo it will return music name including artist.
echo.
echo since b0.2.7 update,you can choose whether download lyric or not.
echo type "nolyric" or "downloadlyric" to switch it.
:idd
title Download Music %version%
set /p id=:

if "%id%"=="switchtoartist" (
    echo switched.
    set runmode=artist
    goto :setupartist
)
if "%id%"=="artist" (
    goto :setupartist
)
if "%id%"=="nolyric" (
    echo switched.
    set dlyric=false
    goto :idd
)
if "%id%"=="downloadlyric" (
    echo switched.
    set dlyric=true
    goto :idd
)

set /p name=name:

if "%runmode%"=="artist" (
    title Download Music %version%-Downloading %id%  artist:%artist%
) else (
    title Download Music %version%-Downloading %id%
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
    aria2c.exe --file-allocation=none -V --max-connection-per-server=16 --min-split-size=1M --dir="music" --out="%name% - %artist%.mp3" http://music.163.com/song/media/outer/url?id=%id%.mp3
) else (
    aria2c.exe --file-allocation=none -V --max-connection-per-server=16 --min-split-size=1M --dir="music" --out="%name%.mp3" http://music.163.com/song/media/outer/url?id=%id%.mp3
)
::wget http://music.163.com/song/media/outer/url?id=%id%.mp3 --output-file="%name%.mp3"
::title Download Music 0.1-Downloading %id%
::copy *.mp3 %cd%\music
::del /q "%name%.mp3"

if "%dlyric%"=="false" goto :idd
set lyric_url=http://music.163.com/api/song/media?id=%id%
if "%runmode%"=="artist" (
    set "lyric_name=%name% - %artist%.lrc"
) else (
    set "lyric_name=%name%.lrc"
)
if exist "%cd%\music\%name%.lrc" (
    echo exist.skipping...
    goto :idd
)
python getlyric.py

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
