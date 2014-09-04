## plot3.R
## Generates plot3.png

## set location to files 
dataDir <- "/home/rstudio/largedata/"
dataFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## check for source file, download if it doesn't exist
if (!file.exists(paste(dataDir, "household_power_consumption.txt", sep=""))) {
    download.file(dataFileURL, destfile = paste(dataDir, "power.zip", sep=""), method="curl")
    unzip(paste(dataDir, "power.zip", sep=""), exdir=dataDir)
}

## read data from file
power <- read.table(
    paste(dataDir, "household_power_consumption.txt", sep=""), 
    sep=";", 
    header=T, 
    na.strings = "?"
)

## create a datetime column
power$DateTime <- strptime (
    paste(power$Date, power$Time, sep = " "),
    "%d/%m/%Y %H:%M:%S"
)

## subset the dataframe for the target dates 
power <- power[power$DateTime >= as.POSIXct("2007-02-01") & power$DateTime < as.POSIXct("2007-02-03"),]

## plot 3

png(filename = "plot3.png", width = 480, height = 480, units = "px")

plot (
    power$DateTime,
    power$Sub_metering_1,
    type="n",
    xlab="",
    ylab="Energy sub metering"
)
lines (
    power$DateTime,
    power$Sub_metering_1,
)
lines (
    power$DateTime,
    power$Sub_metering_2,
    col="red"
)
lines (
    power$DateTime,
    power$Sub_metering_3,
    col="blue"
)
legend(
    "topright", 
    c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
    lty=c(1,1),
    col=c("black","red", "blue")
)

dev.off()