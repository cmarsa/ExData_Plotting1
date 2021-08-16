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

with(power_consumption, {
    png(filename = "plot2.png")
    y <- power_consumption$Global_active_power
    x <- strptime(paste(power_consumption$Date, power_consumption$Time), "%Y-%m-%d %H:%M:%S")
    plot(x, y, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
    dev.off()
})
