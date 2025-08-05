# # SETUP
HISTFILE="$HOME/.bash_history"
HISTSIZE=100000
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend       # Append to history file, don't overwrite
PROMPT_COMMAND='history -a; history -n'  # Share history across sessions

export EDITOR=nvim
export BROWSER=google-chrome-stable

# BASICS
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.aliases.local" ] && source "$HOME/.aliases.local"

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/_bin" ] && export PATH="$HOME/.local/_bin:$PATH"
[ -d "/opt/nvim-linux-x86_64" ] && export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"  # Consider switching to .fzf.bash if available

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# PROGRAMMING
[ -d "/snap/bin" ] && export PATH="$PATH:/snap/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
  source /usr/share/nvm/init-nvm.sh
  complete -o nospace -C /usr/bin/terraform terraform
fi

export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT/bin" ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

[ -f "$HOME/.deno/env" ] && source "$HOME/.deno/env"

# Add custom completions to FPATH (Bash uses $BASH_COMPLETION_COMPAT_DIR or $BASH_COMPLETION_DIR in newer versions)
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then 
  export FPATH="$HOME/.zsh/completions:$FPATH"
fi

if [ -d /usr/local/go/bin ]; then
  export PATH="$PATH:/usr/local/go/bin:/home/jake/go/bin"
fi

# bun completions
[ -s "/home/jake/.bun/_bun" ] && source "/home/jake/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# nix
[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && source "$HOME/.nix-profile/etc/profile.d/nix.sh"

# USAGE:  sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

