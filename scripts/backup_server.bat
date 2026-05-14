@echo off
echo Creating backup of Schedule One dedicated server...
echo.

REM Set variables
set SERVER_DIR=E:\ThompsonTrips-Server
set BACKUP_DIR=E:\ThompsonTrips-Server\Backups
set TIMESTAMP=%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%
set TIMESTAMP=%TIMESTAMP: =0%

REM Create backup directory if it doesn't exist
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

REM Create backup folder for this timestamp
set CURRENT_BACKUP=%BACKUP_DIR%\backup_%TIMESTAMP%
mkdir "%CURRENT_BACKUP%"

echo Backup folder: %CURRENT_BACKUP%

REM Backup save data
echo Backing up save data...
xcopy "%SERVER_DIR%\UserData\DedicatedServerSave\*" "%CURRENT_BACKUP%\DedicatedServerSave\" /E /I /Y

REM Backup configuration files
echo Backing up configuration...
xcopy "%SERVER_DIR%\UserData\*.toml" "%CURRENT_BACKUP%\Configuration\" /Y

REM Backup mods
echo Backing up mods...
xcopy "%SERVER_DIR%\Mods\*" "%CURRENT_BACKUP%\Mods\" /E /I /Y

REM Create backup info file
echo Creating backup info...
echo Backup created: %date% %time% > "%CURRENT_BACKUP%\backup_info.txt"
echo Server: Schedule One - Thompsons Trips >> "%CURRENT_BACKUP%\backup_info.txt"
echo Save Game: SaveGame_3 >> "%CURRENT_BACKUP%\backup_info.txt"
echo Players: htsoundtech, guy, Autx554 >> "%CURRENT_BACKUP%\backup_info.txt"

REM Clean up old backups (keep last 10)
echo Cleaning up old backups...
for /f "skip=10 delims=" %%d in ('dir /b /ad /o-d "%BACKUP_DIR%\backup_*"') do rd /s /q "%BACKUP_DIR%\%%d"

echo.
echo Backup completed successfully!
echo Location: %CURRENT_BACKUP%
echo.
pause
