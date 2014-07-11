dataDir <- "/home/rstudio/largedata/"
dataFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(paste(dataDir, "household_power_consumption.txt", sep=""))) {
    download.file(dataFileURL, destfile = paste(dataDir, "power.zip", sep=""), method="curl")
    unzip(paste(dataDir, "power.zip", sep=""), exdir=dataDir)
}
power <- read.table(
    paste(dataDir, "household_power_consumption.txt", sep=""), 
    sep=";", 
    header=T, 
    na.strings = "?"
)
power$DateTime <- strptime (
    paste(power$Date, power$Time, sep = " "),
    "%d/%m/%Y %H:%M:%S"
)
power <- power[
    power$DateTime >= as.POSIXct("2007-02-01") & 
    power$DateTime < as.POSIXct("2007-02-03"),
]
#plot 1
hist (
    power$Global_active_power, 
    col="red", 
    main="Global Active Power", 
    xlab="Global Active Power (kilowatts)"
)
#plot2
plot (
    power$DateTime,
    power$Global_active_power,
    type="n",
    xlab="",
    ylab="Global Active Power (kilowatts)"
)
lines (
    power$DateTime,
    power$Global_active_power,
)
#plot 3
plot (
    power$DateTime,
    power$Sub_metering_1,
    type="n",
    xlab="",
    ylab="Energy Sub Metering"
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
# plot 4
plot (
    power$DateTime,
    power$Voltage,
    type="n",
    xlab="datetime",
    ylab="Voltage"
)
lines (
    power$DateTime,
    power$Voltage,
)
# plot5
plot (
    power$DateTime,
    power$Global_reactive_power,
    type="n",
    xlab="datetime",
    ylab="Global_reactive_power"
)
lines (
    power$DateTime,
    power$Global_reactive_power,
)
