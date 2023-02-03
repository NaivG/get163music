@echo off
cd music
md BROKENFILE
setlocal ENABLEDELAYEDEXPANSION
for %%i in (*.*) do (
set size=%%~zi
set /a kb=!size!/1024
if !size! leq 204800 (
      echo %%i 大小为 !kb! KB 不满足大于200KB
      move "%%i" .\BROKENFILE
   )
)
explorer .\BROKENFILE
pause