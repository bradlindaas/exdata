## ExData Course Project 2
## Plot 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

library(plyr)

## set location to files 
dataDir <- "/home/rstudio/largedata/"

## check for source file, download if it doesn't exist
dataFileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists(paste(dataDir, "summarySCC_PM25.rds", sep="")) | !file.exists(paste(dataDir, "Source_Classification_Code.rds", sep=""))) {
    download.file(dataFileURL, destfile = paste(dataDir, "exdata-data-NEI_data.zip", sep=""), method="curl")
    unzip(paste(dataDir, "exdata-data-NEI_data.zip", sep=""), exdir=dataDir)
}

## read data from file
NEI <- readRDS(paste(dataDir, "summarySCC_PM25.rds", sep=""))
SCC <- readRDS(paste(dataDir, "Source_Classification_Code.rds", sep=""))

NEI$year <- (as.factor(NEI$year))
data <- ddply(NEI,c("year"),summarize,sum=sum(Emissions))
fit <- lm(data$sum ~ as.Date(data$year, format="%Y"))
par(las=0)
plot(
    as.Date(data$year, format="%Y"),
    data$sum, 
    type="n", 
    ylim=c(0,max(data$sum)),
    main="Trend in Emmissions",
    ylab="Total Emissions",
    xlab="Year"
)
lines(as.Date(data$year, format="%Y"), data$sum)
abline(fit, col="red")


