# install installr package if you don’t have it (this may be part of base now):
if(!require(installr)) install.packages("installr"); library(installr)
# using installr, this will check for updates & install silently if there is a new version
# if no update, it will update all packages
updateR(fast = F, GUI = F, browse_news = F, install_R = T, to_checkMD5sums = F, keep_install_file = F, download_dir = tempdir(), silent = T, setInternet2 = T, cran_mirror = "https://cran.rstudio.com/", copy_packages = T, update_packages = T)

# After the upgrade read the list of packages you exported before and install if they aren’t already installed
x <- read.csv("RPackages.csv", colClasses = "character")
for (i in (1:length(x[,])) ) { 
  if(!require(x[i])) install.packages(x[i,]) 
}
