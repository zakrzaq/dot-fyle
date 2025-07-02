#!/bin/bash

CONFIG_FILE="$HOME/.config/alacritty/alacritty.toml"
THEMES_DIR_REL="~/.config/alacritty/themes"

case "$1" in
  dawn)
    NEW_THEME="rose-pine-dawn.toml"
    ;;
  moon)
    NEW_THEME="rose-pine-moon.toml"
    ;;
  *)
    echo "Usage: $0 [dawn|moon]"
    exit 1
    ;;
esac

# Replace the line containing any rose-pine-* theme in the import list
sed -i -E "s#(${THEMES_DIR_REL}/)rose-pine-[^\"/]+\.toml#\1$NEW_THEME#g" "$CONFIG_FILE"

echo "✅ Alacritty theme changed to $NEW_THEME"
