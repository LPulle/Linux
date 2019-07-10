for i in $(cat GitHub/Linux/migrateinstall/centos/files/pipfreezemerge.txt | cut -d "=" -f 1); do sudo pip2 -qq install $i; done
for i in $(cat GitHub/Linux/migrateinstall/centos/files/pipfreezemerge.txt | cut -d "=" -f 1); do sudo pip3 -qq install $i; done
for i in $(cat GitHub/Linux/migrateinstall/centos/files/pipfreezemerge.txt | cut -d "=" -f 1); do sudo /usr/local/bin/pip3.7 -qq install $i; done
