# Zclassic Blockchain Bootstrap

Fast sync your Zclassic node with this pre-synced blockchain bootstrap. Save days of syncing time!

## 📊 Bootstrap Information

- **Date**: November 12, 2025
- **Block Height**: [TO BE UPDATED]
- **Size**: 8.3 GB (compressed)
- **Format**: tar.gz archive
- **Contents**: `blocks/` and `chainstate/` directories

## 🔒 Checksums

Verify the integrity of your download:

- **SHA256**: `3b0aef51045921f3f55de7b0139b5e0b9955c08d9ede236d36db53e6e87a07cf`
- **MD5**: `0c880798b633ac49dd240f76b6e71042`

## 📥 Download

### Option 1: Internet Archive (Recommended)
```bash
# Direct download
wget https://archive.org/download/zclassic-bootstrap-20251112.tar/zclassic-bootstrap-20251112.tar.gz

# Or using curl
curl -L -O https://archive.org/download/zclassic-bootstrap-20251112.tar/zclassic-bootstrap-20251112.tar.gz
```

**Web download**: https://archive.org/details/zclassic-bootstrap-20251112.tar

### Option 2: Torrent (Decentralized)
```bash
# Magnet link will be added here
```

## 🚀 Quick Installation

### For Non-Technical Users

**Windows:**
1. Download `install-bootstrap-windows.bat`
2. Double-click the file
3. Follow the prompts

**macOS:**
1. Download `install-bootstrap-mac.sh`
2. Open Terminal
3. Run: `bash install-bootstrap-mac.sh`

**Linux:**
1. Download `install-bootstrap-linux.sh`
2. Open Terminal
3. Run: `bash install-bootstrap-linux.sh`

### For Technical Users

**Manual Installation:**

1. **Stop your Zclassic daemon if running:**
   ```bash
   zclassic-cli stop
   ```

2. **Backup your wallet (IMPORTANT!):**
   ```bash
   # macOS/Linux
   cp ~/.zclassic/wallet.dat ~/wallet-backup.dat

   # Windows
   copy %APPDATA%\Zclassic\wallet.dat %USERPROFILE%\wallet-backup.dat
   ```

3. **Download and extract bootstrap:**
   ```bash
   # Download
   wget [DOWNLOAD_LINK] -O zclassic-bootstrap.tar.gz

   # Verify checksum
   echo "3b0aef51045921f3f55de7b0139b5e0b9955c08d9ede236d36db53e6e87a07cf  zclassic-bootstrap.tar.gz" | shasum -a 256 -c

   # Extract to Zclassic data directory
   # macOS/Linux:
   tar -xzf zclassic-bootstrap.tar.gz -C ~/.zclassic/

   # Windows (in PowerShell):
   # tar -xzf zclassic-bootstrap.tar.gz -C $env:APPDATA\Zclassic\
   ```

4. **Start your daemon:**
   ```bash
   zclassicd -daemon
   ```

5. **Verify sync:**
   ```bash
   zclassic-cli getinfo
   ```

## 📂 Default Data Directory Locations

- **Windows**: `%APPDATA%\Zclassic\`
- **macOS**: `~/Library/Application Support/Zclassic/`
- **Linux**: `~/.zclassic/`

## ⚠️ Important Notes

1. **ALWAYS backup your wallet.dat** before using this bootstrap
2. The bootstrap **does NOT contain your wallet** - your funds are safe
3. After extracting, your node will sync the remaining blocks (usually minutes)
4. Verify checksums to ensure file integrity
5. Compatible with Zclassic Core 1.x and ZPay wallet

## 🔧 Troubleshooting

### Bootstrap doesn't work
- Make sure zclassicd is fully stopped before extracting
- Verify checksums match
- Ensure you have enough disk space (~20 GB free)

### Node won't start after bootstrap
- Check zclassic debug.log: `tail -f ~/.zclassic/debug.log`
- Try running with `-reindex` flag: `zclassicd -daemon -reindex`

### "Corrupted block database" error
- Remove blocks and chainstate: `rm -rf ~/.zclassic/blocks ~/.zclassic/chainstate`
- Extract bootstrap again
- Start with `-reindex`

## 🆘 Support

- **GitHub Issues**: [Report problems here](https://github.com/VictorLux/zclassic-bootstrap/issues)
- **Zclassic Discord**: [Join the community](https://discord.gg/zclassic)
- **Forum**: [https://forum.zclassic.org](https://forum.zclassic.org)

## 📝 How This Bootstrap Was Created

```bash
# Stop daemon
zclassic-cli stop

# Wait for complete shutdown
sleep 10

# Create archive
cd ~/Library/Application\ Support/Zclassic/
tar -czf zclassic-bootstrap-$(date +%Y%m%d).tar.gz blocks chainstate

# Calculate checksums
shasum -a 256 zclassic-bootstrap-*.tar.gz
md5 zclassic-bootstrap-*.tar.gz
```

## 🔄 Update Frequency

This bootstrap is updated periodically. Check back for newer versions.

## 📜 License

This bootstrap is provided as-is for the Zclassic community. Free to use and distribute.

## 🙏 Credits

Bootstrap created and maintained by the Zclassic community.

---

**Last Updated**: November 12, 2025
**Maintainer**: [@VictorLux](https://github.com/VictorLux)
