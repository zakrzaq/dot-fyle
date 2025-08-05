#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Files to copy: [source_relative_path]=target_absolute_path
declare -A FILES=(
  [".zshrc"]="$HOME/.zshrc"
  [".bashrc"]="$HOME/.bashrc"
  [".aliases"]="$HOME/.aliases"
  [".gitconfig"]="$HOME/.gitconfig"
  [".tmux.conf"]="$HOME/.gitconfig"
  ["nvim/init.lua"]="$HOME/.config/nvim/init.lua"
)

for src_rel in "${!FILES[@]}"; do
  src_path="$REPO_DIR/$src_rel"
  dest_path="${FILES[$src_rel]}"

  echo "📄 Copying $src_path → $dest_path"
  mkdir -p "$(dirname "$dest_path")"
  cp "$src_path" "$dest_path"
done

echo "✅ All files copied to \$HOME."

# Optional: Source shell config interactively
if [[ $- == *i* ]]; then
  if [[ -n "${ZSH_VERSION:-}" ]]; then
    echo "🔁 Sourcing .zshrc"
    source "$HOME/.zshrc"
  elif [[ -n "${BASH_VERSION:-}" ]]; then
    echo "🔁 Sourcing .bashrc"
    source "$HOME/.bashrc"
  fi
fi

