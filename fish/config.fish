if status is-interactive
    # Commands to run in interactive sessions can go here
end

if test -f ~/.local.fish
    source ~/.local.fish
end

if test -f ~/.config/fish/aliases.fish
    source ~/.config/fish/aliases.fish
end

if test -f ~/.config/fish/settings.fish
    source ~/.config/fish/settings.fish
end

### PATHS ###

set -U fish_user_paths /home/jake/.local/bin
set -U fish_user_paths /home/jake/.local/utils


### DEV ###

starship init fish | source
source "$HOME/.cargo/env.fish"
source $HOME/.local/bin/env.fish
