# Zclassic Blockchain Bootstrap

Fast sync your Zclassic node with pre-synced blockchain data. Save hours of syncing time!

## ⚡ Latest Bootstrap

**📅 Date**: November 18, 2025
**📊 Block Height**: 2,914,022
**💾 Size**: 7.73 GB (compressed with zstd)
**🔗 Download**: [**Latest Release**](https://github.com/VictorLux/zclassic-bootstrap/releases/latest)

> **🎯 For Zipher Wallet Users**: The bootstrap is **automatically** offered during first launch!

---

## 📥 Download Latest Bootstrap

### → [**Go to Releases Page**](https://github.com/VictorLux/zclassic-bootstrap/releases) ←

All bootstrap files are available in the **Releases** section. Each release includes:
- 5 split archive files (to accommodate GitHub's 2GB limit)
- SHA256 checksums for verification
- Detailed installation instructions

---

## 🚀 Quick Installation

### For Zipher Wallet Users

**Zipher automatically handles bootstrap installation!**
- On first launch, Zipher detects if blockchain data is missing
- Offers to download and install the bootstrap automatically
- Shows progress during download, verification, and extraction

### For Command-Line Users

1. **Download the latest release** from the [Releases page](https://github.com/VictorLux/zclassic-bootstrap/releases)

2. **Download all 5 parts** (part-01 through part-05)

3. **Verify checksums**:
   ```bash
   sha256sum -c bootstrap-checksums.txt
   ```

4. **Combine parts**:
   ```bash
   cat zclassic-bootstrap-*-part-*.part > zclassic-bootstrap.tar.zst
   ```

5. **Extract to Zclassic data directory**:
   ```bash
   # macOS
   tar --use-compress-program=zstd -xf zclassic-bootstrap.tar.zst \
     -C ~/Library/Application\ Support/Zclassic/

   # Linux
   tar --use-compress-program=zstd -xf zclassic-bootstrap.tar.zst \
     -C ~/.zclassic/
   ```

6. **Start your daemon**:
   ```bash
   zclassicd -daemon
   ```

---

## 📂 Default Data Directory Locations

- **Windows**: `%APPDATA%\ZClassic\`
- **macOS**: `~/Library/Application Support/Zclassic/`
- **Linux**: `~/.zclassic/`

---

## ⚠️ Important Safety Notes

1. **ALWAYS backup your wallet.dat** before using bootstrap
2. The bootstrap **does NOT contain your wallet** - your private keys stay safe
3. After extracting, your node will sync remaining blocks (usually under 1 hour)
4. Always verify SHA256 checksums before extraction
5. Compatible with Zclassic Core 1.x and Zipher wallet

---

## 🔧 Troubleshooting

### "No such file or directory" when extracting
- Install zstd:
  - macOS: `brew install zstd`
  - Linux: `apt install zstd` or `yum install zstd`

### Node won't start after bootstrap
- Check debug.log: `tail -f ~/.zclassic/debug.log`
- Try running with reindex: `zclassicd -daemon -reindex`

### Download speed too slow?
All 5 parts can be downloaded **in parallel** for faster speeds!

---

## 🆘 Support

- **GitHub Issues**: [Report problems](https://github.com/VictorLux/zclassic-bootstrap/issues)
- **Zipher Wallet**: [https://github.com/VictorLux/Zipher](https://github.com/VictorLux/Zipher)
- **Zclassic Community**: [Official Links](https://zclassic-ce.org)

---

## 📊 Why Use Bootstrap?

| Method | Time | Bandwidth | Difficulty |
|--------|------|-----------|------------|
| **Bootstrap** | ~30 minutes | 7.73 GB | Easy ✅ |
| **Full Sync** | 12-48 hours | 8+ GB | Medium |

---

## 🔄 Update Frequency

Bootstraps are created periodically (approximately monthly or after significant network updates). Check the [Releases page](https://github.com/VictorLux/zclassic-bootstrap/releases) for the latest version.

---

## 📝 Technical Details

- **Compression**: zstd level 19 (50% better than gzip)
- **Split Files**: 5 parts to work around GitHub's 2GB limit
- **Contents**: `blocks/` and `chainstate/` directories
- **Index Status**: Pre-built and verified
- **Verification**: SHA256 checksums for each file

---

## 🙏 Credits

Bootstrap created and maintained by [@VictorLux](https://github.com/VictorLux) for the Zclassic community.

**Last Updated**: November 18, 2025
