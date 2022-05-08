#!/bin/bash
# Update source install first
sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y

# update Linux repo with latest files
cd ~/GitHub/Linux
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
dpkg --get-selections > ~/Package.list #creates ~/Package.list
sudo cp -nRf /etc/apt/sources.list* ~/ #creates ~/sources.list files
sudo apt-key exportall > ~/Repo.keys #creates ~/Repo.keys

# Upgrade pip and export all python modules (excluding pyOpenSSL and cryptography)
sudo -H pip install --upgrade pip
#sudo -H pip3 install --upgrade pip
pip freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' | sed -e '/pycairo/d' | sed -e '/pyusb/d' > ~/pip2freeze.txt
#pip3 freeze | sed -e '/pyOpenSSL/d' | sed -e '/cryptography/d' | sed -e '/pycairo/d' | sed -e '/pyusb/d' > ~/pip3freeze.txt
cat ~/pip2freeze.txt | sort > ~/pipfreeze.txt
uniq ~/pipfreeze.txt > ~/pipfreezemerge.txt
cut -d "=" -f1 ~/pipfreezemerge.txt | uniq > ~/pipfreezeinstall.txt

# Export npm modules
sudo npm update -g npm
ls `npm root -g` > ~/npmmodules.txt

# Push to GitHub
cd ~/GitHub/Linux/migrateinstall/ubuntu
yes | sudo /bin/cp -f ~/Package.list files
yes | sudo /bin/cp -f ~/Repo.keys files
yes | sudo /bin/cp -rf ~/sources.list* files
yes | sudo /bin/cp -f ~/pip2freeze.txt files
yes | sudo /bin/cp -f ~/pip3freeze.txt files
yes | sudo /bin/cp -f ~/pipfreezemerge.txt files
yes | sudo /bin/cp -f ~/pipfreezeinstall.txt files
yes | sudo /bin/cp -f  ~/npmmodules.txt files
git add -A
git commit -am "Update ubuntu export files"
git push #login to github

# Cleanup
rm -f ~/Package.list
rm -f ~/Repo.keys
rm -f ~/pip2freeze.txt
rm -f ~/pip3freeze.txt
rm -rf ~/sources.list.d/
rm -f ~/pipfreezemerge.txt
rm -f ~/pipfreezeinstall.txt
rm -f ~/npmmodules.txt

# Copy all files created from the above to new install into ~/files
# Also copy across any dot files you may want
