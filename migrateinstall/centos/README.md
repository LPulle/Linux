# Migrating CentOS 7 Installs
This is the CentOS 7 version

Run the centosexport.sh script on the source\
Upload the output files to the files folder - this will need to be updated periodically\
Run the centosmigrate.sh script on the new install
- The centosmigrate.sh installs svn, downloads the files, updates centos and installs all the packages
- This version has been tested on VirtualBox CentOS 7 install and worked after a few tweaks
- Added the repositories which were needed as the packages could not be found without them
- Subsequently tested on full centos install and is now a working backup of repos and installed software
- Also reinstalls/updates python and npm including all the modules\
Source of the original info for the yum install is from this linuxquestions thread which i incorporated:\
https://www.linuxquestions.org/questions/linux-server-73/centos-equivalent-of-dpkg-get-selections-set-selections-4175498883/
