#!/bin/bash
# Update source install first
# Commented out as managing software updates manually
#sudo yum update

# update Linux repo with latest files
cd /home/pullel/GitHub/Linux
DIRECTORY='/home/pullel/GitHub/Linux'
if [ ! -d "$DIRECTORY" ]; then
  # If GitHub repo folder is missing clone it
  cd /home/pullel/GitHub
  git clone https://github.com/LPulle/Linux
  cd Linux
  else
   cd /home/pullel/GitHub/Linux 
fi
# pull the latest version from repo
sudo git pull origin master

# Export rpm files and yum repos
rpm -qa > /home/pullel/yum.installed
sed -i 's/^/install /' /home/pullel/yum.installed
echo run >> /home/pullel/yum.installed
yes | sudo /bin/cp -nRf /etc/yum.repos.d/*.repo /home/pullel #creates ~/*.repo files

# Export rpm package names to installed-software.log
rpm -qa --qf "%{NAME}\n" | sort | uniq > /home/pullel/GitHub/Linux/migrateinstall/AlmaMigrateFromCentOS/installed-software.log

# Upgrade pip and export all python modules (excluding pyOpenSSL and cryptography)
sudo -H pip install --upgrade pip
sudo -H pip3 install --upgrade pip
#sudo -H /usr/local/bin/pip3.7 install --upgrade pip
pip freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' | sed -e '/pycairo/d' | sed -e '/pyusb/d' > /home/pullel/pip2freeze.txt
pip3 freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' | sed -e '/pycairo/d' | sed -e '/pyusb/d' > /home/pullel/pip3freeze.txt
#/usr/local/bin/pip3.7 freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' | sed -e '/pycairo/d' | sed -e '/pyusb/d' > ~/pip37freeze.txt
cat /home/pullel/pip2freeze.txt pip3freeze.txt | sort > /home/pullel/pipfreeze.txt
uniq /home/pullel/pipfreeze.txt > /home/pullel/pipfreezemerge.txt
cut -d "=" -f1 /home/pullel/pipfreezemerge.txt | uniq > /home/pullel/pipfreezeinstall.txt

# Export npm modules
sudo npm install -g npm@latest
sudo npm install -g npm
sudo npm update
sudo npm update -g
ls `npm root -g` > /home/pullel/npmmodules.txt

# Push to GitHub
cd /home/pullel/GitHub/Linux/migrateinstall/AlmaMigrateFromCentOS
yes | sudo /bin/cp -f /home/pullel/yum.installed files
yes | sudo /bin/cp -f /home/pullel/pip2freeze.txt files
yes | sudo /bin/cp -f /home/pullel/pip3freeze.txt files
yes | sudo /bin/cp -f /home/pullel/pip37freeze.txt files
yes | sudo /bin/cp -f /home/pullel/pipfreezemerge.txt files
yes | sudo /bin/cp -f /home/pullel/pipfreezeinstall.txt files
yes | sudo /bin/cp -f /home/pullel/npmmodules.txt files
yes | sudo /bin/cp -f /home/pullel/*.repo files
rm -f *.bak
git add -A
git commit -am "Update AlmaLinux export files"
git push #login to github

# Cleanup
rm -f /home/pullel/yum.installed
rm -f /home/pullel/pipfreeze.txt
rm -f /home/pullel/pip2freeze.txt
rm -f /home/pullel/pip3freeze.txt
rm -f /home/pullel/pip37freeze.txt
rm -f /home/pullel/pipfreezemerge.txt
rm -f /home/pullel/pipfreezeinstall.txt
rm -f /home/pullel/npmmodules.txt
rm -f /home/pullel/*.repo

# Copy all files created from the above to new install into ~/files
# Also copy across any dot files you may want
