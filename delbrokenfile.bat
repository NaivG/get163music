@echo off
cd music
md BROKENFILE
setlocal ENABLEDELAYEDEXPANSION
for %%i in (*.*) do (
set size=%%~zi
set /a kb=!size!/1024
if !size! leq 204800 (
      echo %%i ��СΪ !kb! KB ���������200KB
      move "%%i" .\BROKENFILE
   )
)
explorer .\BROKENFILE
pause