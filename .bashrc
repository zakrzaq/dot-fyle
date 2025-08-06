# OPTIONS
HISTFILE="$HOME/.bash_history"
HISTSIZE=100000
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend       # Append to history file, don't overwrite
PROMPT_COMMAND='history -a; history -n'  # Share history across sessions

export EDITOR=nvim
export BROWSER=google-chrome-stable

# PATH
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH
[ -d $HOME/.local/_bin ] && export PATH=$HOME/.local/_bin:$PATH
[ -d /opt/nvim-linux-x86_64 ] && export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# BASICS
[ -f $HOME/.aliases ] && source $HOME/.aliases
[ -f $HOME/.local ] && source $HOME/.local

# TOOLS
[ -f $HOME/fzf.zsh ] && source ~/.fzf.zsh

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

[ -d /snap/bin ] && export PATH=$PATH:/snap/bin
[ -f $HOME/nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# RUST
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env

# DENO
[ -f $HOME/.deno/env ] && . "/home/jake/.deno/env"
if [[ ":$FPATH:" != *":/home/jake/.zsh/completions:"* ]]; then 
  export FPATH="/home/jake/.zsh/completions:$FPATH"; 
fi

# GO
if [ -d /usr/local/go/bin ]; then
  export PATH=$PATH:/usr/local/go/bin
  export PATH=$PATH:/home/jake/go/bin
fi

# BUN
if [[ -d BUN_INSTALL ]]; then
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  [ -s "/home/jake/.bun/_bun" ] && source "/home/jake/.bun/_bun"
fi
