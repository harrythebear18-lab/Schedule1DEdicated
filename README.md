# ScheduleOne Dedicated Server

A comprehensive, production-ready dedicated server setup for Schedule I (Schedule One) with Thompsons Trips save data, optimized for multiplayer gameplay.

## 🎯 Overview

This repository contains the complete configuration and documentation for running a stable Schedule I dedicated server with:
- **Thompsons Trips** save game data loaded
- **16GB RAM allocation** for optimal performance
- **Steam name-based authentication** (no API requirements)
- **Password protection** for security
- **Multiplayer support** for up to 16 players
- **Clean, optimized configuration**

## 📋 Server Specifications

### 🖥️ Hardware Requirements
- **RAM:** 16GB allocated (configurable)
- **Storage:** E:\ThompsonTrips-Server\ (recommended)
- **Network:** Port 38465 (UDP/TCP)

### ⚙️ Server Configuration
- **Server Name:** Thompsons Trips
- **Port:** 38465
- **Max Players:** 16
- **Password:** WeeD1997
- **Authentication:** Steam name-based
- **Save Data:** SaveGame_3 (Thompsons Trips)

### 👥 Authorized Players
| Steam Name | Role | Permissions |
|------------|------|-------------|
| htsoundtech | Operator | Full admin access |
| guy | Player | Basic gameplay access |
| Autx554 | Player | Basic gameplay access |

## 🚀 Quick Start

### Prerequisites
1. **Schedule I Game Files** (from Steam installation)
2. **MelonLoader v0.7.0** (for mod support)
3. **DedicatedServerMod** (built server mod)

### Installation Steps

1. **Create Server Directory:**
   ```bash
   mkdir E:\ThompsonTrips-Server
   ```

2. **Copy Game Files:**
   ```bash
   # From: F:\SteamLibrary\steamapps\common\Schedule I\
   # To: E:\ThompsonTrips-Server\
   copy "Schedule I.exe"
   copy "UnityPlayer.dll"
   copy "GameAssembly.dll"
   xcopy "Schedule I_Data" "E:\ThompsonTrips-Server\Schedule I_Data\" /E /I
   ```

3. **Install MelonLoader v0.7.0:**
   - Download MelonLoader v0.7.0
   - Extract to E:\ThompsonTrips-Server\
   - Run installer targeting Schedule I.exe

4. **Copy Server Mod:**
   ```bash
   # From: S1DS-Source\Mono-Server\
   # To: E:\ThompsonTrips-Server\
   copy "DedicatedServerMod_Mono_Server.dll" "E:\ThompsonTrips-Server\Mods\"
   copy "start_server.bat" "E:\ThompsonTrips-Server\"
   ```

5. **Start Server:**
   ```bash
   cd E:\ThompsonTrips-Server
   start_server.bat
   ```

## 📁 Server Structure

```
E:\ThompsonTrips-Server\
├── Schedule I.exe                 # Main game executable
├── UnityPlayer.dll               # Unity engine
├── GameAssembly.dll              # Game assembly
├── Schedule I_Data/              # Game data folder
├── Mods/                         # Mod directory
│   └── DedicatedServerMod_Mono_Server.dll
├── start_server.bat              # Server launcher
├── UserData/                     # Server data
│   ├── DedicatedServerSave/      # Save game data
│   │   ├── Businesses/          # Business data
│   │   ├── Properties/          # Property ownership
│   │   ├── Players/             # Player data
│   │   └── *.json               # Game state files
│   ├── server_config.toml        # Server configuration
│   ├── permissions.toml          # Player permissions
│   └── client_mod_policy.toml    # Mod policy
└── MelonLoader/                  # Mod loader
```

## ⚙️ Configuration Files

### server_config.toml
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

[performance]
targetFrameRate = 60
vSyncCount = 0
```

### permissions.toml
```toml
[player."htsoundtech"]
priority = 50
inherits = ['operator']

[player."guy"]
priority = 10
inherits = ['default']

[player."Autx554"]
priority = 10
inherits = ['default']
```

### start_server.bat
```bat
@echo off
cd /d "%~dp0"
start "" "Schedule I.exe" --batchmode --nographics --dedicated-server -memory-alloc-size 16384
```

## 🔧 Configuration Details

### Authentication System
- **Method:** Steam name-based (no Steam API required)
- **Password:** Required for all connections
- **Timeout:** 60 seconds (forgiving for slow connections)
- **Mod Verification:** Disabled (simpler connections)

### Performance Optimizations
- **RAM Allocation:** 16GB fixed allocation
- **Frame Rate:** 60 FPS target
- **VSync:** Disabled (headless server)
- **Auto-save:** Every 15 minutes

### Save Game Data
- **Source:** Thompsons Trips SaveGame_3
- **Location:** UserData/DedicatedServerSave/
- **Format:** JSON-based save files
- **Includes:** Properties, businesses, NPCs, quests, player data

## 📊 Performance Metrics

### Memory Usage
- **Allocated:** 16GB RAM
- **Typical Usage:** ~7-8GB
- **Virtual Memory:** ~293GB (Unity normal)

### Network Performance
- **Port:** 38465 (UDP/TCP)
- **Protocol:** FishNet networking
- **Max Players:** 16 concurrent connections
- **Authentication:** Steam name + password

## 🛠️ Maintenance

### Server Management
- **Start:** Run `start_server.bat`
- **Stop:** Ctrl+C in server console
- **Restart:** Stop and start again
- **Logs:** Check console output for issues

### Save Management
- **Auto-save:** Every 15 minutes
- **Manual Save:** Use admin commands
- **Backup:** Copy UserData/DedicatedServerSave/
- **Restore:** Replace save files and restart

### Player Management
- **Add Players:** Update permissions.toml
- **Remove Players:** Remove from permissions.toml
- **Change Roles:** Modify inherits field
- **Password Changes:** Update server_config.toml

## 🔒 Security

### Access Control
- **Password Protection:** "WeeD1997" required
- **Steam Name Whitelist:** Only authorized players
- **Role-Based Access:** Operator vs Player permissions
- **Mod Verification:** Disabled (reduces complexity)

### Network Security
- **Port Configuration:** 38465 only
- **Firewall:** Allow inbound connections on port 38465
- **Steam API:** Not required (reduces attack surface)

## 🐛 Troubleshooting

### Common Issues

#### Authentication Timeouts
- **Cause:** Steam API issues
- **Fix:** Authentication disabled, use Steam names only

#### Connection Refused
- **Cause:** Wrong password or not whitelisted
- **Fix:** Check password and permissions.toml

#### Save Data Not Loading
- **Cause:** Incorrect save path
- **Fix:** Verify UserData/DedicatedServerSave/ contains save files

#### Performance Issues
- **Cause:** Insufficient RAM
- **Fix:** Increase -memory-alloc-size in start_server.bat

### Debug Commands
```bash
# Check server status
netstat -an | findstr 38465

# Check memory usage
Get-Process -Name "Schedule I" | Select-Object ProcessName, @{Name="RAM(MB)";Expression={[math]::Round($_.WorkingSet64 / 1MB, 2)}}

# Check save files
dir E:\ThompsonTrips-Server\UserData\DedicatedServerSave\
```

## 📚 Documentation Structure

This repository includes:
- **README.md:** Main documentation (this file)
- **SETUP.md:** Detailed installation guide
- **CONFIGURATION.md:** Configuration reference
- **TROUBLESHOOTING.md:** Common issues and solutions
- **PERFORMANCE.md:** Performance tuning guide

## 🤝 Contributing

### Server Updates
1. Test changes in development environment
2. Update configuration files
3. Update documentation
4. Test with real players
5. Deploy to production

### Save Game Updates
1. Backup current save
2. Test new save data
3. Replace UserData/DedicatedServerSave/
4. Restart server
5. Verify player access

## 📄 License

This configuration is provided as-is for educational and personal use. Schedule I is owned by its respective developers.

## 📞 Support

For issues with this server configuration:
1. Check troubleshooting section
2. Verify all files are in correct locations
3. Test with minimal configuration
4. Check game and mod compatibility

---

**Server Status:** ✅ Running Stable  
**Last Updated:** May 14, 2026  
**Version:** 1.0.0  
**Save Game:** Thompsons Trips SaveGame_3
