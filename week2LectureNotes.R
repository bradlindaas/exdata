dataDir <- "/home/rstudio/largedata/"
dataFileURL <- "https://raw.githubusercontent.com/jtleek/modules/master/04_ExploratoryAnalysis/exploratoryGraphs/data/avgpm25.csv"

if (!file.exists(paste(dataDir, "avgpm25.csv", sep=""))) {
    download.file(dataFileURL, destfile = paste(dataDir, "avgpm25.csv", sep=""), method="curl")
}
library(ggplot2)
library(lattice)
library(datasets)
## Simple scatterplot
xyplot(Ozone ~ Wind, data = airquality)
## Convert 'Month' to a factor variable
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))