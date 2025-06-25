# SETUP
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

# BASICS
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh

[ -f $HOME/.aliases ] && source $HOME/.aliases
[ -f $HOME/.aliases.local ] && source $HOME/.aliases.local

[ -d $HOME/.local/bin ] && export PATH=$HOME/.local/bin:$PATH
[ -d $HOME/.local/_bin ] && export PATH=$HOME/.local/_bin:$PATH

[ -d /opt/nvim-linux-x86_64 ] && export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

[ -f $HOME/fzf.zsh ] && source ~/.fzf.zsh

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# PROGRAMMING
[ -d /snap/bin ] && export PATH=$PATH:/snap/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /usr/bin/terraform terraform
  source /usr/share/nvm/init-nvm.sh
fi

export PYENV_ROOT="$HOME/.pyenv"
if [[ -d $PYENV_ROOT/bin ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env

[ -f $HOME/.deno/env ] && . "/home/jake/.deno/env"
if [[ ":$FPATH:" != *":/home/jake/.zsh/completions:"* ]]; then 
  export FPATH="/home/jake/.zsh/completions:$FPATH"; 
fi

if [ -d /usr/local/go/bin ]; then
  export PATH=$PATH:/usr/local/go/bin
  export PATH=$PATH:/home/jake/go/bin
fi


# bun completions
[ -s "/home/jake/.bun/_bun" ] && source "/home/jake/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# nix
[ -f $HOME/nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh
