#!/bin/bash
# switch to home directory
cd ~

# download the files
# make sure you don't have a folder called "files"
svn cat https://github.com/LPulle/Linux/trunk/migrateinstall/R/RPackages.csv > RPackages.csv
svn cat https://github.com/LPulle/Linux/trunk/migrateinstall/R/Rmigrate.R > Rmigrate.R

Rscript ~/Rmigrate.R

