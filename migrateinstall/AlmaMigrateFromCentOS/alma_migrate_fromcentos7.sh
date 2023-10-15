#!/bin/bash
##install repos and dnf utils which will be needed - there are probably some duplicates but it seems to run ok
sudo yum install epel-release -y
sudo yum config-manager --set-enabled powertools
sudo dnf install epel-release -y
sudo dnf install rpmfusion-free-release -y
sudo dnf install --nogpgcheck https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm -y
sudo dnf install http://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
sudo rpm -Uvh https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
sudo dnf upgrade --refresh -y
sudo dnf group install "Development Tools" -y
sudo dnf install dnf-utils -y

##go to home and get .bashrc and .bash_aliases
cd ~
wget https://raw.githubusercontent.com/LPulle/Linux/master/dotfiles/.bashrc
wget https://raw.githubusercontent.com/LPulle/Linux/master/dotfiles/.bash_aliases

##setup for using github repo
sudo dnf install git
mkdir -p GitHub
cd GitHub

##get the centosmigrate script to use as basis, make it executable and run it
wget https://raw.githubusercontent.com/LPulle/Linux/master/migrateinstall/centos/centosmigrate.sh
sudo chmod +x centosmigrate.sh
./centosmigrate.sh

##clone the Linux github repo
git clone https://github.com/LPulle/Linux
##remove the old centosmigrate script which we don't need anymore
rm centosmigrate.sh

##go to the centos migrate folder
##install all the software from the installed-software.log (the install will be slow)
cd Linux/migrateinstall/centos
##this first one doesn't work because it fails when it gets an error
#sudo dnf install $(cat installed-software.log)
##instead we use a for loop - because of that it will take longer
for i in $(cat installed-software.log); do sudo dnf install -y $i; done

##upgrade and refresh all the repos again, do some group installs
sudo dnf upgrade --refresh -y
sudo dnf groupupdate core -y
sudo dnf groupupdate sound-and-video -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y

##install python modules for python2 and python3
for i in $(cat ~/files/pipfreezeinstall.txt); do sudo pip3 -qq install $i; done
for i in $(cat ~/files/pipfreezeinstall.txt); do sudo pip -qq install $i; done

##update npm and install the modules
sudo npm install -g npm@latest
sudo npm update
sudo npm update -g
for i in $(cat ~/files/npmmodules.txt); do sudo npm install $i; done

##check what hasn't been installed
cp ~/GitHub/Linux/migrateinstall/centos/installed-software.log ~/centosrpm.txt
rpm -qa --qf "%{NAME}\n" | sort | uniq > ~/almarpm.txt
diff --new-line-format="" --unchanged-line-format="" <(sort ~/centosrpm.txt) <(sort ~/almarpm.txt) > ~/centosniy.txt
##you can look through the centosniy file to see what was left, alter it, make any changes
##then if you want to try again use this in the for loop instead of installed-software.log to dnf install
##some software was not installed from repos, some will be machine specific and some is old centos7 software
