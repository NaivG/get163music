@echo off

set "sha_tmp=_tmp_sha.txt"
set "mv_tmp=_tmp_mv.txt"
set "tmp_mv=_mv_tmp.bat"
type nul>%sha_tmp%

set /a n=0
set /a m=0
setlocal ENABLEDELAYEDEXPANSION
echo ��ȡ�����ļ��ֽڴ�С
for /r %%i in (*) do (
   set /a m+=1
   echo %%i [%%~zi]
   if /i not defined s[%%~zi] (
      set s[%%~zi]=%%i
   ) else (
      if not defined [%%i] (
         set /a n+=1
         set [%%i]=a
         set "f[!n!]=%%i"
      )
      if not defined [!s[%%~zi]!] (
         set /a n+=1
         set [!s[%%~zi]!]=a
         set "f[!n!]=!s[%%~zi]!"
      )
   )
)
echo �ܼ��ļ�������!m! >>.\%mv_tmp%
echo ------------------------------
pause
echo !n! : 0  ��ҪSHA1������������ ���ѷ�������
for /l %%i in (1,1,!n!) do (
   set /p =!f[%%i]!^|<nul
   CertUtil -hashfile "!f[%%i]!" SHA1|find /v ":"
)>>%sha_tmp%&echo !n! : %%i "!f[%%i]!"
endlocal
pause

set h=%time:~0,2%
set h=%h: =0%
set dirtmp="%cd%\_tmp_%h%%time:~3,2%%time:~6,2%"
md %dirtmp%
echo ������ʱĿ¼ %dirtmp%
echo @echo off > %dirtmp%\%tmp_mv%

set /a n=0
setlocal ENABLEDELAYEDEXPANSION
for /f "tokens=1,2 delims=|" %%i in (.\%sha_tmp%) do (
   if not defined [%%j] (
      set "[%%j]=%%i"
   ) else (
      set /a n+=1
      echo %%i
      move /y "%%i" "%dirtmp%\"
      echo move /y "%%~nxi" "%%~dpi" >> %dirtmp%\%tmp_mv%
      echo ��ͬ��![%%j]! >> .\%mv_tmp%
      echo �ƶ���%%i >> .\%mv_tmp%
   )
)
echo �ܼ��ƶ���!n! �ļ��� %dirtmp%
echo �ܼ��ƶ���!n! >> .\%mv_tmp%
endlocal
pause