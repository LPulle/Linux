#!/bin/bash
# Update source install first
# Commented out as managing software updates manually
#sudo yum update

# update Linux repo with latest files
cd ~/GitHub/Linux
DIRECTORY='~/GitHub/Linux'
if [ ! -d "$DIRECTORY" ]; then
  # If GitHub repo folder is missing clone it
  cd ~/GitHub
  git clone https://github.com/LPulle/Linux
  cd Linux
  else
   cd ~/GitHub/Linux 
fi
# pull the latest version from repo
sudo git pull origin master

# Export dpkg files and repos
rpm -qa > ~/yum.installed
sed -i 's/^/install /' ~/yum.installed
echo run >> ~/yum.installed
yes | sudo /bin/cp -nRf /etc/yum.repos.d/*.repo ~/ #creates ~/*.repo files

# Upgrade pip and export all python modules (excluding pyOpenSSL and cryptography)
sudo -H pip2 install --upgrade pip
sudo -H pip3 install --upgrade pip
sudo -H /usr/local/bin/pip3.7 install --upgrade pip
pip2 freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' > ~/pip2freeze.txt
pip3 freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' > ~/pip3freeze.txt
/usr/local/bin/pip3.7 freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' > ~/pip37freeze.txt
cat ~/pip2freeze.txt ~/pip3freeze.txt ~/pip37freeze.txt | sort > pipfreeze.txt
uniq pipfreeze.txt > pipfreezemerge.txt
cut -d "=" -f1 Linux/migrateinstall/centos/files/pipfreezemerge.txt | uniq > pipfreezeinstall.txt

# Export npm modules
sudo npm update -g npm
ls `npm root -g` > ~/npmmodules.txt

# Push to GitHub
cd ~/GitHub/Linux/migrateinstall/centos
yes | /bin/cp -f ~/yum.installed files
yes | /bin/cp -f ~/pip2freeze.txt files
yes | /bin/cp -f ~/pip3freeze.txt files
yes | /bin/cp -f ~/pip37freeze.txt files
yes | /bin/cp -f ~/pipfreezemerge.txt files
yes | /bin/cp -f ~/pipfreezeinstall.txt files
yes | /bin/cp -f ~/npmmodules.txt files
yes | /bin/cp -f ~/*.repo files
git add -A
git commit -am "Update CentOS export files"
git push #login to github

# Copy all files created from the above to new install into ~/files
# Also copy across any dot files you may want
