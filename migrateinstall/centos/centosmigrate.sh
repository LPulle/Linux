#!/bin/bash
# install svn
sudo yum install subversion

# download the files
# make sure you don't have a folder called "files"
svn export https://github.com/LPulle/Linux/trunk/migrateinstall/centos/files

# Update base install, install latest dist and clean
sudo yum update

# Install packages with yum
yum shell ~/files/yum.installed

# Check for updates again after installing new software
sudo yum update

# Some software manages upgrades with their own package manager
#Python pip
sudo -H pip install --upgrade pip
sudo -H pip3 install --upgrade pip
sudo -H pip3 install --upgrade setuptools pip
sudo -H python -m pip install --upgrade pip

# Install python modules exported
pip2 install -r ~/files/pip2freeze.txt
pip3 install -r ~/files/pip3freeze.txt

# Install npm modules exported
sed 's/#.*//' npmmodules.txt | xargs sudo npm install -g # this should work but stops if it gets an error
for i in $(cat ~/files/npmmodules.txt); do sudo npm install $i; done # this uses a for loop so will keep going