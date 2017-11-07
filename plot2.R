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

png("plot2.png")

plot(data$Time, data$Global_active_power, type = "l",
     xlab = NA, 
     ylab = "Global Active Power (kilowatts)")


dev.off()