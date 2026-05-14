# Configuration Reference

Complete reference for all configuration files and settings used by the Schedule One dedicated server.

## 📁 Configuration Files Location

```
E:\ThompsonTrips-Server\UserData\
├── server_config.toml        # Main server configuration
├── permissions.toml          # Player permissions
└── client_mod_policy.toml    # Client mod policy
```

## ⚙️ server_config.toml

### Complete Configuration
```toml
# DedicatedServerMod server configuration
# This file is grouped and commented for easier editing
# Command-line arguments still override these values at runtime

# Core server identity and connection settings
[server]
# Public server name shown in server browsers
serverName = 'Thompsons Trips'

# Short description displayed to players
serverDescription = 'A dedicated server for Schedule One'

# Maximum number of simultaneous players
maxPlayers = 16

# Game server port to listen on
serverPort = 38465

# Connection password. Leave empty to disable
serverPassword = 'WeeD1997'

# Dedicated server authentication and client mod verification
[authentication]
# Authentication provider: 'None', 'SteamGameServer', or 'SteamWebApi'
authProvider = 'None'

# Authentication handshake timeout in seconds
authTimeoutSeconds = 60

# Allow the local loopback host connection to bypass authentication
authAllowLoopbackBypass = true

# Require the dedicated client mod verification handshake
modVerificationEnabled = false

# Client mod verification timeout in seconds
modVerificationTimeoutSeconds = 45

# Reject known risky client-only mods even when unpaired mods are allowed
blockKnownRiskyClientMods = true

# Allow client-only mods that do not have a paired server mod
allowUnpairedClientMods = true

# Require strict hash pinning for approved client mods
strictClientModMode = false

# Use anonymous Steam game server login. Disable to use a server token
steamGameServerLogOnAnonymous = true

# Steam game server login token used when anonymous login is disabled
steamGameServerToken = ''

# Steam query/status port
steamGameServerQueryPort = 27016

# Steam game server mode: 'NoAuthentication', 'Authentication', or 'AuthenticationAndSecure'
steamGameServerMode = 'NoAuthentication'

# Steam Web API key for SteamWebApi auth mode
steamWebApiKey = ''

# Optional Steam Web API identity string
steamWebApiIdentity = 'DedicatedServerMod'

# Custom server-client messaging backend selection
[messaging]
# Messaging backend: 'FishNetRpc' or 'SteamNetworkingSockets'
messagingBackend = 'FishNetRpc'

# Steam Networking Sockets virtual port used for peer routing
steamNetworkingSocketsVirtualPort = 0

# Maximum Steam Networking Sockets payload size in bytes
steamNetworkingSocketsMaxPayloadBytes = 1200

# Optional target server SteamID for client-side Steam Networking Sockets routing
steamNetworkingSocketsServerSteamId = ''

# Remote and local host console controls
[tcpConsole]
# Enable the TCP admin console
tcpConsoleEnabled = false

# Bind address for the TCP console. Use '127.0.0.1' for local-only access
tcpConsoleBindAddress = '127.0.0.1'

# TCP console port
tcpConsolePort = 4050

# Maximum concurrent TCP console clients
tcpConsoleMaxConnections = 3

# Require a password for the TCP console
tcpConsoleRequirePassword = false

# TCP console password
tcpConsolePassword = ''

# Host stdio console mode: 'Disabled', 'Auto', or 'Enabled'
stdioConsoleMode = 'Auto'

# Integrated localhost browser panel for server owners
[webPanel]
# Enable the integrated localhost web panel
webPanelEnabled = false

# Bind address for the web panel. Use '127.0.0.1' for local-only access
webPanelBindAddress = '127.0.0.1'

# HTTP port for the integrated web panel
webPanelPort = 4051

# Attempt to open the web panel in the default browser on startup
webPanelOpenBrowserOnStart = true

# Session lifetime in minutes for localhost browser access
webPanelSessionMinutes = 120

# Expose recent runtime logs to the localhost web panel
webPanelExposeLogs = true

# Gameplay and simulation behavior on dedicated servers
[gameplay]
# Ignore the loopback ghost host when checking sleep readiness
ignoreGhostHostForSleep = true

# Time progression multiplier. 1.0 is the default game speed
timeProgressionMultiplier = 1.0

# Allow players to sleep to advance time
allowSleeping = true

# Pause the game simulation when no players are connected
pauseGameWhenEmpty = false

# Fresh-save quest bootstrap mode: 'StartFromBeginning' or 'StartPostIntro'
freshSaveQuestBootstrapMode = 'StartFromBeginning'

# Automatic save behavior
[autosave]
# Enable timed auto-saving
autoSaveEnabled = true

# Minutes between automatic saves
autoSaveIntervalMinutes = 15.0

# Trigger a save when a player joins
autoSaveOnPlayerJoin = true

# Trigger a save when a player leaves
autoSaveOnPlayerLeave = true

# Diagnostic and debug logging controls
[logging]
# Enable one or more logging streams
enabledLoggingOptions = ['logPlayerActions', 'logAdminCommands']

# Enable performance monitoring instrumentation
enablePerformanceMonitoring = false

# Headless performance tuning
[performance]
# Target frame rate. Use -1 for unlimited
targetFrameRate = 60

# VSync count. Dedicated servers should usually keep this at 0
vSyncCount = 0

# Save-file location settings
[storage]
# Optional custom save path. Empty uses UserData/DedicatedServerSave
saveGamePath = ''
```

### Configuration Sections Explained

#### [server] - Basic Server Settings
- `serverName`: Name displayed in server browser
- `maxPlayers`: Maximum concurrent connections (1-16)
- `serverPort`: Network port for client connections
- `serverPassword`: Connection password (empty = no password)

#### [authentication] - Security Settings
- `authProvider`: Authentication method ('None' = no Steam API)
- `authTimeoutSeconds`: Time to wait for authentication (30-120 recommended)
- `modVerificationEnabled`: Require client mod verification (false = simpler)
- `modVerificationTimeoutSeconds`: Time for mod verification (20-60 recommended)

#### [performance] - Performance Settings
- `targetFrameRate`: Server update rate (60 recommended)
- `vSyncCount`: Vertical sync (0 for headless servers)

#### [autosave] - Save Management
- `autoSaveEnabled`: Enable automatic saves
- `autoSaveIntervalMinutes`: Save frequency (5-60 recommended)
- `autoSaveOnPlayerJoin/Leave`: Save on player events

## 👥 permissions.toml

### Complete Configuration
```toml
# DedicatedServerMod permissions file

[metadata]
schemaVersion = 1
migrationVersion = 1
migratedFrom = 'default'
migratedAtUtc = '2026-05-14T20:36:32.1702108Z'

# Permission groups - define roles and their capabilities
[group.default]
priority = 0
inherits = []
allow = ['server.help']
deny = []

[group.support]
priority = 10
inherits = ['default']
allow = ['server.info']
deny = []

[group.moderator]
priority = 20
inherits = ['support']
allow = ['player.ban', 'player.bring', 'player.kick', 'player.list', 'player.return', 'player.unban']
deny = []

[group.administrator]
priority = 30
inherits = ['moderator']
allow = ['permissions.group.list', 'permissions.info', 'player.vanish', 'server.reloadconfig', 'server.save']
deny = []

[group.operator]
priority = 40
inherits = ['administrator']
allow = ['clientmods.policy.bypass', 'console.command.*', 'console.open', 'permissions.deny', 'permissions.grant', 'permissions.group.assign', 'permissions.group.unassign', 'permissions.reload', 'permissions.revoke', 'permissions.tempgrant', 'server.stop']
deny = []

# Individual player assignments
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

### Permission System Explained

#### Priority System
- Higher numbers = higher priority
- Players inherit from groups with lower priority
- Operator (50) > Administrator (30) > Moderator (20) > Support (10) > Default (0)

#### Group Inheritance
- Groups can inherit permissions from other groups
- `inherits = ['default']` means gets all default permissions plus additional ones

#### Player Assignments
- Individual players can be assigned to groups
- Format: `[player."SteamName"]`
- Can also have individual allow/deny lists

#### Common Permissions
- `server.help`: Show help commands
- `server.info`: View server information
- `player.kick`: Kick other players
- `player.ban`: Ban/unban players
- `server.save`: Manual save command
- `server.stop`: Stop the server
- `console.command.*`: All console commands

## 🔧 start_server.bat

### Complete Script
```bat
@echo off
cd /d "%~dp0"
start "" "Schedule I.exe" --batchmode --nographics --dedicated-server -memory-alloc-size 16384
```

### Command Line Arguments
- `--batchmode`: Run without graphical interface
- `--nographics`: Disable graphics rendering
- `--dedicated-server`: Start in server mode
- `-memory-alloc-size 16384`: Allocate 16GB RAM (in MB)

### Memory Allocation Options
- 8192 = 8GB (minimum for multiplayer)
- 16384 = 16GB (recommended)
- 32768 = 32GB (for large servers)

## 📋 Configuration Templates

### Minimal Server Configuration
```toml
[server]
serverName = "My Server"
serverPort = 7777
maxPlayers = 8
serverPassword = "password123"

[authentication]
authProvider = "None"
modVerificationEnabled = false

[performance]
targetFrameRate = 60
vSyncCount = 0
```

### High Security Configuration
```toml
[server]
serverName = "Secure Server"
serverPort = 7777
maxPlayers = 4
serverPassword = "StrongPassword123!"

[authentication]
authProvider = "SteamGameServer"
authTimeoutSeconds = 30
modVerificationEnabled = true
modVerificationTimeoutSeconds = 20

[autosave]
autoSaveEnabled = true
autoSaveIntervalMinutes = 5
```

### Performance Optimized Configuration
```toml
[server]
serverName = "Performance Server"
serverPort = 7777
maxPlayers = 16
serverPassword = ""

[authentication]
authProvider = "None"
modVerificationEnabled = false

[performance]
targetFrameRate = 120
vSyncCount = 0

[autosave]
autoSaveEnabled = true
autoSaveIntervalMinutes = 30
```

## 🔍 Configuration Validation

### Check Server Configuration
```powershell
# Verify server_config.toml syntax
Get-Content "E:\ThompsonTrips-Server\UserData\server_config.toml" | Select-String -Pattern "^\["

# Check key settings
Select-String -Path "E:\ThompsonTrips-Server\UserData\server_config.toml" -Pattern "serverName|serverPort|serverPassword"
```

### Check Permissions
```powershell
# Verify player assignments
Select-String -Path "E:\ThompsonTrips-Server\UserData\permissions.toml" -Pattern "player\."

# Check group definitions
Select-String -Path "E:\ThompsonTrips-Server\UserData\permissions.toml" -Pattern "group\."
```

### Test Configuration
```powershell
# Start server and check for errors
cd E:\ThompsonTrips-Server
start_server.bat

# Monitor for configuration errors
Get-Content "E:\ThompsonTrips-Server\UserData\Logs\*.log" -Tail 10
```

## 📝 Configuration Best Practices

### Security
1. Use strong passwords
2. Limit max players to your needs
3. Enable mod verification for public servers
4. Regularly review player permissions

### Performance
1. Allocate appropriate RAM (16GB recommended)
2. Set reasonable auto-save intervals
3. Monitor server resource usage
4. Adjust frame rate based on needs

### Maintenance
1. Backup configuration files
2. Document custom changes
3. Test configuration changes
4. Keep configuration files under version control

---

**Configuration Reference Complete!** Use this guide to customize your Schedule One dedicated server for your specific needs.
