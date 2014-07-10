dataDir <- "/home/rstudio/largedata/"
dataFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(paste(dataDir, "household_power_consumption.txt", sep=""))) {
    download.file(dataFileURL, destfile = paste(dataDir, "power.zip", sep=""), method="curl")
    unzip(paste(dataDir, "power.zip", sep=""), exdir=dataDir)
}

## the 'power' dataframe is 79Mb in memory, but took 348Mb to load
## for now, let's make the power object smaller using nrows
power <- read.table(paste(dataDir, "household_power_consumption.txt", sep=""), 
                    sep=";", header=T, na.strings = "?", nrows=10000)
## merge date and time together into a new column. Or should I convert in place?
power$DateTime <- strptime(paste(power$Date, power$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
