#!/bin/bash
# install svn
apt install subversion

# download the files
# make sure you don't have a folder called "files"
svn export https://github.com/LPulle/Linux/trunk/migrateinstall/ubuntu/files

# Update base install, install latest dist and clean
sudo apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y

# Copy repo keys and apt sources
sudo apt-key add ~/files/Repo.keys
sudo apt-key update
sudo cp -R ~/files/sources.list* /etc/apt/

# Install packages with apt-get and dpkg
sudo apt-get update
sudo apt-get install dselect
sudo dselect update
apt-cache dumpavail > ~/temp_avail
sudo dpkg --merge-avail ~/temp_avail
rm ~/temp_avail
sudo dpkg --clear-selections
sudo dpkg --set-selections < ~/files/Package.list
sudo apt-get dselect-upgrade -y

# Check for updates again after installing new software
sudo apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y

# Some software manages upgrades with their own package manager
#Python pip
sudo pip install --upgrade pip
sudo pip3 install --upgrade pip