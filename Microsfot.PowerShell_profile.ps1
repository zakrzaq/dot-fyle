# SOURCE: https://github.com/gluons/powershell-git-aliases/blob/master/src/aliases.ps1

# oh-my-posh init pwsh --config 'C:\Users\jakub\AppData\Local\Programs\oh-my-posh\themes\unicorn.omp.json' | Invoke-Expression
Invoke-Expression (&starship init powershell)

# HELPERS
function get-current-branch {
  git symbolic-ref --quiet HEAD *> $null
  return git rev-parse --abbrev-ref HEAD
}

function ssh-wsl {
  ssh jake@172.30.58.205
}

function ssh-obr {
  ssh jake@192.168.21.20
}

# GIT
function gsm {
  git checkout master
}

function gsn {
  git checkout main
}

function gst {
  git status
}

function gsb {
  git switch $args
}

function gbl {
  git branch $args
}

function gbd {
  git branch -D $args
}

function gca {
  git checkout .
}

function gcm {
  git commit -m $args
}

function gct {
  git add .
  git commit -m $args
  git push
}

function gcbr {
  git checkout -b $args
}

function gpub {
  $CurrentBranch = get-current-branch
  git push --set-upstream origin $CurrentBranch
}

function gdf {
  git diff | nvim
}

function gdf-branch {
  git diff $args | nvim
}

function gdf-conf {
  git diff --name-only --diff-filter=U --relative
}

function glg {
  git log -r -n 10 --pretty=format:"%h - %an, %ar : %s"
}

function glg-last-cmt {
  git log -n 1 --pretty=format:%H
}

function glg-tree {
  git log --oneline --decorate --graph -n 20
}

function glg-tree-deatil {
  git log --graph --pretty='\''%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' -n 20
}

# SYSTEM UTILS
function rps {
  . $profile
}

function vim {
  nvim $args
}

function x {
  exit
}

function tkill {
  taskkill.exe /F /IM $args
}

function ips {
  ipconfig | select-string  ('(\s)+IPv4.+\s(?<IP>(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))(\s)*') -AllMatches | %{ $_.Matches } | % { $_.Groups["IP"]} | %{ $_.Value }
}

function top {
  Get-Process | Sort-Object -Property 'CPU' -Descending | Select-Object -First 10
}


# DIRS
function go-ra {
  cd C:\RA-Apps
}

function go-home {
  cd ~
}

# DEV UTILS
function venv {
  .venv\Scripts\activate
}

