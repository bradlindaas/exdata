## ExData Course Project 2
## plot3.R
## Generates plot3.png

library(plyr)
library(ggplot2)

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

## Data Question 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? Which have seen increases in emissions 
# from 1999–2008? Use the ggplot2 plotting system to make a plot answer this 
# question.

NEI <- subset(NEI, fips == 24510)
NEI <- transform(NEI, type=as.factor(type), year=as.factor(year))
data <- ddply(NEI,c("year", "type"),summarize,sum=sum(Emissions))
## ggplot2 plotting system
png(filename = "plot3.png", width = 780, height = 480, units = "px")

g <- qplot(year, sum, data=data, facets= . ~ type)
g + 
    geom_smooth(aes(group=type), method="lm") + 
    labs(title = "Trend in Emmissions for Baltimore City, MD") + 
    labs(x = "Year") + 
    labs(y = "Total Emmissions PM2.5")

dev.off()
