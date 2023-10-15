# Migrating to Alma Linux from CentOS 7 files
This is the first attempt to take the files from the centos folder and install into a new Alma Linux build
It may also work for other RHEL based distros, but am trying with Alma first to see if it works

Run the alma_migrate_fromcentos7.sh
- Installs svn, downloads the files, updates Alma and installs all the packages
- Created on Alma Linux WSL instance but needs more testing
- Also reinstalls/updates python and npm including all the modules

Also included now are versions of the migrate and export scripts based on the CentOS versions for pushing the files to this repo (export)
And also one for migrating to another Alma install (migrate)
- This currently uses a yum.installed file which should still work but ideally should be switched to dnf
- It also does updates and installs as part of the migrate using yum - again should work but ideally a switch to dnf is better
- Added repo scripts with version checking for Alma Linux 8 or 9
