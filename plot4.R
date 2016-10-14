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

#Plot 4
# Start png graphics device
png ("plot4.png", height=480,width = 480,units = "px")

par(mfrow=c(2,2))
#subplot1
with(filter.Data,plot(Date,Global_active_power, type="l",xlab ="", ylab = "Global Active Power"))

#subplot2
with(filter.Data,plot(Date,Voltage, type="l",xlab ="datetime", ylab = "Voltage"))

#subplot3
with(filter.Data,plot(Date,Sub_metering_1, type="n",xlab="",ylab="Energy sub metering"))
with(filter.Data,points(Date,Sub_metering_1, type="l"))
with(filter.Data,points(Date,Sub_metering_2, type="l",col = "red"))
with(filter.Data,points(Date,Sub_metering_3, type="l",col = "blue"))
legend("topright", lty = 1,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#subplot4
with(filter.Data,plot(Date,Global_reactive_power, type="l",xlab ="datetime", ylab = "Global_reactive_power"))

# Turn off png graphics device
dev.off()
