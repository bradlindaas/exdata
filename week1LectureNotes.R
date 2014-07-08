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

#PLOTTING SYSTEMS

#base system
library(datasets)
data(cars)
with(cars, plot(speed, dist))

#lattice
library(lattice)
state <- data.frame(state.x77, region = state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4, 1))

#ggplot2
library(ggplot2)
data(mpg)
qplot(displ, hwy, data = mpg)

#BASE

#basic
library(datasets)
hist(airquality$Ozone) ## Draw a new plot

with(airquality, plot(Wind, Ozone))

airquality <- transform(airquality, Month = factor(Month))
boxplot(Ozone ~ Month, airquality, xlab = "Month", ylab = "Ozone (ppb)")

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", type = "n"))
with(subset(airquality, Month == 5), points(Wind, Ozone, col = "blue"))
with(subset(airquality, Month != 5), points(Wind, Ozone, col = "red"))
legend("topright", pch = 1, col = c("blue", "red"), legend = c("May", "Other Months"))

with(airquality, plot(Wind, Ozone, main = "Ozone and Wind in New York City", pch = 20))
model <- lm(Ozone ~ Wind, airquality)
abline(model, lwd = 2)

par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(airquality, {
    plot(Wind, Ozone, main = "Ozone and Wind")
    plot(Solar.R, Ozone, main = "Ozone and Solar Radiation")
    plot(Temp, Ozone, main = "Ozone and Temperature")
    mtext("Ozone and Weather in New York City", outer = TRUE)
})

#Demo of base plot
x <- rnorm(1000)
y <- rnorm(1000)
plot(x,y, pch=20)
fit <- lm(x~y)
abline(fit, lwd=3,col="red")
