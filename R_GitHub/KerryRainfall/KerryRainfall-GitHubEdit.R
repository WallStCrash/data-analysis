# Author: @WallStCrash
#

library(tidyverse)
library(forecast)

# Clear global environment
rm(list=ls())

# Set working directory to the dir *containing* the <KerryRainfall.csv> file
wd <- "C:/Users/Username/Directory"
setwd(wd)
getwd()


file_path_extension <- paste(wd,"KerryRainfall.csv")
file_path <- gsub(" ", "", file_path_extension)


# Read in file and check all okay, change the name of column 2 to "Year"
KerryRainfall <- read.csv(file_path)
colnames(KerryRainfall)[1] <- "Year"
str(KerryRainfall)

KerryTS <- ts(KerryRainfall$Rainfall, start=1990, end=2019, 1)
plot(KerryTS)

# Plot the time series data
ggplot(data = KerryRainfall, aes(y=Rainfall, x=Year), size=10) +
  geom_line(col="Green") + geom_point(col="Gold") + geom_smooth() +
#  geom_hline(yintercept=mean(KerryRainfall$Rainfall), col="Blue", size=0.75) +
  theme_dark() +
  ggtitle("Annual Rainfall, Valentia Observatory, Co. Kerry") +
  ylab("Rainfall (mm)") + xlab("Years\n(1990 - 2019)")


# What will rain be in 2020 ?
FutureRain <- forecast(KerryTS, 5)
plot(FutureRain)
