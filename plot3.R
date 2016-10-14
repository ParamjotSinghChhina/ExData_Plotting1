#clear workspace and load libraries
rm(list=ls())
library(lubridate)
library(dplyr)

# Read data into a dataframe and convert dates and times
all.Data <- read.csv("household_power_consumption.txt",sep = ";", stringsAsFactors = FALSE,na.strings = "?")
all.Data$Date <- paste(all.Data$Date,all.Data$Time)
all.Data$Date <- dmy_hms(all.Data$Date)

# Extract Feb-01-2007 and Feb-02-2007 data and clean
filter.Data <- filter(all.Data,(year(Date)==2007 & month(Date)==2) & ((mday(Date)==1)|(mday(Date)==2)))
filter.Data[,c(3:9)] <- lapply(filter.Data[,c(3:9)],as.numeric)
filter.Data  <- select(filter.Data, -Time)

#Plot 3
# Start png graphics device
png ("plot3.png", height=480,width = 480,units = "px")

#plot
with(filter.Data,plot(Date,Sub_metering_1, type="n",xlab="",ylab="Energy sub metering"))
with(filter.Data,points(Date,Sub_metering_1, type="l"))
with(filter.Data,points(Date,Sub_metering_2, type="l",col = "red"))
with(filter.Data,points(Date,Sub_metering_3, type="l",col = "blue"))
legend("topright", lty = 1,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Turn off png graphics device
dev.off()

