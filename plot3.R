# plot3.R
# plot1.R
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

# plot3
with(power_consumption, {
    png(filename = "plot3.png")
    x <- strptime(paste(power_consumption$Date, power_consumption$Time), "%Y-%m-%d %H:%M:%S")
    plot(x, power_consumption$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
    lines(x, power_consumption$Sub_metering_1, col = "black")
    lines(x, power_consumption$Sub_metering_2, col = "red")
    lines(x, power_consumption$Sub_metering_3, col = "blue")
    legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    dev.off()
})
