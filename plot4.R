## ExData Course Project 2
## plot4.R
## Generates plot4.png

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

## Data Question 4
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

coal <- as.character(SCC[(grepl("[Cc]oal", SCC$SCC.Level.Four)),1])
NEI <- subset(NEI, SCC %in% coal)
data <- ddply(NEI,c("year"),summarize,sum=sum(Emissions))
data$sum <- data$sum/1000000 # make units better for plotting

## ggplot2 plotting system
png(filename = "plot4.png", width = 480, height = 480, units = "px")

g <- qplot(year, sum, data=data)
g + 
    geom_smooth(aes(), method="lm") + 
    labs(title = "Trend in Emmissions from 'Coal' sources") + 
    labs(x = "Year") + 
    labs(y = "Total Emmissions PM2.5 (millions tons)") +
    coord_cartesian(ylim = c(0, 1.5*max(data$sum))) 

dev.off()