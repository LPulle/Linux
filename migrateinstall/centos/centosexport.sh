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

# Export rpm files and yum repos
rpm -qa > ~/yum.installed
sed -i 's/^/install /' ~/yum.installed
echo run >> ~/yum.installed
yes | sudo /bin/cp -nRf /etc/yum.repos.d/*.repo ~/ #creates ~/*.repo files

# Export rpm package names to installed-software.log
rpm -qa --qf "%{NAME}\n" | sort | uniq > ~/GitHub/Linux/migrateinstall/centos/installed-software.log

# Upgrade pip and export all python modules (excluding pyOpenSSL and cryptography)
sudo -H pip2 install --upgrade pip
sudo -H pip3 install --upgrade pip
sudo -H /usr/local/bin/pip3.7 install --upgrade pip
pip2 freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' | sed -e '/pycairo/d' | sed -e '/pyusb/d' > ~/pip2freeze.txt
pip3 freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' | sed -e '/pycairo/d' | sed -e '/pyusb/d' > ~/pip3freeze.txt
/usr/local/bin/pip3.7 freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' | sed -e '/pycairo/d' | sed -e '/pyusb/d' > ~/pip37freeze.txt
cat ~/pip2freeze.txt pip3freeze.txt pip37freeze.txt | sort > ~/pipfreeze.txt
uniq ~/pipfreeze.txt > ~/pipfreezemerge.txt
cut -d "=" -f1 ~/pipfreezemerge.txt | uniq > ~/pipfreezeinstall.txt

# Export npm modules
sudo npm install -g npm@latest
sudo npm install -g npm
sudo npm update
sudo npm update -g
ls `npm root -g` > ~/npmmodules.txt

# Push to GitHub
cd ~/GitHub/Linux/migrateinstall/centos
yes | sudo /bin/cp -f ~/yum.installed files
yes | sudo /bin/cp -f ~/pip2freeze.txt files
yes | sudo /bin/cp -f ~/pip3freeze.txt files
yes | sudo /bin/cp -f ~/pip37freeze.txt files
yes | sudo /bin/cp -f ~/pipfreezemerge.txt files
yes | sudo /bin/cp -f ~/pipfreezeinstall.txt files
yes | sudo /bin/cp -f ~/npmmodules.txt files
yes | sudo /bin/cp -f ~/*.repo files
rm -f *.bak
git add -A
git commit -am "Update CentOS export files"
git push #login to github

# Cleanup
rm -f ~/yum.installed
rm -f ~/pipfreeze.txt
rm -f ~/pip2freeze.txt
rm -f ~/pip3freeze.txt
rm -f ~/pip37freeze.txt
rm -f ~/pipfreezemerge.txt
rm -f ~/pipfreezeinstall.txt
rm -f ~/npmmodules.txt
rm -f ~/*.repo

# Copy all files created from the above to new install into ~/files
# Also copy across any dot files you may want
