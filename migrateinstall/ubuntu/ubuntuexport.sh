#!/bin/bash
# Update source install first
sudo apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y

# Export dpkg files and repos
dpkg --get-selections > ~/Package.list #creates ~/Package.list
sudo cp -R /etc/apt/sources.list* ~/ #creates ~/sources.list files
sudo apt-key exportall > ~/Repo.keys #creates ~/Repo.keys

# Copy all files created from the above to new install into ~
# Also copy across any . files you may want