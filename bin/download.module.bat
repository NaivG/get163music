@echo off
echo ===========thread start===========

if "%runmode%"=="artist" (
    if exist "%cd%\music\%name% - %artist%.mp3" (
        echo exist.skipping...
        goto :skip
    )
) else (
    if exist "%cd%\music\%name%.mp3" (
        echo exist.skipping...
        goto :skip
    )
)
if exist "%cd%\backup\%name%.mp3" (
    echo exist.skipping...
    goto :skip
)

if "%runmode%"=="artist" (
    bin\aria2c.exe --file-allocation=none -V --max-connection-per-server=16 --min-split-size=1M --dir="music" --out="%name% - %artist%.mp3" http://music.163.com/song/media/outer/url?id=%id%.mp3
) else (
    bin\aria2c.exe --file-allocation=none -V --max-connection-per-server=16 --min-split-size=1M --dir="music" --out="%name%.mp3" http://music.163.com/song/media/outer/url?id=%id%.mp3
)

if "%dlyric%"=="false" goto :skip
set lyric_url=http://music.163.com/api/song/media?id=%id%
if "%runmode%"=="artist" (
    set "lyric_name=%name% - %artist%.lrc"
) else (
    set "lyric_name=%name%.lrc"
)
if exist "%cd%\music\%name%.lrc" (
    echo exist.skipping...
    goto :skip
)
python bin\getlyric.py

:skip
echo ===========thread end===========