@echo off
color 07

for /f "tokens=*" %%a IN ('cd') do (
rem	@SET ver=%%~na
rem	@SET FILE_PATH=%%~fa
rem	@SET FilePath=%%~nxa
)

SET FILE_PATH=.\..\
SET TARGET_FILE=.sql
SET OUT_MERGE_FILE=21.Procedure_patch_all.sql
SET OUT_HIST_FILE=21.Procedure_history_all.sql

ECHO ������������������������������������������������������������������������
ECHO     ��ġ ���� ��ġ: %FILE_PATH%
ECHO ������������������������������������������������������������������������

echo.
rem :Step_Confirm
rem SET choice=
rem set /p choice=��ġ ���� ��ġ�� ��Ȯ�մϱ�?(y/n)? :
rem if '%choice%'=='y' goto Step_Merge
rem if '%choice%'=='n' goto Step_Exit
rem goto Step_Confirm


:Step_Merge
if exist %FILE_PATH%\%OUT_MERGE_FILE% (
	del %FILE_PATH%\%OUT_MERGE_FILE%
)

if exist %OUT_HIST_FILE% (
	del %FILE_PATH%\%OUT_HIST_FILE%
)

for /f "tokens=*" %%a in ('dir /b /on "*.sql"') do (
	echo %%a

rem	echo. >> %FILE_PATH%\%OUT_MERGE_FILE%
rem	echo -- �ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ� -- >> %FILE_PATH%\%OUT_MERGE_FILE%
rem	echo -- %%a -- >> %FILE_PATH%\%OUT_MERGE_FILE%
rem	echo. >> %FILE_PATH%\%OUT_MERGE_FILE%
	type "%%a" >> %FILE_PATH%\%OUT_MERGE_FILE%
rem	echo. >> %FILE_PATH%\%OUT_MERGE_FILE%
rem	echo GO >> %FILE_PATH%\%OUT_MERGE_FILE%

rem	for /f "delims=." %%b in ("%%~nxa") do (
rem		SET DBNAME=%%b
rem	)
)

rem echo USE [%DBNAME%] >> %FILE_PATH%\%OUT_HIST_FILE%
rem echo INSERT INTO dbo.tPatchHistory (SQLFileName^) VALUES >> %FILE_PATH%\%OUT_HIST_FILE%
rem for /f "tokens=*" %%a in ('dir /b /on "*.sql"') do (
rem 	echo ,(N'%%a'^) >> %FILE_PATH%\%OUT_HIST_FILE%
rem )

echo.
echo.
goto Step_Success


REM ==================================================================
:Step_Success
echo.
echo Merge �۾��� �Ϸ� �Ǿ����ϴ�.
echo.
echo %OUT_MERGE_FILE%, %OUT_HIST_FILE%
echo �ΰ��� ������ Ȯ���Ͻð� DB ��ġ �ϼ���.
echo.
color 27
pause
ECHO.

:Step_Exit
if "%1"==""

