### ALIASES ###

alias source-shell='source ~/.config/fish/config.fish'

function prime-run
    set -x __NV_PRIME_RENDER_OFFLOAD 1
    set -x __GLX_VENDOR_LIBRARY_NAME nvidia
    $argv
end

### DEV ALIASES ###

# TMUX
alias t='tmux has-session -t main 2>/dev/null && tmux attach-session -t main || tmux new-session -s main'
alias ta='tmux attach'
alias td='tmux detach'
alias tk='tmux kill-server'

# SYS TERM
alias rfish="source ~/.config/fish/config.fish"
alias rmv='rm -rf'
alias c='clear'
alias x='exit'
alias fz="fzf --preview 'bat --color=always {}'"

function rmv-dirs
    find . -name $argv[1] -type d -prune -exec rm -rf '{}' +
end

function mkcd
    mkdir "$argv[1]" && cd "$argv[1]"
end

function src
    source "./$argv[1]/bin/activate"
end

function lc
    fc -l 1 | tac | fzf --tac | xargs -r -I {} /bin/fish -c '{}'
end

alias bat='upower -i $(upower -e | grep BAT) | grep -E "(percentage|time to)"'

# LS aliases
alias lt='ls -l --color=auto -F -h'
alias lla='ls -la --color=auto -F -h'
alias ll='ls -l --color=auto -F -h'
alias la='ls -a --color=auto -F'
alias l='ls --color=auto -F'

# EXA aliases
alias et='exa --long --icons -T --git'
alias ela='exa -a --long --icons --git'
alias el='exa --long --icons --git'
alias ea='exa -a --icons'
alias e='exa --icons'

# DISK
alias dfh="df -h | grep home | awk '{print \$4}'"
alias dff='duf -only local'

# LAZY TOOLS
alias ld='lazydocker'
alias lg='lazygit'

# AUDIO/BLUETOOTH
alias pm='pulsemixer'
alias bt='bluetui'

# POWER
alias pps='powerprofilesctl set && notify-send "Power profile set" -i display'
alias ppg='powerprofilesctl get'

# REDSHIFT
alias rs="redshift -l 50.2649:19.0238 -t 5700:3500"

# Jobs function
function j
    if test (count $argv) -eq 0
        jobs
    else
        eval "fg %$argv[1]"
    end
end

# Alert function
alias alert='notify-send --urgency=low -i "$([ $status = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e \'s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//\')"'

# NVIDIA
alias nvr="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia "

# DEVELOPER
function edit-hosts
    sudo nvim /etc/hosts && sudo dscacheutil -flashcache
end

function cheat
    curl cheat.sh/$argv[1]
end

alias fnd-comment-py="rg '^\s*#' --glob '*.py'"
alias fnd-comment-js="rg '^\s*//|/\*|\*/' --glob '*.{js,ts}'"
alias use-sdk='source "$HOME/.sdkman/bin/sdkman-init.sh"'

# GIT ALIASES
alias gini='git init && git branch -m main'
alias gst='git status'
alias gft='git fetch'
alias gsm='git switch master'
alias gsn='git switch main'
alias gsd='git switch develop'
alias gca='git checkout .'
alias gaa='git add .'
alias gph='git push'
alias gpl='git pull'
alias gbl='git branch'
alias glg='git log -r -n 10 --pretty=format:"%h - %an, %ar : %s"'
alias glg-last-cmt='git log -n 1 --pretty=format:%H'
alias glg-tree='git log --oneline --decorate --graph -n 20'
alias glg-tree-detail='git log --graph --pretty=\'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\' -n 20'
alias gdf-up='git diff @{upstream}'
alias gdf-master='git diff master'
alias gdf-main='git diff main'
alias gdf-conf='git diff --name-only --diff-filter=U --relative'
alias gdf='git diff'

# GIT FUNCTIONS
function gsb
    git switch "$argv[1]"
end

function gcb
    git checkout -b "$argv[1]"
end

function gcm
    git commit -m "$argv[1]"
end

function gac
    git add .
    git commit -m "$argv[1]"
end

function gct
    git add .
    git commit -m "$argv[1]"
    git push
end

function gbr
    git branch -D "$argv[1]"
end

function gmr
    git merge "$argv[1]"
end

function gpub
    git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)
end

function gbr-local
    git branch | grep -v "$argv[1]" | xargs git branch -D
end

function grv
    git reset --"$argv[1]" HEAD~"$argv[2]"
end

# GIT STASH
function gsta
    git add .
    git stash save "$argv[1]"
end

alias gstl='git stash list'

function gstp
    git stash pop stash@{$argv[1]}
end

function gstd
    git stash drop stash@{$argv[1]}
end

# NVIM
alias nv='nvim'
alias xv="env NVIM_APPNAME=nvim-min nvim"
alias lv="env NVIM_APPNAME=nvim-light nvim"

# DOCKER
alias dc-ls='docker ps'
alias dc-ps='docker ps'
alias dc-killall='docker kill (docker ps -q)'
alias dc-ka='docker kill (docker ps -q)'
alias dc-clean='docker rmi -f (docker images -a -q)'
alias dc-img='docker images -a'
alias dc-up='docker compose up'
alias dc-down='docker compose down'

# DOCKER FUNCTIONS
function dc-stop
    docker kill (docker ps -qf expose=$argv[1])
end

function dc-st
    docker kill (docker ps -qf expose=$argv[1])
end

function dc-run
    docker run -it -p $argv[1]:$argv[1] $argv[2]
end

function dc-sh
    docker exec -it (docker ps -qf expose=$argv[1]) sh
end

# NETWORKING
function ssh-port
    set PORT $argv[1]
    set HOST $argv[2]
    ssh -N -f -L $PORT:localhost:$PORT $HOST
end

alias ssh-ports="ps aux | grep '[s]sh -N -f -L'"
alias ls-ports="sudo ss -tulpn | rg LISTEN | rg '127.0.0.1'"

# SYSTEM
alias nvr='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'
alias watch-fans 'watch -n 1 "i8kctl | awk \'{printf \"CPU Temp: %d°C | CPU Fan: %d | GPU Fan: %d | CPU RPM: %d\n\", \$4, \$6, \$7, \$8}\'"'
alias watch-cpu-clocks 'watch -n 1 "for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq; do echo -n \$(basename \$cpu) \" \"; awk \'{printf \"%.0f MHz\", \$1/1000}\' \$cpu; echo; done"'

