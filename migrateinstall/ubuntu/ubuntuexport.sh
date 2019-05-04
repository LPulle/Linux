#!/bin/bash
# Update source install first
sudo apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y

# update Linux repo with latest files
cd ~/GitHub/Linux
sudo git pull origin master

# Export dpkg files and repos
dpkg --get-selections > ~/Package.list #creates ~/Package.list
sudo cp -nRf /etc/apt/sources.list* ~/ #creates ~/sources.list files
sudo apt-key exportall > ~/Repo.keys #creates ~/Repo.keys

# Push to GitHub
sudo cp -nRf ~/Package.list ~/GitHub/Linux/files
sudo cp -nRf ~/Repo.keys ~/GitHub/Linux/files
sudo cp -nRf ~/sources.list* ~/GitHub/Linux/files
sudo git commit -am "Update ubuntu export files"
sudo git push #login to github

# Copy all files created from the above to new install into ~
# Also copy across any . files you may want