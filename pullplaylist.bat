@echo off
@REM U82ANI.vbs "output.txt" "output.ansi"
@REM move /y "output.ansi" "output.txt">nul
@REM type output.txt
echo b0.2.8更新后加入了获取歌单的新方法。
echo 输入"old"或"new"切换
del /s /q output.txt
:old
set /p music_url=输入歌单、歌手网址:
if "%music_url%"=="new" (
echo 已切换。
goto :new
)
if "%music_url%"=="old" (
echo 已切换。
goto :old
)
python get.py
if exist output.txt notepad output.txt
del /s /q output.txt
goto :old

:new
set /p playlist_id=输入歌单ID:
if "%playlist_id%"=="new" (
echo 已切换。
goto :new
)
if "%playlist_id%"=="old" (
echo 已切换。
goto :old
)
python getplaylistbeta.py
if exist output.txt notepad output.txt
del /s /q output.txt
goto :new
