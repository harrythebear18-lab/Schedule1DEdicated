# Server Setup Guide

Complete step-by-step instructions for setting up the Schedule One dedicated server.

## 🎯 Prerequisites

### Required Software
- **Schedule I** (Steam game)
- **MelonLoader v0.7.0** (mod loader)
- **DedicatedServerMod** (server mod)

### Required Hardware
- **RAM:** 16GB recommended
- **Storage:** 10GB free space
- **Network:** Stable internet connection

## 📁 Directory Structure Setup

### 1. Create Server Directory
```powershell
mkdir E:\ThompsonTrips-Server
cd E:\ThompsonTrips-Server
```

### 2. Copy Game Files
From your Schedule I Steam installation (typically `F:\SteamLibrary\steamapps\common\Schedule I\`):

```powershell
# Copy core game files
copy "F:\SteamLibrary\steamapps\common\Schedule I\Schedule I.exe" "E:\ThompsonTrips-Server\"
copy "F:\SteamLibrary\steamapps\common\Schedule I\UnityPlayer.dll" "E:\ThompsonTrips-Server\"
copy "F:\SteamLibrary\steamapps\common\Schedule I\GameAssembly.dll" "E:\ThompsonTrips-Server\"

# Copy game data folder
xcopy "F:\SteamLibrary\steamapps\common\Schedule I\Schedule I_Data" "E:\ThompsonTrips-Server\Schedule I_Data\" /E /I
```

## 🔧 MelonLoader Installation

### 1. Download MelonLoader v0.7.0
- Visit the official MelonLoader releases
- Download version 0.7.0
- Extract to temporary folder

### 2. Install MelonLoader
```powershell
# Navigate to server directory
cd E:\ThompsonTrips-Server

# Run MelonLoader installer
# Target: Schedule I.exe
# Version: 0.7.0
# Select "Mono" runtime
```

### 3. Verify Installation
Check for these files:
```
E:\ThompsonTrips-Server\
├── MelonLoader\
├── doorstop_config.ini
├── version.dll
└── melonloader.dll
```

## 📦 Server Mod Installation

### 1. Copy DedicatedServerMod
From your built mod files (`S1DS-Source\Mono-Server\`):

```powershell
# Create Mods directory
mkdir E:\ThompsonTrips-Server\Mods

# Copy server mod DLL
copy "S1DS-Source\Mono-Server\DedicatedServerMod_Mono_Server.dll" "E:\ThompsonTrips-Server\Mods\"

# Copy launcher script
copy "S1DS-Source\Mono-Server\start_server.bat" "E:\ThompsonTrips-Server\"
```

### 2. Update start_server.bat
Edit `E:\ThompsonTrips-Server\start_server.bat`:
```bat
@echo off
cd /d "%~dp0"
start "" "Schedule I.exe" --batchmode --nographics --dedicated-server -memory-alloc-size 16384
```

## 🎮 Save Game Setup

### 1. Prepare Save Data
From your existing save (typically `C:\Users\htsou\Desktop\Thompsons Trips\SaveGame_3\`):

```powershell
# Create server save directory
mkdir E:\ThompsonTrips-Server\UserData\DedicatedServerSave

# Copy save data
xcopy "C:\Users\htsou\Desktop\Thompsons Trips\SaveGame_3\*" "E:\ThompsonTrips-Server\UserData\DedicatedServerSave\" /E /I /Y
```

### 2. Verify Save Data
Check for these key files:
```
E:\ThompsonTrips-Server\UserData\DedicatedServerSave\
├── Game.json
├── Metadata.json
├── Businesses\
├── Properties\
├── Players\
└── NPCs.json
```

## ⚙️ Server Configuration

### 1. Create server_config.toml
Create `E:\ThompsonTrips-Server\UserData\server_config.toml`:

```toml
[server]
serverName = "Thompsons Trips"
serverPort = 38465
maxPlayers = 16
serverPassword = "WeeD1997"

[authentication]
authProvider = "None"
authTimeoutSeconds = 60
modVerificationEnabled = false
modVerificationTimeoutSeconds = 45

[performance]
targetFrameRate = 60
vSyncCount = 0

[autosave]
autoSaveEnabled = true
autoSaveIntervalMinutes = 15.0
autoSaveOnPlayerJoin = true
autoSaveOnPlayerLeave = true
```

### 2. Create permissions.toml
Create `E:\ThompsonTrips-Server\UserData\permissions.toml`:

```toml
[metadata]
schemaVersion = 1
migrationVersion = 1
migratedFrom = 'default'
migratedAtUtc = '2026-05-14T20:36:32.1702108Z'

[group.default]
priority = 0
inherits = []
allow = ['server.help']
deny = []

[group.operator]
priority = 40
inherits = ['administrator']
allow = ['clientmods.policy.bypass', 'console.command.*', 'console.open', 'permissions.deny', 'permissions.grant', 'permissions.group.assign', 'permissions.group.unassign', 'permissions.reload', 'permissions.revoke', 'permissions.tempgrant', 'server.stop']
deny = []

[player."htsoundtech"]
priority = 50
inherits = ['operator']
allow = []
deny = []

[player."guy"]
priority = 10
inherits = ['default']
allow = []
deny = []

[player."Autx554"]
priority = 10
inherits = ['default']
allow = []
deny = []
```

## 🚀 First Server Start

### 1. Start the Server
```powershell
cd E:\ThompsonTrips-Server
start_server.bat
```

### 2. Verify Server Status
Check console output for:
```
=== DEDICATED SERVER ONLINE ===
Server Name: Thompsons Trips
Port: 38465
Max Players: 16
=== DEDICATED SERVER READY ===
```

### 3. Test Network Connectivity
```powershell
netstat -an | findstr 38465
```

Should show:
```
TCP    0.0.0.0:38465          0.0.0.0:0              LISTENING
UDP    0.0.0.0:38465          *:*
```

## 👥 Player Connection Guide

### For Players
1. **Open Schedule I**
2. **Multiplayer → Join Server**
3. **Server IP:** [Your server's IP]
4. **Port:** 38465
5. **Password:** WeeD1997
6. **Steam Name:** Must match whitelist

### Server IP Finding
```powershell
# Public IP
curl ifconfig.me

# Local IP (for LAN)
ipconfig
```

## 🔧 Post-Setup Configuration

### 1. Firewall Configuration
Allow inbound connections on port 38465:
- **Windows Defender:** Create inbound rule
- **Router:** Port forward 38465 to server machine

### 2. Performance Monitoring
```powershell
# Check RAM usage
Get-Process -Name "Schedule I" | Select-Object ProcessName, @{Name="RAM(MB)";Expression={[math]::Round($_.WorkingSet64 / 1MB, 2)}}

# Check server status
netstat -an | findstr 38465
```

### 3. Backup Configuration
```powershell
# Create backup script
@echo off
echo Creating backup...
xcopy "E:\ThompsonTrips-Server\UserData\DedicatedServerSave\*" "E:\ThompsonTrips-Server\Backups\%date%_%time::=._%" /E /I /Y
echo Backup complete!
```

## 🐛 Common Setup Issues

### MelonLoader Installation Fails
- **Solution:** Ensure you're using v0.7.0, not newer versions
- **Check:** Game files are not read-only
- **Verify:** Running as administrator

### Server Won't Start
- **Check:** All game files are present
- **Verify:** MelonLoader installed correctly
- **Solution:** Reinstall MelonLoader

### Players Can't Connect
- **Check:** Firewall allows port 38465
- **Verify:** Password is correct
- **Solution:** Check player Steam names match permissions

### Save Data Not Loading
- **Check:** UserData/DedicatedServerSave/ exists
- **Verify:** Save files are complete
- **Solution:** Re-copy save data from original

## 📊 Verification Checklist

### Pre-Launch Checklist
- [ ] Game files copied correctly
- [ ] MelonLoader v0.7.0 installed
- [ ] Server mod copied to Mods/
- [ ] Save data in UserData/DedicatedServerSave/
- [ ] server_config.toml configured
- [ ] permissions.toml configured
- [ ] Firewall allows port 38465
- [ ] start_server.bat updated with 16GB RAM

### Post-Launch Checklist
- [ ] Server starts without errors
- [ ] Console shows "DEDICATED SERVER ONLINE"
- [ ] Port 38465 is listening
- [ ] Save data loads correctly
- [ ] Players can connect with password
- [ ] Steam name authentication works
- [ ] Auto-save is functioning

## 🔄 Maintenance Schedule

### Daily
- Check server status
- Monitor player connections
- Review error logs

### Weekly
- Create save backups
- Update player permissions if needed
- Check performance metrics

### Monthly
- Update server configuration
- Clean up old backups
- Review security settings

---

**Setup Complete!** Your Schedule One dedicated server should now be running with Thompsons Trips save data and ready for multiplayer gameplay.
