dataDir <- "/home/rstudio/largedata/"
dataFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(paste(dataDir, "household_power_consumption.txt", sep=""))) {
    download.file(dataFileURL, destfile = paste(dataDir, "power.zip", sep=""), method="curl")
    unzip(paste(dataDir, "power.zip", sep=""), exdir=dataDir)
}

