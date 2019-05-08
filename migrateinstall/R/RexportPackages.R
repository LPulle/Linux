# Run this before upgrading
# get installed packages (exclude base)
ip <- as.data.frame(installed.packages()[,c(1,3:4,16)])
x <- as.data.frame(
  ip$Package[union(which(ip$Priority != "base"), 
                   which(is.na(ip$Priority)))]
                    , stringsAsFactors = FALSE) 
colnames(x) <- "Package"
x[] <- lapply(x, as.character)
# write package list to RPackages.csv
write.csv(x, "RPackages.csv", row.names = F)
