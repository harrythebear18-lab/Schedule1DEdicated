# Schedule 1 Dedicated Server Setup

A complete working setup for Schedule 1 dedicated server with SDS (Simple Dedicated Server) mod support.

## 🚀 Quick Setup

### Server Requirements
- Schedule 1 installed through Steam
- Windows OS
- Port 25565 open (for external connections)

### Server Installation

1. **Copy files to your Schedule 1 game directory:**
   ```
   [Your Schedule 1 Game Directory]
   ```

2. **Copy these required files:**
   - `BisectHostingClientMod.dll` - SDS mod
   - `doorstop_config.ini` - Mod loader configuration
   - `server_config.txt` - Server settings
   - `StartSDSServer.bat` - Server launcher

3. **Configure your save path (optional):**
   Edit `server_config.txt` and change the `save_path` to your desired location:
   ```
   save_path="[Your Custom Save Path]"
   ```

4. **Start your server:**
   - Navigate to your Schedule 1 game directory
   - Double-click `StartSDSServer.bat`
   - Server will start on port 25565

## 📋 Server Configuration

### server_config.txt
```ini
# Schedule 1 Dedicated Server Configuration
port=25565
max_players=8
server_name="Your Server Name"
public=true
bind_address=0.0.0.0
save_path="[Your Custom Save Path]"
```

### doorstop_config.ini
```ini
[General]
enabled=true
target_assembly=BisectHostingClientMod.dll
redirect_output_log=true
```

## 👥 Client Connection Instructions

### For Players to Connect:

1. **Install Schedule 1** through Steam
2. **Install SDS Mod** (same files as server):
   - Copy `BisectHostingClientMod.dll` to game directory
   - Copy `doorstop_config.ini` to game directory
3. **Launch Schedule 1 normally**
4. **Open Multiplayer/Server Browser**
5. **Connect to server:**
   - **Direct Connect**: Enter server IP and port (e.g., `[SERVER_IP]:25565`)
   - **Server Browser**: Look for your server name in the list

### Finding Your Server IP:

**For LAN/Local Players:**
- Run `cmd` and type: `ipconfig`
- Look for "IPv4 Address" (usually starts with 192.168.x.x or 10.x.x.x)
- Use this IP with port 25565

**For Internet Players:**
- Use your public IP: Check via online IP lookup service
- Set up port forwarding on your router:
  - Forward port 25565 to your server machine's local IP
  - Protocol: TCP/UDP (both)

## 🔧 Troubleshooting

### Common Issues:

**Server won't start:**
- Verify Schedule 1 is installed through Steam
- Check all files are in the correct game directory
- Run `StartSDSServer.bat` as Administrator

**Players can't connect:**
- Verify port 25565 is open (use online port checking tools)
- Check Windows Firewall settings
- Ensure port forwarding is configured for internet players

**Save file issues:**
- Ensure the save_path directory exists
- Check write permissions on save folder
- Verify path in `server_config.txt` is correct

### Server Logs:
Check `output_log.txt` in your Schedule 1 game directory for detailed error information.

## 📁 File Structure

```
Schedule I/
├── Schedule I.exe                    # Main game executable
├── Schedule I_Data/                   # Game data folder
├── BisectHostingClientMod.dll        # SDS mod (REQUIRED)
├── doorstop_config.ini               # Mod loader config (REQUIRED)
├── server_config.txt                 # Server settings (REQUIRED)
├── StartSDSServer.bat                # Server launcher (REQUIRED)
└── output_log.txt                    # Server logs (generated)
```

## 🌐 Network Setup

### Port Forwarding (Router):
1. Login to your router's admin panel
2. Find "Port Forwarding" section
3. Add rule:
   - **External Port**: 25565
   - **Internal Port**: 25565
   - **Internal IP**: Your server's local IP
   - **Protocol**: TCP/UDP
   - **Enable**: Yes

### Windows Firewall:
1. Open "Windows Defender Firewall"
2. Click "Allow an app through firewall"
3. Add "Schedule I.exe" for both Private and Public networks
4. Or manually allow port 25565

## 🎮 Server Features

- **Dedicated Server**: Runs without GUI, optimized for hosting
- **SDS Mod Support**: Multiplayer functionality
- **Custom Save Path**: Choose where your server saves data
- **Configurable Settings**: Player limit, server name, port
- **Public/Private**: Control server visibility
- **Auto-save**: Server saves progress automatically

## 📞 Support

For issues with this setup:
1. Check the troubleshooting section above
2. Review server logs in `output_log.txt`
3. Verify all files are correctly installed
4. Test with local connections first

## 🔄 Updates

To update your server:
1. Update Schedule 1 through Steam
2. Replace mod files with latest versions
3. Keep your `server_config.txt` settings

---

**Note**: This setup bypasses the problematic S1ServerLauncher GUI and uses a direct batch file approach for maximum compatibility and reliability.
