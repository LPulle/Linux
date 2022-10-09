x <- read.csv("RPackages.csv", colClasses = "character")
install.packages(x$Package)
