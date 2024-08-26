#!/bin/bash

create_symlink() {
  ln -sf "$1" "$2"
}

setup_all() {
  create_symlink "$HOME/min_jake/.bashrc" "$HOME/.bashrc"
  create_symlink "$HOME/min_jake/.aliases.zsh" "$HOME/.aliases.zsh"
  create_symlink "$HOME/min_jake/.gitconfig" "$HOME/.gitconfig"
  create_symlink "$HOME/min_jake/.tmux.conf" "$HOME/.tmux.conf"
  mv "$HOME/.config/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf.bak" 
  create_symlink "$HOME/min_jake/kitty.conf" "$HOME/.config/kitty/kitty.conf"
  create_symlink "$HOME/min_jake/nvim/" "$HOME/.config/"
  echo 'Full run completed'
}

menu() {
  clear
  echo "Dot Jake Setup"
  echo "============"
  echo "0. Setup all for Linux"
  echo "1. Symlink BASH config"
  echo "2. Symlink GIT"
  echo "3. Symlink TMUX"
  echo "4. Symlink Neovim"
  echo "X. Exit"
  echo "============"
  read -p "Enter your choice: " choice
  case $choice in
    0)
      setup_all
      ;;
    1)
      create_symlink "$HOME/min_jake/.aliases.zsh" "$HOME/.aliases.zsh"
      create_symlink "$HOME/min_jake/.bashrc" "$HOME/.bashrc"
      echo ".zshrc symlinked"
      ;;
    2)
      create_symlink "$HOME/min_jake/.gitconfig" "$HOME/.gitconfig"
      echo ".gitconfig symlinked"
      ;;
    3)
      create_symlink "$HOME/min_jake/.tmux.conf" "$HOME/.tmux.conf"
      echo ".tmux.conf symlinked"
      ;;
    4)
      create_symlink "$HOME/min_jake/nvim" "$HOME/.config/nvim"
      echo "nvim symlinked"
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

