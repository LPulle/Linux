#!/bin/bash
git pull origin master
Rscript	RexportPackages.R
git Add -A
git commit -am "Upload R files"
