#!/bin/bash

if [ -z "$HOME" ]; then
  export HOME="/home/$(whoami)"
fi

create_symlink() {
  ln -sf "$1" "$2"
}

setup_all() {
  create_symlink "$HOME/dot-fyle/.bashrc" "$HOME/.bashrc"
  create_symlink "$HOME/dot-fyle/.zshrc" "$HOME/.bashrc"
  create_symlink "$HOME/dot-fyle/.aliases" "$HOME/.aliases"
  create_symlink "$HOME/dot-fyle/.gitconfig" "$HOME/.gitconfig"
  create_symlink "$HOME/dot-fyle/.tmux.conf" "$HOME/.tmux.conf"
  mkdir -p "$HOME/.config/nvim"
  create_symlink "$HOME/dot-fyle/nvim"/* "$HOME/.config/nvim/"
  create_symlink "$HOME/dot-fyle/rofi" "$HOME/.config"
  create_symlink "$HOME/dot-fyle/i3" "$HOME/.config"
  create_symlink "$HOME/dot-fyle/polybar" "$HOME/.config"
  create_symlink "$HOME/dot-fyle/.zshrc" "$HOME/.zshrc"
  mkdir -p "$HOME/.config/kitty"
  create_symlink "$HOME/dot-fyle/kitty"/* "$HOME/.config/kitty/"
  create_symlink "$HOME/dot-fyle/.wezterm.lua"/* "$HOME/.wezterm.lua"
  create_symlink "$HOME/dot-fyle/scripts" "$HOME/.local/bin"
  create_symlink "$HOME/dot-fyle/starship.toml" "$HOME/.config/starship.toml"
  mkdir -p "$HOME/.local/bin"
  create_symlink "$HOME/dot-fyle/bin"/* "$HOME/.local/bin"
  create_symlink "$HOME/dot-fyle/.startup.sh"/* "$HOME/.startup.sh"
  echo 'Full run completed'
}

menu() {
  clear
  echo "Dot Jake Setup"
  echo "============"
  echo "0. Setup all for Linux"
  echo "1. Symlink BASH config"
  echo "2. Symlink ZSH config"
  echo "3. Symlink GIT"
  echo "4. Symlink TMUX"
  echo "5. Symlink Neovim"
  echo "6. Symlink Rofi"
  echo "7. Symlink i3"
  echo "8. Symlink Polybar"
  echo "9. Symlink Kitty"
  echo "10. Symlink WezTerm"
  echo "11. Symlink Scripts"
  echo "12. Symlink Starship"
  echo "13. Symlink Startup Script"
  echo "X. Exit"
  echo "============"
  read -p "Enter your choice: " choice
  case $choice in
    0)
      setup_all
      ;;
    1)
      create_symlink "$HOME/dot-fyle/.bashrc" "$HOME/.bashrc"
      echo ".bashrc symlinked"
      ;;
    2)
      create_symlink "$HOME/dot-fyle/.zshrc" "$HOME/.zshrc"
      echo ".zshrc symlinked"
      ;;
    3)
      create_symlink "$HOME/dot-fyle/.gitconfig" "$HOME/.gitconfig"
      echo ".gitconfig symlinked"
      ;;
    4)
      create_symlink "$HOME/dot-fyle/.tmux.conf" "$HOME/.tmux.conf"
      echo ".tmux.conf symlinked"
      ;;
    5)
      mkdir -p "$HOME/.config/nvim"
      create_symlink "$HOME/dot-fyle/nvim"/* "$HOME/.config/nvim/"
      echo "Neovim configuration symlinked"
      ;;
    6)
      create_symlink "$HOME/dot-fyle/rofi" "$HOME/.config"
      echo "Rofi configuration symlinked"
      ;;
    7)
      create_symlink "$HOME/dot-fyle/i3" "$HOME/.config"
      echo "i3 configuration symlinked"
      ;;
    8)
      create_symlink "$HOME/dot-fyle/polybar" "$HOME/.config"
      echo "Polybar configuration symlinked"
      ;;
    9)
      mkdir -p "$HOME/.config/kitty"
      create_symlink "$HOME/dot-fyle/kitty"/* "$HOME/.config/kitty/"
      echo "Kitty configuration symlinked"
      ;;
    10)
      create_symlink "$HOME/dot-fyle/.wezterm.lua" "$HOME/.wezterm.lua"
      echo "WezTerm configuration symlinked"
      ;;
    11)
      mkdir -p "$HOME/.local/bin"
      create_symlink "$HOME/dot-fyle/scripts" "$HOME/.local/bin"
      create_symlink "$HOME/dot-fyle/bin"/* "$HOME/.local/bin"
      echo "Scripts symlinked"
      ;;
    12)
      create_symlink "$HOME/dot-fyle/starship.toml" "$HOME/.config/starship.toml"
      echo "Starship configuration symlinked"
      ;;
    13)
      create_symlink "$HOME/dot-fyle/.startup.sh" "$HOME/.startup.sh"
      echo "Startup script symlinked"
      ;;
    x|X)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid choice"
      ;;
  esac
  read -n 1 -s -r -p "Press any key to return to the menu"
}

if [ "$1" == "0" ]; then
  setup_all
  exit 0
fi

while true; do
  menu
done

