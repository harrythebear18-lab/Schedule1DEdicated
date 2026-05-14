# BisectHosting Server Setup

Quick setup guide for deploying Schedule One dedicated server on BisectHosting.

## 🚀 Quick Setup

### 1. Download Server Files
Download all files from the `server_files/` directory to your BisectHosting server.

### 2. Run Setup Script
```bash
./BisectHosting/setup_server.bat
```

### 3. Install Required Components
The setup script will guide you through:
- MelonLoader v0.7.0 installation (manual)
- Schedule I game files (manual copy from Steam)
- DedicatedServerMod configuration

### 4. Start Server
```bash
./start.bat
```

## 📋 Required Files

### Game Files (Manual Copy)
From your Steam installation:
```
SteamLibrary/steamapps/common/Schedule I/
├── Schedule I.exe
├── UnityPlayer.dll
├── GameAssembly.dll
└── Schedule I_Data/ (entire folder)
```

### Mod Files (Auto-copied)
```
DedicatedServerMod_Mono_Server.dll → Schedule I/Mods/
```

### Configuration Files (Auto-copied)
```
server_files/UserData/ → Schedule I/UserData/
├── server_config.toml
├── permissions.toml
└── client_mod_policy.toml
```

## 🔧 Server Configuration

### Default Settings
- **Server Name:** Thompsons Trips
- **Port:** 38465
- **Password:** WeeD1997
- **Max Players:** 16
- **RAM:** 16GB allocated

### Player Access
- **htsoundtech:** Operator (admin)
- **guy:** Player
- **Autx554:** Player

## 🌐 Network Setup

### Port Forwarding
Ensure port 38465 is open:
- **TCP:** 38465
- **UDP:** 38465

### Firewall Rules
Allow inbound connections on port 38465 for Schedule I.

## 📊 Performance

### Resource Requirements
- **RAM:** 16GB allocated
- **CPU:** 2+ cores recommended
- **Storage:** 10GB+ free space
- **Network:** Stable connection

### Monitoring
Check server status with:
```bash
# Check if server is running
netstat -an | grep 38465

# Check memory usage
ps aux | grep Schedule I
```

## 🔒 Security

### Authentication
- **Steam Name:** Whitelisted players only
- **Password:** Required for all connections
- **Mod Verification:** Disabled (simpler setup)

### Access Control
Edit `UserData/permissions.toml` to add/remove players:
```toml
[player."NewPlayer"]
priority = 10
inherits = ['default']
```

## 🛠️ Maintenance

### Daily Tasks
- Check server status
- Monitor player connections
- Review error logs

### Weekly Tasks
- Create save backups
- Update player permissions
- Check performance metrics

### Backup Script
```bash
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
tar -czf "backup_$DATE.tar.gz" Schedule I/UserData/DedicatedServerSave/
```

## 🐛 Troubleshooting

### Server Won't Start
1. Check all game files are present
2. Verify MelonLoader installation
3. Check server_config.toml syntax

### Players Can't Connect
1. Verify port 38465 is open
2. Check password is correct
3. Verify player Steam names in permissions

### Save Data Issues
1. Check UserData/DedicatedServerSave/ exists
2. Verify save file permissions
3. Check disk space

## 📞 Support

For BisectHosting-specific issues:
1. Check BisectHosting control panel
2. Review server logs
3. Contact BisectHosting support

For server configuration issues:
1. Review configuration files
2. Check documentation
3. Verify file permissions

---

**Server Ready for BisectHosting Deployment!**
