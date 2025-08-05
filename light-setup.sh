#!/bin/bash

# Better error handling - don't exit immediately, show what's happening
set -u  # Exit on undefined variables
# Removed set -e to handle errors gracefully

BASE_URL="https://zakrzaq.rf.gd/dot-fyles"
FILES=(
  ".zshrc"
  ".bashrc"
  ".aliases"
  ".gitconfig"
)
NVIM_DIR="$HOME/.config/nvim"
NVIM_FILE="init.lua"

echo "📦 Installing dotfiles from $BASE_URL"
echo "🏠 Home directory: $HOME"

# Function to download file with better error handling
download_file() {
    local url="$1"
    local target="$2"
    local backup="$target.bak"
    
    echo "⬇️  Downloading: $url"
    echo "📍 Target: $target"
    
    # Backup existing file
    if [ -f "$target" ]; then
        echo "💾 Backing up existing file to $backup"
        mv "$target" "$backup"
    fi
    
    # Download with verbose error reporting
    if curl -sSfL "$url" -o "$target"; then
        echo "✅ Successfully downloaded: $(basename "$target")"
        return 0
    else
        local exit_code=$?
        echo "❌ Failed to download: $url (exit code: $exit_code)"
        
        # Restore backup if download failed
        if [ -f "$backup" ]; then
            echo "🔄 Restoring backup"
            mv "$backup" "$target"
        fi
        return $exit_code
    fi
}

# Test connection first
echo "🔗 Testing connection to $BASE_URL..."
if ! curl -sSf "$BASE_URL" -o /dev/null; then
    echo "❌ Cannot connect to $BASE_URL"
    echo "🔍 Trying to diagnose the issue..."
    curl -v "$BASE_URL" || true
    exit 1
fi
echo "✅ Connection successful"

# Download each dotfile
success_count=0
total_files=${#FILES[@]}

for FILE in "${FILES[@]}"; do
    TARGET="$HOME/$FILE"
    if download_file "$BASE_URL/$FILE" "$TARGET"; then
        ((success_count++))
    else
        echo "⚠️  Skipping $FILE due to download failure"
    fi
done

# Handle nvim config
echo "📁 Creating nvim config directory: $NVIM_DIR"
mkdir -p "$NVIM_DIR"

NVIM_TARGET="$NVIM_DIR/$NVIM_FILE"
if download_file "$BASE_URL/nvim/$NVIM_FILE" "$NVIM_TARGET"; then
    ((success_count++))
    ((total_files++))
else
    echo "⚠️  Skipping nvim config due to download failure"
fi

echo ""
echo "📊 Summary: $success_count/$total_files files installed successfully"

if [ $success_c
