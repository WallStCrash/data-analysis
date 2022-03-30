# Clear out the global environment
rm(list=ls())

# Explicitly change working directory at the top of script
setwd("C:/Users/etc...")

# Load in the .csv files containing the OHLC data
ftse_raw <- read.csv("ftse.csv")
cable_raw <- read.csv("cable.csv")

# Now able to begin the EDA and have the raw data saved to memory
head(ftse_raw)
head(cable_raw)

# Amend the data sets to be same length, only want common dates in subsets
common_dates <- intersect(ftse_raw$Date, cable_raw$Date)
ftse <- subset(ftse_raw, ftse_raw$Date %in% common_dates)
cable <- subset(cable_raw, cable_raw$Date %in% common_dates)

ftse_close <- ftse$Close
cable_close <- cable$Close

# Look at volatility, average value over period, ratio for FTSE
ftse_sigma = sd(ftse_close)
ftse_mu = mean(ftse_close)
ftse_vol_to_mean = (ftse_sigma/ftse_mu)
ftse_sigma
ftse_mu
ftse_vol_to_mean

# Look at volatility, average value over period, ratio for CABLE
cable_sigma = sd(cable_close)
cable_mu = mean(cable_close)
cable_vol_to_mean = (cable_sigma/cable_mu)
cable_sigma
cable_mu
cable_vol_to_mean

# Plot regression line on our scatter plot
require(stats)
reg <- lm(ftse_close ~ cable_close)

# Optically look at correlation via scatter plot
plot(cable_close, ftse_close, pch=19, col="Green")
abline(h = ftse_mu, col="blue")
abline(v = cable_mu, col="blue")
abline(reg, col = "darkblue", lty=2, lwd=3)

# Conclusion: Strong GBPUSD acts as a source of gravity for FTSE 100 index
# Physical interpretation: many FTSE 100 companies have significant overseas
# operations, therefore transactions conducted in USD but reporting is in GBP
# so strong GBPUSD weakens reported Earnings, lowers profitability ratios etc
# so if P/E multiple stays same, stock will trade at lower price 
