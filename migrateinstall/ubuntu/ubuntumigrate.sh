#!/bin/bash
# switch to home directory
cd ~
#mkdir -p files

# install svn
sudo apt -y install subversion

# download the files
# make sure you don't have a folder called "files"
svn export https://github.com/LPulle/Linux/trunk/migrateinstall/ubuntu/files
yes | sudo /bin/cp -fR ~/GitHub/Linux/migrateinstall/ubuntu/files/* ~/files

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

# dselect is very dangerous and is not the best way to do this
# this has destroyed an install
#sudo dpkg --clear-selections
#sudo dpkg --set-selections < ~/files/Package.list
#sudo apt-get dselect-upgrade -y

# for loop is much better to iterate through Package.list and install each item one by one
for i in $(cat ~/files/Package.list | awk '{print$1}'); do sudo apt-get -y install $i; done

# Check for updates again after installing new software
sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y

# Some software manages upgrades with their own package manager
#Python pip - amend the commands if your python/pip are called something different
#2.7
sudo -H pip2 install --upgrade pip
sudo -H pip2 install --upgrade setuptools pip
sudo -H python2 -m pip install --upgrade pip
#3.x
sudo -H pip3 install --upgrade pip
sudo -H pip3 install --upgrade setuptools pip
sudo -H python3 -m pip install --upgrade pip

# Install python modules exported
# this should work but it stops if it gets an error:
#sudo -H pip2 install -r ~/files/pip2freeze.txt
#sudo -H pip3 install -r ~/files/pip3freeze.txt

# install using a for loop so will keep going even if it encounters an error
# it will find errors as pipfreezeinstall.txt is a merge of python 2 and 3 module exports
for i in $(cat ~/files/pipfreezeinstall.txt); do sudo /usr/local/bin/pip3.7 -qq install $i; done
for i in $(cat ~/files/pipfreezeinstall.txt); do sudo pip3 -qq install $i; done

# Install npm modules exported
sed 's/#.*//' npmmodules.txt | xargs sudo npm install -g # this should work but stops if it gets an error
for i in $(cat ~/files/npmmodules.txt); do sudo npm install $i; done # this uses a for loop so will keep going
