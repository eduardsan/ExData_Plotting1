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

## fix Times's dates
for(i in seq_along(data$Time)) {
  date(data$Time[i]) <- data$Date[i]
}

png("plot3.png")

with(data, plot(Time, Sub_metering_1, type = "l",
     xlab = NA, 
     ylab = "Energy sub metering"))

with(data, points(Time, Sub_metering_2, type = "l", col = "red"))
with(data, points(Time, Sub_metering_3, type = "l", col = "blue"))

legend("topright", col = c("black", "blue", "red"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()