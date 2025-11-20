# Zclassic Bootstrap

Fast-sync your Zclassic node with pre-downloaded blockchain data.

## Current Bootstrap

- **Block Height**: 2,916,559
- **Date**: 2025-11-20
- **Total Size**: 7.8 GB (compressed)
- **Parts**: 5 files

## Download

### Automatic (via Zipher Wallet)
The Zipher wallet will automatically download and install this bootstrap when needed.

### Manual Download

#### Option 1: Using GitHub CLI (Recommended)
```bash
# Download the helper script
gh release download --repo VictorLux/zclassic-bootstrap --pattern "download-and-combine.sh"
chmod +x download-and-combine.sh
./download-and-combine.sh
```

#### Option 2: Manual Download
1. Go to the [latest release](https://github.com/VictorLux/zclassic-bootstrap/releases/latest)
2. Download all `zclassic-bootstrap-*-part-*.part` files
3. Download `bootstrap-checksums.txt`
4. Verify checksums: `shasum -a 256 -c bootstrap-checksums.txt`
5. Combine parts: `cat zclassic-bootstrap-*-part-*.part > zclassic-bootstrap.tar.zst`

## Installation

### macOS
```bash
# Stop zclassicd if running
pkill zclassicd

# Backup your wallet first!
cp "$HOME/Library/Application Support/Zclassic/wallet.dat" ~/wallet.dat.backup

# Extract bootstrap
cd "$HOME/Library/Application Support/Zclassic"
zstd -d ~/Downloads/zclassic-bootstrap.tar.zst -o - | tar -x --strip-components=1

# Start zclassicd
zclassicd
```

### Linux
```bash
# Stop zclassicd if running
pkill zclassicd

# Backup your wallet first!
cp ~/.zclassic/wallet.dat ~/wallet.dat.backup

# Extract bootstrap
cd ~/.zclassic
zstd -d ~/Downloads/zclassic-bootstrap.tar.zst -o - | tar -x --strip-components=1

# Start zclassicd
zclassicd
```

### Windows
```powershell
# Stop zclassicd if running
# Use Task Manager or: taskkill /IM zclassicd.exe /F

# Backup your wallet first!
# Copy %APPDATA%\Zclassic\wallet.dat to a safe location

# Extract bootstrap to %APPDATA%\Zclassic
# Use 7-Zip with zstd plugin or WSL
```

## File List

- `zclassic-bootstrap-block-2916559-20251120_201519-part-01.part` (1.9G)
- `zclassic-bootstrap-block-2916559-20251120_201519-part-02.part` (1.9G)
- `zclassic-bootstrap-block-2916559-20251120_201519-part-03.part` (1.9G)
- `zclassic-bootstrap-block-2916559-20251120_201519-part-04.part` (1.9G)
- `zclassic-bootstrap-block-2916559-20251120_201519-part-05.part` (313M)
- `bootstrap-checksums.txt`
- `download-and-combine.sh`
- `BOOTSTRAP_README.md`

## Checksums

```
0d6b91970980ec6278fa729ceafd5715cd6ae4860150aa1a015e24b7d80f54eb  zclassic-bootstrap-block-2916559-20251120_201519-part-01.part
bff55ee9003fa642148a49e1f00d9a4f557fd4682c010c88976aa6c4e6d3163a  zclassic-bootstrap-block-2916559-20251120_201519-part-02.part
1b37ef1de7a7acb477c6b5ec54494ed6d04a594a777a6970aea536b8b5c556b8  zclassic-bootstrap-block-2916559-20251120_201519-part-03.part
7236b2baac22e64ccf7842d4d5aeaa110551ea41daa77b14db9e7704dc9fd2d1  zclassic-bootstrap-block-2916559-20251120_201519-part-04.part
5d252c85f29888e3aa0bedf3ab74b17a99fe75558d34e17da403677bca2160b8  zclassic-bootstrap-block-2916559-20251120_201519-part-05.part
```

## Archive Contents

- **blocks/** - Blockchain data files
- **blocks/index/** - Block index database (LevelDB)
- **chainstate/** - UTXO set database (LevelDB)

## Compression

- Algorithm: zstd
- Level: 19 (maximum compression)
- Ratio: ~50% better than gzip

## Requirements

- Enough disk space for extraction (~13 GB)
- zstd installed:
  - macOS: `brew install zstd`
  - Ubuntu/Debian: `apt install zstd`
  - Windows: Download from [zstd releases](https://github.com/facebook/zstd/releases)
- Stopped zclassicd daemon

## ⚠️ Important

- **Always backup wallet.dat before using bootstrap**
- Verify SHA256 checksums before extraction
- Compatible with Zclassic Core 1.x and Zipher wallet

## Links

- [Zipher Wallet](https://github.com/VictorLux/Zipher) - Modern Zclassic wallet with automatic bootstrap
- [Zclassic](https://zclassic.org/) - Official Zclassic website

---

🤖 Generated with Zipher Bootstrap Creator
