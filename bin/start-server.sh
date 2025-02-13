#!/bin/bash

# OBERON
cd ~/development/projects/oberon/dist
make deploy

# GIT-AUTO-COMMIT
cd ~/development/projects/git-auto-commit
npm run deploy

# UE-FUNDS-SCRAPE
cd  ~/development/projects/ue-funds-scrape
npm run pm2:start


