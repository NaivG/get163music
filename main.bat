@echo off
md music
set version=b0.3.2
set runmode=normal
set dlyric=false
set downmode=false
cls
echo running in normal mode
echo type "switchtoartist" to switch artist mode
echo.
echo since b0.3.0 update,download music can be in multithreads.
echo this default is false.
echo type "multithreads" to switch it.
echo.
echo since b0.2.8 update,you can use pullplaylist beta.
echo it will return music name including artist.
echo.
echo since b0.2.7 update,you can choose whether download lyric or not.
echo type "nolyric" or "downloadlyric" to switch it.
:idd
title Download Music %version%
set /p id=id:

if "%id%"=="multithreads" (
    if "%downmode%"=="false" (
        set downmode=true
        echo switched to true.
    ) else (
        set downmode=false
        echo switched to false.
    )
    goto :idd
)
if "%id%"=="switchtoartist" (
    set runmode=artist
    echo switched to artist mode.
    goto :setupartist
)
if "%id%"=="artist" (
    goto :setupartist
)
if "%id%"=="nolyric" (
    set dlyric=false
    echo switched to false.
    goto :idd
)
if "%id%"=="downloadlyric" (
    set dlyric=true
    echo switched to true.
    goto :idd
)

set /p name=name:

if "%runmode%"=="artist" (
    title Download Music %version%-Downloading %id%  artist:%artist%
) else (
    title Download Music %version%-Downloading %id%
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::

rem if "%runmode%"=="artist" (
rem     if exist "%cd%\music\%name% - %artist%.mp3" (
rem         echo exist.skipping...
rem         goto :idd
rem     )
rem ) else (
rem     if exist "%cd%\music\%name%.mp3" (
rem         echo exist.skipping...
rem         goto :idd
rem     )
rem )
rem if exist "%cd%\backup\%name%.mp3" (
rem     echo exist.skipping...
rem     goto :idd
rem )

echo =============ÏÂÔØÖÐ=============
rem if "%runmode%"=="artist" (
rem     aria2c.exe --file-allocation=none -V --max-connection-per-server=16 --min-split-size=1M --dir="music" --out="%name% - %artist%.mp3" http://music.163.com/song/media/outer/url?id=%id%.mp3
rem ) else (
rem     aria2c.exe --file-allocation=none -V --max-connection-per-server=16 --min-split-size=1M --dir="music" --out="%name%.mp3" http://music.163.com/song/media/outer/url?id=%id%.mp3
rem )

::wget http://music.163.com/song/media/outer/url?id=%id%.mp3 --output-file="%name%.mp3"
::title Download Music 0.1-Downloading %id%
::copy *.mp3 %cd%\music
::del /q "%name%.mp3"

rem if "%dlyric%"=="false" goto :idd
rem set lyric_url=http://music.163.com/api/song/media?id=%id%
rem if "%runmode%"=="artist" (
rem     set "lyric_name=%name% - %artist%.lrc"
rem ) else (
rem     set "lyric_name=%name%.lrc"
rem )
rem if exist "%cd%\music\%name%.lrc" (
rem     echo exist.skipping...
rem     goto :idd
rem )
rem python getlyric.py

::::::::::::::::::::::::::::::::::::::::::::::::::::::

if "%lastid%"=="%id%" call :existid

if "%downmode%"=="false" (
    call bin\download.module
) else (
    echo call multithreads...
    start bin\multithreads %id% "%name%" %dlyric% %runmode% %artist%
    ping -n 2 127.1>nul
)

set lastid=%id%

goto idd

:setupartist
set /p artist=setupartist:
echo switch to %artist%.
pause
goto :idd

:existid
set choices="N"
echo WARN:you are trying to download a music 
echo        which id is equal to the last music.
echo      usually,it will appear because the pullplaylist beta
echo        will place two blank line.
echo      type "Y" to ingoring this download.
set /p choices=:
if "%choices%"=="Y" goto :EOF
echo skipping...
goto :idd