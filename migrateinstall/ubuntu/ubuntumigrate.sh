#!/bin/bash
# switch to home directory
cd ~
mkdir -p files

# install svn
sudo apt -y install subversion

# download the files
# make sure you don't have a folder called "files"
svn export https://github.com/LPulle/Linux/trunk/migrateinstall/ubuntu/files
cp -R ~/GitHub/Linux/migrateinstall/ubuntu/files/* ~/files

# Update base install, install latest dist and clean
sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y

# Copy repo keys and apt sources
sudo apt-key add ~/files/Repo.keys
sudo apt-key update
sudo cp -nRf ~/files/sources.list* /etc/apt/

# Install packages with apt-get and dpkg
sudo apt update
sudo apt install dselect
sudo dselect update
apt-cache dumpavail > ~/temp_avail
sudo dpkg --merge-avail ~/temp_avail
rm ~/temp_avail
sudo dpkg --clear-selections
sudo dpkg --set-selections < ~/files/Package.list
sudo apt-get dselect-upgrade -y

# Check for updates again after installing new software
sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y

# Some software manages upgrades with their own package manager
#Python pip
sudo -H pip install --upgrade pip
sudo -H pip3 install --upgrade pip
sudo -H pip3 install --upgrade setuptools pip
sudo -H python -m pip install --upgrade pip

# Install python modules exported
sudo -H pip2 install -r ~/files/pip2freeze.txt
sudo -H pip3 install -r ~/files/pip3freeze.txt

# Install npm modules exported
sed 's/#.*//' npmmodules.txt | xargs sudo npm install -g # this should work but stops if it gets an error
for i in $(cat ~/files/npmmodules.txt); do sudo npm install $i; done # this uses a for loop so will keep going
