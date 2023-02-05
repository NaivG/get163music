@echo off
:1
set /p id=id:
set /p name=name:
set lyric_url=http://music.163.com/api/song/media?id=%id%
set "lyric_name=%name%.lrc"
python getlyric.py
goto :1