dataDir <- "/home/rstudio/largedata/"
dataFileURL <- "https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv"

if (!file.exists(paste(dataDir, "avgpm25.csv", sep=""))) {
    download.file(dataFileURL, destfile = paste(dataDir, "avgpm25.csv", sep=""), method="curl")
}

pollution <- read.csv(paste(dataDir, "avgpm25.csv", sep=""), colClasses = c("numeric", "character", "factor", "numeric", "numeric"))

summary(pollution$pm25)

#boxplot
boxplot(pollution$pm25, col = "blue")
abline(h=12)

#histogram
hist(pollution$pm25, col = "green", breaks=20)
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)
rug(pollution$pm25)

#barplot
barplot(table(pollution$region), col = "wheat", main = "Number of Counties in Each Region")

#2-D
#side by side boxplots
boxplot(pm25 ~ region, data = pollution, col = "red")

#stcked hist
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

#scatter
with(pollution, plot(latitude, pm25, col=region))
abline(h = 12, lwd = 2, lty = 2)

#multi scatter
par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(subset(pollution, region == "west"), plot(latitude, pm25, main = "West"))
with(subset(pollution, region == "east"), plot(latitude, pm25, main = "East"))

