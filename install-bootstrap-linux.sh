#!/bin/bash

# Zclassic Bootstrap Installer for Linux
# This script automatically downloads and installs the Zclassic blockchain bootstrap

set -e

echo "================================================"
echo "Zclassic Bootstrap Installer for Linux"
echo "================================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0;0m' # No Color

# Configuration
BOOTSTRAP_URL="https://archive.org/download/zclassic-bootstrap-20251112.tar/zclassic-bootstrap-20251112.tar.gz"
BOOTSTRAP_SHA256="3b0aef51045921f3f55de7b0139b5e0b9955c08d9ede236d36db53e6e87a07cf"
ZCL_DIR="$HOME/.zclassic"
WALLET_BACKUP="$HOME/wallet-backup-$(date +%Y%m%d-%H%M%S).dat"

# Check if zclassicd is running
if pgrep -x "zclassicd" > /dev/null; then
    echo -e "${YELLOW}⚠️  Zclassic daemon is running${NC}"
    read -p "Stop zclassicd now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "Stopping zclassicd..."
        zclassic-cli stop 2>/dev/null || killall zclassicd
        sleep 5
        echo -e "${GREEN}✓ Daemon stopped${NC}"
    else
        echo -e "${RED}❌ Cannot proceed while daemon is running${NC}"
        exit 1
    fi
fi

# Backup wallet if exists
if [ -f "$ZCL_DIR/wallet.dat" ]; then
    echo -e "${YELLOW}📁 Backing up wallet...${NC}"
    cp "$ZCL_DIR/wallet.dat" "$WALLET_BACKUP"
    echo -e "${GREEN}✓ Wallet backed up to: $WALLET_BACKUP${NC}"
fi

# Check disk space
REQUIRED_SPACE=20000000  # 20 GB in KB
AVAILABLE_SPACE=$(df -k "$HOME" | tail -1 | awk '{print $4}')

if [ "$AVAILABLE_SPACE" -lt "$REQUIRED_SPACE" ]; then
    echo -e "${RED}❌ Insufficient disk space${NC}"
    echo "Required: 20 GB, Available: $((AVAILABLE_SPACE / 1024 / 1024)) GB"
    exit 1
fi

# Download bootstrap
echo "📥 Downloading bootstrap (8.3 GB)..."
echo "This may take a while depending on your connection..."

TEMP_FILE="/tmp/zclassic-bootstrap.tar.gz"

if command -v wget &> /dev/null; then
    wget --progress=bar:force -O "$TEMP_FILE" "$BOOTSTRAP_URL"
elif command -v curl &> /dev/null; then
    curl -# -L -o "$TEMP_FILE" "$BOOTSTRAP_URL"
else
    echo -e "${RED}❌ Neither wget nor curl found. Please install one.${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Download complete${NC}"

# Verify checksum
echo "🔒 Verifying checksum..."
DOWNLOADED_SHA256=$(sha256sum "$TEMP_FILE" | awk '{print $1}')

if [ "$DOWNLOADED_SHA256" != "$BOOTSTRAP_SHA256" ]; then
    echo -e "${RED}❌ Checksum mismatch!${NC}"
    echo "Expected: $BOOTSTRAP_SHA256"
    echo "Got:      $DOWNLOADED_SHA256"
    rm "$TEMP_FILE"
    exit 1
fi

echo -e "${GREEN}✓ Checksum verified${NC}"

# Remove old blocks and chainstate
echo "🗑️  Removing old blockchain data..."
rm -rf "$ZCL_DIR/blocks" "$ZCL_DIR/chainstate"
echo -e "${GREEN}✓ Old data removed${NC}"

# Extract bootstrap
echo "📦 Extracting bootstrap..."
mkdir -p "$ZCL_DIR"
tar -xzf "$TEMP_FILE" -C "$ZCL_DIR"
echo -e "${GREEN}✓ Bootstrap extracted${NC}"

# Cleanup
rm "$TEMP_FILE"

# Start daemon
echo ""
read -p "Start zclassicd now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 Starting zclassicd..."
    zclassicd -daemon
    sleep 3

    echo ""
    echo "📊 Checking sync status..."
    zclassic-cli getinfo 2>/dev/null || echo "Daemon starting... check status with: zclassic-cli getinfo"
fi

echo ""
echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}✓ Bootstrap installation complete!${NC}"
echo -e "${GREEN}================================================${NC}"
echo ""
echo "Your node should now sync the remaining blocks (usually a few minutes)."
echo ""
echo "Useful commands:"
echo "  zclassic-cli getinfo          - Check sync status"
echo "  zclassic-cli getblockcount    - Current block height"
echo "  tail -f \"$ZCL_DIR/debug.log\"   - View logs"
echo ""
