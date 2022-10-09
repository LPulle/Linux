x <- read.csv("RPackages.csv", colClasses = "character")
#for (i in (1:length(x[,])) ) { 
#  if(!require(x[i])) install.packages(x[i,]) 
#}
install.packages(x$Package)
