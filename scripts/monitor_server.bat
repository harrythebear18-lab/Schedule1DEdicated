@echo off
echo Schedule One Server Monitor
echo ========================
echo.

REM Set server directory
set SERVER_DIR=E:\ThompsonTrips-Server

REM Check if server is running
echo Checking server status...
tasklist | find "Schedule I.exe" >nul
if %errorlevel% equ 0 (
    echo [RUNNING] Schedule I server process is active
) else (
    echo [STOPPED] Schedule I server process is not running
)

REM Check port 38465
echo.
echo Checking network port 38465...
netstat -an | findstr 38465 >nul
if %errorlevel% equ 0 (
    echo [LISTENING] Port 38465 is active
    netstat -an | findstr 38465
) else (
    echo [CLOSED] Port 38465 is not listening
)

REM Check memory usage
echo.
echo Checking memory usage...
for /f "tokens=5" %%a in ('tasklist /fi "imagename eq Schedule I.exe" /fo table ^| find "Schedule I.exe"') do (
    set MEMORY=%%a
)
if defined MEMORY (
    echo [MEMORY] Schedule I.exe is using %MEMORY% K
) else (
    echo [MEMORY] Server process not found
)

REM Check save data
echo.
echo Checking save data...
if exist "%SERVER_DIR%\UserData\DedicatedServerSave\Game.json" (
    echo [SAVE] Save data found and accessible
) else (
    echo [SAVE] No save data found
)

REM Check configuration files
echo.
echo Checking configuration...
if exist "%SERVER_DIR%\UserData\server_config.toml" (
    echo [CONFIG] server_config.toml found
) else (
    echo [CONFIG] server_config.toml missing
)

if exist "%SERVER_DIR%\UserData\permissions.toml" (
    echo [CONFIG] permissions.toml found
) else (
    echo [CONFIG] permissions.toml missing
)

REM Check recent logs
echo.
echo Checking for recent activity...
if exist "%SERVER_DIR%\UserData\Logs\" (
    echo [LOGS] Log directory exists
    dir "%SERVER_DIR%\UserData\Logs\" /b /o-d | findstr /n "^"
) else (
    echo [LOGS] No log directory found
)

REM Display server info
echo.
echo Server Information:
echo - Directory: %SERVER_DIR%
echo - Port: 38465
echo - Password: WeeD1997
echo - Max Players: 16
echo - Authorized Players: htsoundtech, guy, Autx554
echo.

pause
