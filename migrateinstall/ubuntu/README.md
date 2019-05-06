# Migrating Ubuntu Installs
This is the Ubuntu version\

Run the ubuntuexport.sh script on the source\
Upload the output files to the files folder - this will need to be updated periodically\
Run the ubuntumigrate.sh script on the new install\
- The ubuntumigrate.sh installs svn, downloads the files, updates ubuntu and installs all the packages\
- This is the first version of this which i tested on a WSL install - a couple of minor tweaks needed and it worked\
Source of the info is from this askubuntu thread which i have combined:\
https://askubuntu.com/questions/9135/how-to-backup-settings-and-list-of-installed-packages
