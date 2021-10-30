#!/bin/bash
git pull origin master
Rscript	RexportPackages.R
git add -A
git commit -am "Upload R file"
git push
