@echo off
echo Setting up Schedule One Dedicated Server for BisectHosting...
echo.

REM Create server directory structure
if not exist "Schedule I" mkdir "Schedule I"
if not exist "Schedule I\Mods" mkdir "Schedule I\Mods"
if not exist "Schedule I\UserData" mkdir "Schedule I\UserData"

REM Copy server files
echo Copying server files...
copy "start_server.bat" "Schedule I\"
copy "doorstop_config.ini" "Schedule I\"
xcopy "UserData\*" "Schedule I\UserData\" /E /I /Y

REM Download and install MelonLoader (manual step required)
echo.
echo IMPORTANT: You must manually install MelonLoader v0.7.0
echo 1. Download MelonLoader v0.7.0 from official releases
echo 2. Run installer targeting Schedule I\Schedule I.exe
echo 3. Select Mono runtime
echo.

REM Copy DedicatedServerMod
echo Copying DedicatedServerMod...
if exist "DedicatedServerMod_Mono_Server.dll" (
    copy "DedicatedServerMod_Mono_Server.dll" "Schedule I\Mods\"
    echo DedicatedServerMod copied successfully!
) else (
    echo WARNING: DedicatedServerMod_Mono_Server.dll not found
    echo Please copy the built server mod to Schedule I\Mods\
)

REM Copy game files (manual step required)
echo.
echo IMPORTANT: You must manually copy Schedule I game files
echo From: Steam installation (usually SteamLibrary\steamapps\common\Schedule I\)
echo To: This Schedule I folder
echo Required files:
echo   - Schedule I.exe
echo   - UnityPlayer.dll
echo   - GameAssembly.dll
echo   - Schedule I_Data\ (entire folder)
echo.

REM Create startup script
echo Creating startup script...
echo @echo off > "start.bat"
echo cd /d "%%~dp0" >> "start.bat"
echo cd Schedule I >> "start.bat"
echo start "" "start_server.bat" >> "start.bat"

echo.
echo Setup complete!
echo Next steps:
echo 1. Install MelonLoader v0.7.0 manually
echo 2. Copy Schedule I game files manually
echo 3. Run start.bat to launch the server
echo.
echo Server will be available on port 38465
echo Password: WeeD1997
echo.
pause
