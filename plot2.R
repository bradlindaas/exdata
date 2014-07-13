## ExData Course Project 2
## plot2.R
## Generates plot2.png

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

## Data Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.

NEI <- subset(NEI, fips == 24510)
data <- ddply(NEI,c("year"),summarize,sum=sum(Emissions))
data$sum <- data$sum/1000 # make units better for plotting
fit <- lm(data$sum ~ data$year)

## base plotting system
png(filename = "plot2.png", width = 480, height = 480, units = "px")
par(las=1)
plot(
    data$year,
    data$sum, 
    type="n", 
    ylim=c(0,max(data$sum)),
    main="Trend in Emmissions for Baltimore City, MD",
    ylab="Total Emissions of PM2.5 (thousands of tons)",
    xlab="Year"
)
lines(data$year, data$sum)
abline(fit, col="red")
dev.off()