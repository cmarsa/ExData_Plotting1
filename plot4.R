
# plot4.R
# load data
library(tidyverse)
library(lubridate)

# read data
power_consumption <- read_delim('data/household_power_consumption.txt', delim = ';', skip = 0)

# change date format
power_consumption <- power_consumption |>
    mutate(Date = as_date(Date, format='%d/%m/%Y'))

# filter data
power_consumption <- power_consumption |>
    filter(month(Date) == 2 &
               day(Date) %in% c(1, 2) &
               year(Date) == 2007)

# setting Global active power to numeric data type
power_consumption <- power_consumption |>
    mutate(Global_active_power = as.numeric(Global_active_power))

# plot4
with(power_consumption, {
    png(filename = "plot4.png")
    par(mfrow = c(2, 2))
    
    y <- power_consumption$Global_active_power
    x <- strptime(paste(power_consumption$Date, power_consumption$Time), "%Y-%m-%d %H:%M:%S")
    plot(x, y, type = "l", ylab = "Global Active Power", xlab = "")
    
    y <- power_consumption$Voltage
    x <- strptime(paste(power_consumption$Date, power_consumption$Time), "%Y-%m-%d %H:%M:%S")
    plot(x, y, type = "l", ylab = "Voltage", xlab = "datetime")
    
    x <- strptime(paste(power_consumption$Date, power_consumption$Time), "%Y-%m-%d %H:%M:%S")
    plot(x, power_consumption$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
    lines(x, power_consumption$Sub_metering_1, col = "black")
    lines(x, power_consumption$Sub_metering_2, col = "red")
    lines(x, power_consumption$Sub_metering_3, col = "blue")
    legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    y <- power_consumption$Global_reactive_power
    x <- strptime(paste(power_consumption$Date, power_consumption$Time), "%Y-%m-%d %H:%M:%S")
    plot(x, y, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
    
    dev.off()
    
})
