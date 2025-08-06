# OPTIONS
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY      # Write to history immediately, not at exit
setopt SHARE_HISTORY           # Share history across multiple Zsh sessions
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

export EDITOR=nvim
export BROWSER=google-chrome-stable

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git fzf)

# PATH
[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH
[ -d $HOME/.local/_bin ] && export PATH=$HOME/.local/_bin:$PATH
[ -d /opt/nvim-linux-x86_64 ] && export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# BASICS
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

[ -f $HOME/.aliases ] && source $HOME/.aliases
[ -f $HOME/.local ] && source $HOME/.local

# TOOLS
[ -f $HOME/fzf.zsh ] && source ~/.fzf.zsh

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

[ -d /snap/bin ] && export PATH=$PATH:/snap/bin
[ -f $HOME/nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# NVM
if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/bin/terraform terraform
  source /usr/share/nvm/init-nvm.sh
fi

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
