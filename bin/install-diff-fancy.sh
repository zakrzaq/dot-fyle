#!/usr/bin/env bash

app='diff-so-fancy'

set -e

#check if git secret installed
# git secret --version || app_installed=false
app_installed=false

# install git secret
if ! $app_installed; 
then
    sudo add-apt-repository ppa:aos1/diff-so-fancy
    sudo apt update
    sudo apt install diff-so-fancy
else
    echo "${app} installed"
fi
