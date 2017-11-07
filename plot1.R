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

png("plot1.png")

hist(data$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     main = "Global Active Power")

dev.off()

