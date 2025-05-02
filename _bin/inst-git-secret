#!/usr/bin/env bash

set -e

#check if git secret installed
git secret --version || app_installed=false

# install git secret
if ! $app_installed; 
then
    sudo sh -c "echo 'deb https://gitsecret.jfrog.io/artifactory/git-secret-deb git-secret main' >> /etc/apt/sources.list"
    wget -qO - 'https://gitsecret.jfrog.io/artifactory/api/gpg/key/public' | sudo apt-key add -
    sudo apt-get update && sudo apt-get install -y git-secret
    # echo "deb https://dl.bintray.com/sobolevn/deb git-secret main" | sudo tee -a /etc/apt/sources.list
    # wget -qO - https://api.bintray.com/users/sobolevn/keys/gpg/public.key | sudo apt-key add -
    # apt-get update && apt-get upgrade -y && apt-get install git-secret -y
else
    echo "Git Secret installed"
fi
