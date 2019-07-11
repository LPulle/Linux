#!/bin/bash
# switch to home directory
cd ~

# install svn
sudo yum install subversion

# download the files
# make sure you don't have a folder called "files"
sudo svn export https://github.com/LPulle/Linux/trunk/migrateinstall/centos/files

# Update base install, install latest dist and clean
sudo yum update

# Install packages with yum
sudo yum shell ~/files/yum.installed

# Check for updates again after installing new software
# Commented out as managing software updates manually
#sudo yum update

# Some software manages upgrades with their own package manager
#Python pip
#Update all versions of pip (I have Python 2.7, 3.6 and 3.7)
#2.7
sudo -H pip2 install --upgrade pip
sudo -H pip2 install --upgrade setuptools pip
sudo -H python -m pip install --upgrade pip
#3.6
sudo -H pip3 install --upgrade pip
sudo -H pip3 install --upgrade setuptools pip
sudo -H python3.6 -m pip install --upgrade pip
#3.7
sudo -H /usr/local/bin/pip3.7 install --upgrade pip
sudo -H /usr/local/bin/pip3.7 install --upgrade setuptools pip
sudo -H /usr/local/bin/python3.7 -m pip install --upgrade pip

# Install python modules exported
# this should work but it stops if it gets an error:
#pip2 install -r ~/files/pip2freeze.txt
#pip3 install -r ~/files/pip3freeze.txt

#pip has a problem if pyOpenSSL and cryptography are old versions so uninstall and install latest versions
##fixed this in the export script now so no need to uninstall and reinstall now
#sudo -H pip2 uninstall pyOpenSSL cryptography
#sudo -H pip2 install pyOpenSSL cryptography
#sudo -H pip3 uninstall pyOpenSSL cryptography
#sudo -H pip3 install pyOpenSSL cryptography
#sudo -H /usr/local/bin/pip3.7 uninstall pyOpenSSL cryptography
#sudo -H /usr/local/bin/pip3.7 install pyOpenSSL cryptography

# install using a for loop so will keep going even if it encounters an error
# it will find errors as pipfreezeinstall.txt is a merge of python 2 and 3 module exports
for i in $(cat ~/pipfreezeinstall.txt); do sudo /usr/local/bin/pip3.7 -qq install $i; done
for i in $(cat ~/pipfreezeinstall.txt); do sudo pip3 -qq install $i; done
for i in $(cat ~/pipfreezeinstall.txt); do sudo pip2 -qq install $i; done

# Install npm modules exported
sed 's/#.*//' npmmodules.txt | xargs sudo npm install -g # this should work but stops if it gets an error
for i in $(cat ~/files/npmmodules.txt); do sudo npm install $i; done # this uses a for loop so will keep going
