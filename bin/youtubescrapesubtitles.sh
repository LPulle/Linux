#!/usr/bin/env bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_GB.UTF-8
SHELL=/bin/sh
export DISPLAY=:0.0
# Install instructions
# 1)Install node, node-typescript and npm if you don't have them already using your package manager and upgrade to the latest version
# For ubuntu this is done like this (replace apt with your package manager: for centos: yum, suse: zypper etc):
#     sudo apt update
#     sudo apt install nodejs npm
#     curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -
#     sudo apt install nodejs
#     sudo apt install node-typescript
#     sudo apt update
# 2) Install these node modules
#     sudo npm install -g typescript
#     sudo npm install @types/node
#     sudo npm install youtube-captions-scraper
#     sudo npm install yargs
# 3) scrapersimple.ts <- filename to save the below 4 lines as - it's typescript to need to remove the #'s
#  // ES5 /TypeScript
#  var getSubtitles = require('youtube-captions-scraper').getSubtitles;
#  const args = require('yargs').argv;
#  getSubtitles({videoID: args.id, lang: 'en'}).then(captions => {console.log(JSON.stringify(captions, null, 4));});
# 4) Build js from typescript 
tsc scrapersimple.ts
# 5) Save this whole file in the same folder as the above scrapersimple.ts as .sh, make it executable with chmod +x and execute
# You will get a .js file - you can uncomment the tsc line above once you've run it the first time
# Shell script:
yt=http://www.youtube.com/watch?v=
i=$1 #your youtube video id goes here
output="`wget -qO- "$yt$i" | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si' | awk -v srch="&#39;" -v repl="'" '{ sub(srch,repl,$0); print $0 ".txt"}' | awk '{gsub (" ", "", $0); print}'`"
node scrapersimple.js --id=$i | grep "text" | awk '{gsub ("\"text\":", "", $0);print}' | awk '{gsub ("$", "\r", $0);print}' > $output
