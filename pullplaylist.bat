@echo off
@REM U82ANI.vbs "output.txt" "output.ansi"
@REM move /y "output.ansi" "output.txt">nul
@REM type output.txt
echo b0.2.8���º�����˻�ȡ�赥���·�����
echo ����"old"��"new"�л�
del /s /q output.txt
:old
set /p music_url=����赥��������ַ:
if "%music_url%"=="new" (
echo ���л���
goto :new
)
if "%music_url%"=="old" (
echo ���л���
goto :old
)
python get.py
if exist output.txt notepad output.txt
del /s /q output.txt
goto :old

:new
set /p playlist_id=����赥ID:
if "%playlist_id%"=="new" (
echo ���л���
goto :new
)
if "%playlist_id%"=="old" (
echo ���л���
goto :old
)
python getplaylistbeta.py
if exist output.txt notepad output.txt
del /s /q output.txt
goto :new
