@echo off
rem U82ANI.vbs "output.txt" "output.ansi"
rem move /y "output.ansi" "output.txt">nul
rem type output.txt
:1

set /p music_url=ÊäÈë¸èµ¥ÍøÖ·:
python get.py
notepad output.txt
del /s /q output.txt
goto :1
