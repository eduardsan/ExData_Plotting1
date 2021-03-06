library(lubridate)

data <- read.table("./data/household_power_consumption.txt", 
                   header = FALSE, sep = ";", na.strings = "?", 
                   col.names = c("Date", "Time", "Global_active_power",
                                 "Global_reactive_power", "Voltage", 
                                 "Global_intensity", "Sub_metering_1", 
                                 "Sub_metering_2", "Sub_metering_3"),
                   colClasses=c("character", "character", "numeric", "numeric", "numeric",
                                "numeric", "numeric", "numeric", "numeric"),
                   skip = 66637, nrows = 2880, stringsAsFactors = FALSE)

## convert dates and times
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
date(data$Time) <- data$Date

png("plot4.png")

par(mfrow = c(2, 2))

## top left
with(data, plot(Time, Global_active_power, type = "l",
     xlab = NA, 
     ylab = "Global Active Power"))

## top right
with(data, plot(Time, Voltage, type = "l",
                xlab = "datetime"))

## bottom left
with(data, plot(Time, Sub_metering_1, type = "l",
                xlab = NA, 
                ylab = "Energy sub metering"))

with(data, points(Time, Sub_metering_2, type = "l", col = "red"))
with(data, points(Time, Sub_metering_3, type = "l", col = "blue"))

legend("topright", col = c("black", "red", "blue"), lty = 1, bty="n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## bottom right
with(data, plot(Time, Global_reactive_power, type = "l",
                xlab = "datetime"))

dev.off()