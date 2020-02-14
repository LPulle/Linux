## bin
This is a collection of scripts which have been useful for various reasons
Some are more administrative while others for a specific purpose
Quality is variable and at most they might have been tried on CentOS and Ubuntu
I usually run bash shell so it's likely that's what it was designed for
As with the dotfiles, some of this I found quite useful code so may be useful on other Linux installs

* Backup.sh - Backup script which creates a .tar.gz from all folders and their contents in /home. Destination default is /data/backup/BackupyyyymmddHHMMSS.tar.gz An additional file backupexclusions.txt can be populated with all paths that should not be included. This is by default located in /usr/local/bin/backupexclusions.txt. After running it executes a command to delete all but the most recent 7 files in the backup directory by date modified.
* HomeFolderSize.sh - simple command for calculating the size of everything in the /home folder in gigabytes. Useful as a precursor to Backup.sh to determine size required for backup
* rebootneeded.sh - checks to see if a kernel install has occurred which would require a reboot
* youtubescrapesubtitles.sh - bash script (instructions in the comments) to create scrapersimple.ts and .js which will download the auto captions of a youtube video parsing the video id. Uses nodejs, typescript, wget, perl, awk, grep, gsub to format the output txt file in a reasonably legible format
* scrapersimple.ts - script written in typescript needed to build scrapersimple.js
* scrapersimple.js - javascript of typescript youtube caption scraper: scrapersimple.ts
* upgradepython.sh - upgrades pip and all python modules for each install of python - in this instance v2.7, v3.6 and v3.7 all installed in separate locations
