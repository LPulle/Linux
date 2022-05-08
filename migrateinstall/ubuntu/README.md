# Migrating Ubuntu Installs
This is the Ubuntu version - updated for Ubuntu 20.04 now

Run the ubuntuexport.sh script on the source\
Upload the output files to the files folder - this will need to be updated periodically\
Run the ubuntumigrate.sh script on the new install
- The ubuntumigrate.sh installs svn, downloads the files, updates ubuntu and installs all the packages
- This is the first version of this which i tested on a WSL install - a couple of minor tweaks needed and it worked\
Source of the info is from this askubuntu thread which i have combined:\
https://askubuntu.com/questions/9135/how-to-backup-settings-and-list-of-installed-packages

- Further testing on a fresh install highlighted an issue using the commands:
dpkg --clear-selections
dpkg --set-selections < "inputfile"
apt-get dselect-upgrade -y

This could result in components of the base OS install being removed as they didn't match the input
the dselect-upgrade switch will remove anything not in the inputfile list and install everything on the list
If there is variation it will remove those packages rendering it unable to install the ones that do match

Solution was to replace this line with one which takes the first column of Package.list and loops through this with apt-get install
This will result in an attempt to install each item and will move on to the next item if it already installed and is uptodate
