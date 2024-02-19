#!/bin/bash
# switch to home directory
cd ~
mkdir -p files

# install svn
sudo yum install subversion

# download the files
# make sure you don't have a folder called "files"
sudo svn export https://github.com/LPulle/Linux/trunk/migrateinstall/AlmaMigrateFromCentOS/files
yes | sudo /bin/cp -fR ~/GitHub/Linux/migrateinstall/AlmaMigrateFromCentOS/files/* ~/files

# Install the relevant repos depending on Alma9 or Alma8
os=`cat /etc/almalinux-release`
Alma9=`grep "9" /etc/almalinux-release | wc -l`
if [[ $Alma9="1" ]]
then ./install_repos_9.sh
fi
Alma8=`grep "8" /etc/almalinux-release | wc -l`
if [[ $Alma8="1" ]]
then ./install_repos_8.sh
fi

# Update base install, install latest dist and clean
sudo yum update

# Install packages with yum
# use the historic Alma 8 file
# this won't be updated going forward after switch to Alma9
if [[ $Alma8="1" ]]
then yum shell ~/files/yum.installed_8
fi

# use the latest yum.installed file for Alma9 
if [[ $Alma9="1" ]]
then yum shell ~/files/yum.installed
fi

# Check for updates again after installing new software
# Commented out as managing software updates manually
sudo yum update

# install all the software from the installed-software.log (the install will be slow)
# this first one doesn't work because it fails when it gets an error
#sudo ACCEPT_EULA=Y dnf install $(cat installed-software.log)
##instead we use a for loop - because of that it will take longer
for i in $(cat installed-software.log); do sudo ACCEPT_EULA=Y dnf install -y $i; done
#sudo dnf upgrade -y

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
#sudo -H /usr/local/bin/pip3.7 install --upgrade pip
#sudo -H /usr/local/bin/pip3.7 install --upgrade setuptools pip
#sudo -H /usr/local/bin/python3.7 -m pip install --upgrade pip

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
#for i in $(cat ~/files/pipfreezeinstall.txt); do sudo /usr/local/bin/pip3.7 -qq install $i; done
for i in $(cat ~/files/pipfreezeinstall.txt); do sudo pip3 -qq install $i; done
for i in $(cat ~/files/pipfreezeinstall.txt); do sudo pip2 -qq install $i; done

# Install npm modules exported
sed 's/#.*//' ~/files/npmmodules.txt | xargs sudo npm install -g # this should work but stops if it gets an error
for i in $(cat ~/files/npmmodules.txt); do sudo npm install $i; done # this uses a for loop so will keep going
