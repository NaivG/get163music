@echo off
cd music
md BROKENFILE
setlocal ENABLEDELAYEDEXPANSION
for %%i in (*.mp3) do (
set size=%%~zi
set /a kb=!size!/1024
if !size! leq 204800 (
      echo %%i ��СΪ !kb! KB ���������200KB
      move "%%i" .\BROKENFILE
   )
)
for %%i in (*.lrc) do (
set size=%%~zi
if !size! leq 5 (
      echo %%i ��СΪ !kb! B ���������5B
      move "%%i" .\BROKENFILE
   )
)
explorer .\BROKENFILE
pause