# Server Replication Guide

Complete guide to replicate the Thompsons Trips dedicated server setup exactly as configured.

## 🎯 Overview

This guide allows you to create an identical Schedule One dedicated server with:
- **Thompsons Trips** save game data
- **16GB RAM allocation**
- **Steam name authentication**
- **Password protection**
- **BisectHosting compatibility**

## 🚀 Quick Replication

### Method 1: BisectHosting (Recommended)
1. Download all files from the GitHub repository
2. Upload to your BisectHosting server
3. Run `BisectHosting/setup_server.bat`
4. Install MelonLoader v0.7.0 (manual)
5. Copy Schedule I game files (manual)
6. Start server with `start.bat`

### Method 2: Local Setup
1. Create server directory: `E:\ThompsonTrips-Server`
2. Copy all files from `server_files/` to your server directory
3. Follow the manual setup steps below

## 📋 Exact Configuration

### Server Settings
```toml
[server]
serverName = "Thompsons Trips"
serverPort = 38465
maxPlayers = 16
serverPassword = "WeeD1997"
```

### Authentication
```toml
[authentication]
authProvider = "None"
authTimeoutSeconds = 60
modVerificationEnabled = false
```

### Performance
```toml
[performance]
targetFrameRate = 60
vSyncCount = 0
```

### Memory Allocation
```bat
start "" "Schedule I.exe" --batchmode --nographics --dedicated-server -memory-alloc-size 16384
```

## 👥 Player Access

### Authorized Players
| Steam Name | Role | Permissions |
|------------|------|-------------|
| htsoundtech | Operator | Full admin access |
| guy | Player | Basic gameplay access |
| Autx554 | Player | Basic gameplay access |

### Adding New Players
Edit `UserData/permissions.toml`:
```toml
[player."NewPlayerName"]
priority = 10
inherits = ['default']
allow = []
deny = []
```

## 🎮 Save Game Data

### Thompsons Trips SaveGame_3
The server is configured to use SaveGame_3 data. To replicate:

1. **Copy Save Files:**
   ```bash
   xcopy "path\to\SaveGame_3\*" "E:\ThompsonTrips-Server\UserData\DedicatedServerSave\" /E /I /Y
   ```

2. **Verify Save Structure:**
   ```
   UserData/DedicatedServerSave/
   ├── Game.json
   ├── Metadata.json
   ├── Businesses/
   ├── Properties/
   ├── Players/
   └── NPCs.json
   ```

3. **Update Server Name (Optional):**
   Edit `UserData/server_config.toml`:
   ```toml
   serverName = "Your Server Name"
   ```

## 🔧 Manual Setup Steps

### 1. Create Server Directory
```bash
mkdir E:\ThompsonTrips-Server
cd E:\ThompsonTrips-Server
```

### 2. Copy Game Files
From your Schedule I Steam installation:
```bash
# Core files
copy "F:\SteamLibrary\steamapps\common\Schedule I\Schedule I.exe"
copy "F:\SteamLibrary\steamapps\common\Schedule I\UnityPlayer.dll"
copy "F:\SteamLibrary\steamapps\common\Schedule I\GameAssembly.dll"

# Game data
xcopy "F:\SteamLibrary\steamapps\common\Schedule I\Schedule I_Data" "Schedule I_Data\" /E /I
```

### 3. Install MelonLoader v0.7.0
- Download MelonLoader v0.7.0
- Run installer targeting `Schedule I.exe`
- Select Mono runtime

### 4. Copy Server Mod
```bash
mkdir Mods
copy "DedicatedServerMod_Mono_Server.dll" "Mods\"
```

### 5. Copy Configuration Files
From the repository:
```bash
# Server configuration
copy "server_files\UserData\*.toml" "UserData\"

# Doorstop config
copy "server_files\doorstop_config.ini"

# Startup script
copy "server_files\start_server.bat"
```

### 6. Setup Save Data
```bash
mkdir UserData\DedicatedServerSave
# Copy your SaveGame_3 data here
```

## 🌐 Network Configuration

### Port Settings
- **Port:** 38465
- **Protocol:** TCP/UDP
- **Password:** WeeD1997

### Firewall Rules
```bash
# Windows Firewall (admin)
netsh advfirewall firewall add rule name="Schedule One Server" dir=in action=allow protocol=TCP localport=38465
netsh advfirewall firewall add rule name="Schedule One Server UDP" dir=in action=allow protocol=UDP localport=38465
```

### Router Port Forwarding
Forward port 38465 to your server machine's IP address.

## 📊 Performance Tuning

### Memory Options
Edit `start_server.bat`:
```bat
# 8GB RAM
-memory-alloc-size 8192

# 16GB RAM (recommended)
-memory-alloc-size 16384

# 32GB RAM (large servers)
-memory-alloc-size 32768
```

### Player Limits
Edit `UserData/server_config.toml`:
```toml
maxPlayers = 16  # Adjust as needed
```

### Auto-save Settings
```toml
[autosave]
autoSaveEnabled = true
autoSaveIntervalMinutes = 15.0  # Adjust frequency
autoSaveOnPlayerJoin = true
autoSaveOnPlayerLeave = true
```

## 🔒 Security Configuration

### Password Protection
```toml
serverPassword = "YourSecurePassword"
```

### Authentication Options
```toml
# None (Steam name only)
authProvider = "None"

# Steam API (requires Steam)
authProvider = "SteamGameServer"

# Steam Web API (requires API key)
authProvider = "SteamWebApi"
```

### Mod Verification
```toml
# Disabled (simpler)
modVerificationEnabled = false

# Enabled (more secure)
modVerificationEnabled = true
modVerificationTimeoutSeconds = 45
```

## 🛠️ Maintenance Scripts

### Backup Script
Use `scripts/backup_server.bat`:
```bash
# Creates timestamped backups
# Keeps last 10 backups
# Includes save data and configuration
```

### Monitor Script
Use `scripts/monitor_server.bat`:
```bash
# Checks server status
# Monitors memory usage
# Verifies network ports
# Checks save data integrity
```

## 🐛 Troubleshooting

### Common Issues

#### Server Won't Start
1. Verify all game files are present
2. Check MelonLoader installation
3. Validate configuration file syntax

#### Players Can't Connect
1. Check port 38465 is open
2. Verify password is correct
3. Confirm player Steam names in permissions

#### Save Data Not Loading
1. Check UserData/DedicatedServerSave/ exists
2. Verify save file permissions
3. Ensure save data is complete

#### Performance Issues
1. Increase RAM allocation
2. Reduce max players
3. Check system resources

### Debug Commands
```bash
# Check server process
tasklist | find "Schedule I"

# Check network ports
netstat -an | findstr 38465

# Check memory usage
wmic process where "name='Schedule I.exe'" get WorkingSetSize

# Verify configuration
Get-Content "UserData\server_config.toml" | Select-String "serverName|serverPort"
```

## 📝 Customization Guide

### Change Server Name
Edit `UserData/server_config.toml`:
```toml
serverName = "Your Custom Server Name"
```

### Modify Password
```toml
serverPassword = "YourNewPassword"
```

### Adjust Player Limit
```toml
maxPlayers = 8  # Reduce for performance
```

### Change Port
```toml
serverPort = 7777  # Update firewall rules
```

### Add Admin Commands
Edit `UserData/permissions.toml`:
```toml
[player."AdminName"]
priority = 50
inherits = ['operator']
```

## 🔄 Updates and Maintenance

### Updating Server
1. Stop server
2. Backup save data
3. Update game files
4. Update mods
5. Restart server

### Migrating Save Data
1. Export current save
2. Copy to new server
3. Update permissions
4. Test with players

### Scaling Up
1. Increase RAM allocation
2. Optimize configuration
3. Consider load balancing
4. Monitor performance metrics

## 📞 Support Resources

### Documentation
- **README.md:** Complete overview
- **SETUP.md:** Detailed installation
- **CONFIGURATION.md:** All settings reference

### Community
- GitHub Issues: Report bugs and request features
- Server Forums: Community support and discussions

### Professional Support
- BisectHosting: Managed server hosting
- Discord: Real-time community help

---

## ✅ Replication Checklist

### Pre-Setup
- [ ] Download repository files
- [ ] Choose hosting method (BisectHosting/Local)
- [ ] Prepare Schedule I game files
- [ ] Get MelonLoader v0.7.0

### Setup
- [ ] Create server directory
- [ ] Copy game files
- [ ] Install MelonLoader
- [ ] Copy server mod
- [ ] Copy configuration files
- [ ] Setup save data
- [ ] Configure network

### Testing
- [ ] Start server successfully
- [ ] Verify port 38465 is listening
- [ ] Test player connections
- [ ] Verify save data loads
- [ ] Test admin commands

### Final
- [ ] Update server name (optional)
- [ ] Add custom players
- [ ] Setup backup scripts
- [ ] Document custom changes

**Your Thompsons Trips dedicated server is now ready for replication!**

---

*This guide creates an exact replica of the production Thompsons Trips server configuration.*
