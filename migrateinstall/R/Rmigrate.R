<<<<<<< HEAD
x <- read.csv("RPackages.csv", colClasses = "character")
#for (i in (1:length(x[,])) ) { 
#  if(!require(x[i])) install.packages(x[i,]) 
#}
install.packages(x)
=======
x <- read.csv("RPackages.csv", colClasses = "character")
#for (i in (1:length(x[,])) ) { 
#  if(!require(x[i])) install.packages(x[i,]) 
#}
install.packages(x$Package)
>>>>>>> f7d1e5934faedf0c803c02f8085e20ecd5405195
