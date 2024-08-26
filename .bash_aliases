# TMUX
alias ta='tmux attach'
alias td='tmux detach'

# SYS UBUNTU 
alias apd='sudo apt update'
alias apg='sudo apt upgrade'
alias api='fn() { sudo apt install "$@" }; fn'
alias apc='sudo apt autoremove && sudo apt autoclean'

# SYS ARCH
alias yai='fn() { yay -S "$@" }; fn'
alias yar='fn() { yay -R "$@" }; fn'
alias yau='yay -Syu'
alias pai='fn() { sudo pacman -S "$@" }; fn'
alias par='fn() { sudo pacman -R "$@" }; fn'
alias pau='sudo pacman -Syu'


# SYS TERM
alias la='ls -la'
alias rmv='rm -rf'
alias cl='clear'
alias x='exit'
alias mkd='fn() { mkdir "$1" && cd "$1"; }; fn'
alias we='watch echo'
alias src='fn() { source ./"$1"/bin/activate }; fn'
alias ls-cmd='fc -l -n 1 | fzf | xargs -r -I {} /bin/zsh -c "{}"'
alias fnd="fzf --preview 'bat --color=always {}'"
my-ip() { ip addr | grep -Po 'inet \K[\d.]+' | sort -nr | tr "\n" "  " ;};
alias me='echo $(whoami) $(uname -n) $(uname -s) $(my-ip)'
alias lz='exa --long --icons --git'
alias lza='exa --long --icons'
alias a='aaa'
alias ld='lazydocker'
alias lg='lazygit'

# GIT:
alias gint='git init && git branch -m main'
alias gst='git status'
alias gsm='git switch master'
alias gsn='git switch main'
alias gsd='git switch develop'
alias gsb='fn() { git switch "$1" ;}; fn'
alias gcb='fn() { git checkout -b "$1" ;}; fn'
alias gca='git checkout .'
alias gaa='git add .'
alias gcm='fn() { git commit -m "$1" ;}; fn'
alias gac='fn() { git add .; git commit -m "$1" ;}; fn'
alias gct='fn() { git add .; git commit -m "$1" ; git push;}; fn'
alias gbr='fn() { git branch -D "$1" ;}; fn'
alias gph='git push'
alias gpl='git pull'
alias gmr='fn() { git merge "$1" ;}; fn'
alias gbl='git branch'
alias gpub='fn() { git push --set-upstream origin `git rev-parse --abbrev-ref HEAD` }; fn'
alias glg='git log -r -n 10 --pretty=format:"%h - %an, %ar : %s"'
alias glg-last-cmt='git log -n 1 --pretty=format:%H'
alias glg-tree='git log --oneline --decorate --graph -n 20'
alias glg-tree-detail='git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' -n 20'
alias gdf-up='git diff @\{upstream\}'
alias gdf-master='git diff master'
alias gdf-main='git diff main'
alias gdf-conf='git diff --name-only --diff-filter=U --relative'
alias gdf='git diff'
alias gbr-local='fn() { git branch | grep -v "$1" | xargs git branch -D; }; fn'
alias wgst='watch -n 1 git status'
alias grv='fn() { git reset --"$1" HEAD~"$2" }; fn'

# DEV SERVERS
alias nrs='npm run serve'
alias nrd='npm run dev'
alias nrw='npm run watch'
alias nst='npm start'
alias yd='yarn dev'
alias yb='yarn build'
alias ys='yarn start'

# GIT STASH
alias gsta='fn() { git add .; git stash save "$1"; }; fn'
alias gstl='git stash list'
alias gstp='fn() { git stash pop stash@\{"$1"\} }; fn'
alias gstd='fn() { git stash drop stash@\{"$1"\} }; fn'

# NVIM
alias nv='nvim'
alias lv='NVIM_APPNAME="lvim" nvim'

# DOCKER
alias dc-ls='docker ps'
alias dc-ps='docker ps'
alias dc-killall='docker kill $(docker ps -q)'
alias dc-ka='docker kill $(docker ps -q)'
alias dc-stop='fn() { docker kill $(docker ps -qf expose=$1) }; fn'
alias dc-st='fn() { docker kill $(docker ps -qf expose=$1) }; fn'
alias dc-run='fn() { docker run -it -p $1:$1 $2 }; fn'
alias dc-clean='docker rmi -f $(docker images -a -q)'
alias dc-img='docker images -a'
alias dc-sh='fn() { docker exec -it $(docker ps -qf expose=$1) sh }; fn'
alias dc-up='docker compose up'
alias dc-down='docker compose down'

#UTILS
alias rsh="source ~/.zshrc"
alias edit-hosts='fn() { sudo nvim /etc/hosts && sudo dscacheutil -flashcache}; fn'
alias dus='fn() { du -h --max-depth=1 $1 | sort -hr }; fn'
alias dfh="df -h | grep home | awk '{print \$4}'"
alias rmv-dirs='fn() { find . -name $1 -type d -prune -exec rm -rf '{}' + }; fn'
alias cheat='fn() { curl cheat.sh/$1 }; fn'
